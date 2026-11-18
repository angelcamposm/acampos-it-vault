---
aliases: []
author: acampos
date: 2026-11-18
description: Instalación de la utilidad de diagnóstico DNS dig (paquete dnsutils / bind9-dnsutils) en instalaciones mínimas de Ubuntu Server.
draft: false
enableToc: true
publish: true
tags:
  - linux
  - ubuntu
  - dns
  - networking
  - troubleshooting
title: "Instalación de dig (dnsutils)"
---

En las instalaciones mínimas de **Ubuntu Server** (*Ubuntu Minimal*) o en imágenes base de contenedores, las herramientas cliente de diagnóstico DNS de ISC BIND no vienen preinstaladas para reducir el tamaño de la imagen y la superficie de paquetes del sistema base.

Para disponer del comando **`dig`** (*Domain Information Groper*), así como de **`nslookup`** y **`nsupdate`**, es necesario instalar el paquete **`dnsutils`** (un paquete transicional en versiones recientes de Ubuntu que instala `bind9-dnsutils`).

> [!note] ¿Qué utilidades incluye `dnsutils` (`bind9-dnsutils`)?
> - **`dig`**: Herramienta avanzada de línea de comandos para interrogar servidores DNS (registros `A`, `AAAA`, `PTR`, `MX`, `TXT`, `SOA`, `NS`) e inspeccionar tiempos de respuesta y flags del protocolo.
> - **`nslookup`**: Cliente clásico interactivo y no interactivo para consultas DNS rápidas.
> - **`delv`**: Herramienta para validación y diagnóstico de firmas criptográficas **DNSSEC**.
> - **`nsupdate`**: Utilidad para enviar actualizaciones dinámicas de zonas DNS (RFC 2136).

---

## 1. Proceso de instalación

1. Actualiza el índice local de repositorios APT:

```bash
sudo apt update
```

2. Instala el paquete `dnsutils`:

```bash
sudo apt install -y dnsutils
```

3. Verifica que el binario `dig` se ha instalado correctamente consultando su versión:

```bash
dig -v
```

```output
DiG 9.20.24-1ubuntu0.5-Ubuntu
```

## 2. Casos de uso habituales en el laboratorio

Una vez instalado, `dig` es la herramienta principal para verificar nuestro servidor [[01-coredns|CoreDNS]]:

| Comando | Qué comprueba |
| :--- | :--- |
| `dig @192.168.10.104 traefik.acampos.local +short` | Consulta directamente al servidor DNS `192.168.10.104` (saltándose la caché del sistema operativo) y devuelve únicamente la dirección IP resultante (`+short`). |
| `dig @192.168.10.104 -x 192.168.10.104 +short` | Realiza una **consulta inversa (`PTR`)** transformando automáticamente la IP en `104.10.168.192.in-addr.arpa`. |
| `dig @192.168.10.104 acampos.local SOA +multiline` | Muestra el registro `SOA` (*Start of Authority*) formateado en varias líneas para comprobar el número de serie (`Serial`) cargado por CoreDNS. |
| `dig +trace google.com` | Rastrea la delegación DNS completa desde los servidores raíz (`.`) hasta el servidor autoritativo final. |