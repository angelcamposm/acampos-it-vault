---
author: acampos
date: 2026-11-18
description: Despliegue de Project Quay (Red Hat Quay) con PostgreSQL y Redis en red aislada, publicado detrás de Traefik v3 con terminación TLS.
draft: false
enableToc: true
publish: true
tags:
  - quay
  - oci-registry
  - postgresql
  - redis
  - docker
  - hla
title: 08. Project Quay
---

## 1. High Level Architecture

**Project Quay** (el proyecto upstream de _Red Hat Quay_) es un registro empresarial de imágenes de contenedor y artefactos OCI. Sigue una arquitectura _stateless_ en su contenedor principal (`quay`), separando estrictamente:

- **Metadatos relacionales** (organizaciones, repositorios, etiquetas, tokens robot y auditoría) en una base de datos **PostgreSQL** con la extensión `pg_trgm`.
- **Estado efímero y notificaciones** (eventos de _build_, bloqueos y sesiones en tiempo real) en **Redis**.
- **Capas binarias de imágenes (*blobs*)** en el volumen de almacenamiento `/datastorage` montado en disco local.

Los contenedores de PostgreSQL y Redis residen exclusivamente en la red privada aislada `quay-internal` (inaccesibles desde fuera), mientras que el contenedor de Quay se conecta tanto a `quay-internal` como a `traefik-proxy` para recibir el tráfico HTTPS desde [[01-traefik|Traefik v3]] (`https://quay.acampos.local` -> `HTTP 8080`).

```mermaid
flowchart TB
    user["Ingeniero / Cluster\n(Web y docker/podman login, push, pull en quay.acampos.local)"]

    subgraph host["Host nuc7i5 (192.168.10.104)"]
        subgraph proxy_net["Red Compartida: traefik-proxy"]
            traefik["Traefik v3 (TCP 443)\nTerminación TLS externa"]
            quay["Project Quay (TCP 8080)\nAPI Registry v2 y UI Web (HTTP interno)"]
        end

        subgraph quay_net["Red Aislada: quay-internal"]
            pg_quay[("PostgreSQL 16 (TCP 5432)\nOrganizaciones, etiquetas, permisos y auditoría")]
            redis_quay[("Redis 7 (TCP 6379)\nEventos de build y estado de sesiones")]
            vol_quay[("Volúmenes en Disco (/opt/quay)\n./config (config.yaml) y ./storage (/datastorage)")]
        end
    end

    user -->|"1. Petición HTTPS (TLS 443)"| traefik
    traefik -->|"2. Enruta tráfico (HTTP 8080)"| quay
    quay -->|"Lee/Escribe metadatos (TCP 5432)"| pg_quay
    quay -->|"Caché y notificaciones (TCP 6379)"| redis_quay
    quay -->|"Almacena capas de imágenes"| vol_quay
```

---

## 2. Requerimientos previos

- [[00-coredns|00. CoreDNS]], [[00-step-ca|00. Smallstep step-ca]] y [[01-traefik|01. Traefik v3]] operativos.
- El daemon de Docker del host y de los clientes debe confiar en `/opt/traefik/root_ca.crt` (instalado mediante `sudo update-ca-certificates`).

---

## 3. Configuraciones

Crea la estructura de directorios en `/opt/quay` y ajusta los permisos para que los contenedores sin privilegios (`UID 1001` en Quay) puedan escribir en el almacenamiento de capas:

```bash
sudo mkdir -p /opt/quay/{config,storage,postgres}
```

```bash
sudo chown -R $USER:$USER /opt/quay
```

```bash
chmod -R 777 /opt/quay/storage
```

### 3.1. Configuración de Quay (`/opt/quay/config/config.yaml`)

Crea el fichero `/opt/quay/config/config.yaml` indicando que la terminación TLS (`PREFERRED_URL_SCHEME: https`) se realiza en el proxy inverso externo (`SERVER_HOSTNAME: quay.acampos.local`):

```yaml
SERVER_HOSTNAME: quay.acampos.local
PREFERRED_URL_SCHEME: https
EXTERNAL_TLS_TERMINATION: true

DB_URI: postgresql://quayuser:QuayDbPassSegura123!@quay-postgres:5432/quay
DB_CONNECTION_ARGS:
  autorollback: true
  threadlocals: true

BUILDLOGS_REDIS:
  host: quay-redis
  port: 6379

USER_EVENTS_REDIS:
  host: quay-redis
  port: 6379

DISTRIBUTED_STORAGE_CONFIG:
  default:
    - LocalStorage
    - storage_path: /datastorage/registry
DISTRIBUTED_STORAGE_DEFAULT_LOCATIONS: []
DISTRIBUTED_STORAGE_PREFERENCE:
  - default

AUTHENTICATION_TYPE: Database
FEATURE_USER_INITIALIZE: true
FEATURE_USER_CREATION: true
SUPER_USERS:
  - acampos

SECRET_KEY: "cambia_esta_clave_hexadecimal_de_64_caracteres_1122334455667788"
DATABASE_SECRET_KEY: "cambia_esta_otra_clave_secreta_de_base_de_datos_9988776655443322"
```

### 3.2. Archivo Compose (`/opt/quay/compose.yml`)

```yaml
services:
  quay-postgres:
    image: postgres:16-alpine
    container_name: quay-postgres
    environment:
      - POSTGRES_USER=quayuser
      - POSTGRES_PASSWORD=QuayDbPassSegura123!
      - POSTGRES_DB=quay
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U quayuser -d quay"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - quay-internal
    restart: unless-stopped
    volumes:
      - ./postgres:/var/lib/postgresql/data

  quay-redis:
    image: redis:7-alpine
    container_name: quay-redis
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - quay-internal
    restart: unless-stopped

  quay:
    image: quay.io/projectquay/quay:v3.12.0
    container_name: quay
    depends_on:
      quay-postgres:
        condition: service_healthy
      quay-redis:
        condition: service_healthy
    labels:
      - traefik.enable=true
      - traefik.docker.network=traefik-proxy
      - traefik.http.routers.quay.rule=Host(`quay.acampos.local`)
      - traefik.http.routers.quay.entrypoints=websecure
      - traefik.http.routers.quay.tls=true
      - traefik.http.routers.quay.tls.certresolver=stepca
      - traefik.http.services.quay.loadbalancer.server.port=8080
    networks:
      - quay-internal
      - traefik-proxy
    restart: unless-stopped
    volumes:
      - ./config:/conf/stack:ro
      - ./storage:/datastorage

networks:
  quay-internal:
  traefik-proxy:
    external: true
```

## 4. Despliegue y Verificación

1. Levanta primero la base de datos PostgreSQL y habilita la extensión `pg_trgm` requerida por Project Quay:

```bash
cd /opt/quay
```

```bash
docker compose up -d quay-postgres quay-redis
```

```bash
docker exec quay-postgres psql -U quayuser -d quay -c "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
```

2. Levanta el servicio principal de Project Quay (ejecutará automáticamente las migraciones de esquema Alembic en el primer inicio):

```bash
docker compose up -d quay
```

3. Verifica la interfaz web en `https://quay.acampos.local`, crea el usuario superadministrador `acampos` y prueba el flujo de autenticación y subida de imágenes desde la terminal:

```bash
docker login quay.acampos.local
```

```bash
docker pull alpine:latest
```

```bash
docker tag alpine:latest quay.acampos.local/acampos/alpine:latest
```

```bash
docker push quay.acampos.local/acampos/alpine:latest
```