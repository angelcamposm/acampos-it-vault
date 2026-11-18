---
author: acampos
date: 2026-11-18
description: Preparación del sistema anfitrión Ubuntu para liberar el puerto 53 ocupado por systemd-resolved y crear la red Docker compartida traefik-proxy antes de desplegar CoreDNS.
draft: false
enableToc: true
publish: true
tags:
  - dns
  - core-dns
  - linux
  - systemd
  - docker
title: "00. CoreDNS: Preparación del host"
---

Usaremos **[CoreDNS](https://coredns.io/)** en Docker actuando como servidor DNS autoritativo para nuestra zona local (`acampos.local`) y como _forwarder_ hacia Internet para el resto de consultas. Antes de levantar el contenedor de [[00-coredns|CoreDNS]], debemos preparar el sistema operativo anfitrión para liberar el puerto `53` y crear la red de Docker compartida.

## 1. Preparación del sistema anfitrión (Puerto 53)

En distribuciones modernas como Ubuntu Server o Desktop, el servicio local `systemd-resolved` levanta un _stub listener_ que ocupa el puerto `53` en las direcciones de loopback (`127.0.0.53:53` y `127.0.0.54:53`). Esto impide que el contenedor de CoreDNS pueda enlazar (`bind`) el puerto `53` en todas las interfaces del host (`0.0.0.0:53`).

Podemos comprobar qué proceso ocupa el puerto `53` ejecutando:

```bash
netstat -tuln
```

```output{3,5,17,18}
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 127.0.0.54:53           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:8000            0.0.0.0:*               LISTEN
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:443             0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:9000            0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:9443            0.0.0.0:*               LISTEN
tcp6       0      0 :::8000                 :::*                    LISTEN
tcp6       0      0 :::443                  :::*                    LISTEN
tcp6       0      0 :::22                   :::*                    LISTEN
tcp6       0      0 :::80                   :::*                    LISTEN
tcp6       0      0 :::9000                 :::*                    LISTEN
tcp6       0      0 :::9443                 :::*                    LISTEN
udp        0      0 127.0.0.54:53           0.0.0.0:*
udp        0      0 127.0.0.53:53           0.0.0.0:*
udp        0      0 127.0.0.1:323           0.0.0.0:*
udp6       0      0 ::1:323                 :::*
```

> [!note]
> Si hemos realizado una instalación `minimal`, probablemente no tengamos instalada la utilidad `netstat`; podemos instalarla con el paquete [[install-netstat|net-tools]] o usar directamente la herramienta nativa `sudo ss -tulpn | grep :53`.

### 1.1. Liberar el puerto 53 en el host

1. Edita el archivo `/etc/systemd/resolved.conf`:

```bash
sudo nano /etc/systemd/resolved.conf
```

2. Descomenta y modifica las siguientes líneas para desactivar el _stub listener_ local y fijar un servidor DNS temporal de respaldo (para que el host no pierda resolución mientras desplegamos CoreDNS):

```toml
[Resolve]
DNS=1.1.1.1 8.8.8.8
DNSStubListener=no
```

3. Reinicia el servicio `systemd-resolved` y actualiza el enlace simbólico de `/etc/resolv.conf` para que apunte directamente al fichero de resolución real en lugar del stub `127.0.0.53`:

```bash
sudo systemctl restart systemd-resolved
```

```bash
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
```

4. **Verificación:** Comprueba que ningún servicio esté escuchando ya en el puerto `53`:

```bash
sudo ss -tulpn | grep :53
```

No debe devolver ninguna línea de salida.

## 2. Creación de la red Docker compartida (`traefik-proxy`)

Todos los servicios de infraestructura del laboratorio ([[00-coredns|CoreDNS]], [[00-step-ca|Smallstep step-ca]], [[01-traefik|Traefik v3]] y [[01-portainer|Portainer CE]]) se comunican entre sí a través de una red puente externa común llamada `traefik-proxy`.

Créala antes de levantar el primer servicio:

```bash
docker network create traefik-proxy
```

Verifica que la red se ha creado correctamente:

```bash
docker network ls | grep traefik-proxy
```

> [!tip] Siguiente paso
> Una vez liberado el puerto `53` y creada la red `traefik-proxy`, continúa con la configuración y despliegue del servicio en [[00-coredns|00. CoreDNS]].
