---
aliases: []
author: acampos
date: 2026-11-18
description: Instalación de la suite clásica de herramientas de red net-tools (netstat, ifconfig, route, arp) en instalaciones mínimas de Ubuntu Server.
draft: false
enableToc: true
publish: true
tags:
  - linux
  - ubuntu
  - networking
  - net-tools
  - troubleshooting
title: "Instalación de netstat (net-tools)"
---

En distribuciones Linux modernas y especialmente en instalaciones **Ubuntu Server (Minimal)**, el paquete clásico **`net-tools`** ya no se instala por defecto. Desde hace varios años, las distribuciones han migrado hacia la suite moderna **`iproute2`** (`ss`, `ip addr`, `ip route`, `ip neigh`), que se comunica directamente con el kernel de Linux mediante sockets `netlink` en lugar de leer y parsear ficheros secuenciales de `/proc/net/*`.

No obstante, muchas guías de administración, scripts de auditoría y flujos de diagnóstico como la [[00-coredns-host-prepare|preparación del puerto 53 para CoreDNS]] utilizan la sintaxis tradicional de **`netstat`**. Para disponer de `netstat` en el sistema, debemos instalar explícitamente el paquete **`net-tools`**.

> [!note] ¿Qué utilidades incluye el paquete `net-tools`?
> - **`netstat`**: Muestra conexiones de red activas, puertos en escucha (`LISTEN`), tablas de enrutamiento y estadísticas de interfaces.
> - **`ifconfig`**: Configuración e inspección clásica de interfaces de red (sustituido en `iproute2` por `ip a` / `ip link`).
> - **`route`**: Visualización y manipulación de la tabla de enrutamiento IP (sustituido por `ip r`).
> - **`arp`**: Gestión de la caché ARP del sistema (sustituido por `ip neigh`).
> - **`hostname` / `nisdomainname`**: Consulta y modificación del nombre de red del sistema.

---

## 1. Proceso de instalación

1. Actualiza la lista de paquetes e instala `net-tools`:

```bash
sudo apt update && sudo apt install -y net-tools
```

```output
Installing:
  net-tools

Summary:
  Upgrading: 0, Installing: 1, Removing: 0, Not Upgrading: 2
  Download size: 151 kB
  Space needed: 680 kB / 108 GB available

Get:1 http://es.archive.ubuntu.com/ubuntu resolute/main amd64 net-tools amd64 2.10-2ubuntu1 [151 kB]
Fetched 151 kB in 0s (1381 kB/s)
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 79, <STDIN> line 1.)
debconf: falling back to frontend: Readline
Selecting previously unselected package net-tools.
(Reading database ... 90210 files and directories currently installed.)
Preparing to unpack .../net-tools_2.10-2ubuntu1_amd64.deb ...
Unpacking net-tools (2.10-2ubuntu1) ...
Setting up net-tools (2.10-2ubuntu1) ...
Scanning processes...
Scanning candidates...
Scanning processor microcode...
Scanning linux images...

Running kernel seems to be up-to-date.

The processor microcode seems to be up-to-date.

Restarting services...

Service restarts being deferred:
 /etc/needrestart/restart.d/dbus.service
 systemctl restart getty@tty1.service
 systemctl restart networkd-dispatcher.service
 systemctl restart systemd-logind.service
 systemctl restart unattended-upgrades.service

No containers need to be restarted.

User sessions running outdated binaries:
 acampos @ user manager: (sd-pam)[1144]

No VM guests are running outdated hypervisor (qemu) binaries on this host.
```

2. Verifica que `netstat` está disponible comprobando los puertos TCP y UDP en escucha:

```bash
sudo netstat -tulnp
```

## 2. Parámetros más utilizados de `netstat` (y su equivalencia con `ss`)

Cuando inspeccionamos qué demonios o contenedores están ocupando un puerto en el servidor anfitrión (por ejemplo, `systemd-resolved` en el puerto `53` o `Traefik` en `80`/`443`), combinamos las siguientes banderas:

| Bandera | Significado |
| :---: | :--- |
| **`-t`** | Muestra únicamente sockets **TCP**. |
| **`-u`** | Muestra únicamente sockets **UDP** (imprescindible para DNS en el puerto `53`). |
| **`-l`** | Muestra solo los sockets que están en estado de escucha (**`LISTEN`**). |
| **`-n`** | Muestra direcciones IP y números de puerto en formato **numérico** (evita que el comando se quede bloqueado intentando hacer resolución DNS inversa de cada IP). |
| **`-p`** | Muestra el **PID y el nombre del programa/proceso** propietario del socket (requiere ejecutar el comando con `sudo`). |

> [!tip] Equivalencia directa con `ss` (`iproute2`)
> Si en algún momento accedes a un servidor o contenedor donde no puedes instalar `net-tools`, el comando **`ss`** acepta exactamente las mismas banderas que `netstat`:
> - `sudo netstat -tulnp` $\Longleftrightarrow$ `sudo ss -tulnp`