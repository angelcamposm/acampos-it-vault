---
author: acampos
date: 2026-11-17
description:
draft: false
enableToc: true
publish: true
tags:
  - dns
title: "00. CoreDNS: Preparación del host"
---

Usaremos **[CoreDNS](https://coredns.io/)** en Docker actuando como servidor DNS autoritativo para nuestra zona local y como _forwarder_ hacia Internet para el resto de consultas.

## 1. Preparación del sistema anfitrión (Puerto 53)

En distribuciones modernas como Ubuntu, el servicio `systemd-resolved` ocupa el puerto `53` localmente (`127.0.0.53:53`), lo que impide que el contenedor de CoreDNS pueda vincularse a ese puerto.

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
> Si hemos realizado una instalación `minimal`, probablemente no tengamos instalada la utilidad `netstat`, podemos instalarla con el paquete [[install-netstat|net-tools]]
### 1.1. Liberar el puerto 53 en el host

1. Edita el archivo `/etc/systemd/resolved.conf`:

```bash
sudo nano /etc/systemd/resolved.conf
```

2. Des comenta y modifica las siguientes líneas para desactivar el _stub listener_ local y fijar un DNS temporal de respaldo:

```toml
[Resolve]
DNS=1.1.1.1 8.8.8.8
DNSStubListener=no
```

3. Reinicia el servicio y actualiza el enlace simbólico de `/etc/resolv.conf`:

```bash
sudo systemctl restart systemd-resolved
```

```bash
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
```

- **Verificación:** Ejecuta `sudo ss -tulpn | grep :53`. No debe aparecer ningún proceso escuchando en el puerto `53`.
