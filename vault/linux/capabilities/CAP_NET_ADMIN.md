---
aliases:
date: 2024-07-31
description: Permite realizar diversas operaciones relacionadas con la red
draft: false
publish: true
tags:
  - linux
  - capabilities
  - network
  - network_management
title: CAP_NET_ADMIN
---

### Descripción de CAP_NET_ADMIN

La capability `CAP_NET_ADMIN` permite realizar diversas operaciones relacionadas con la red, como configurar interfaces, administrar el firewall IP, el enmascaramiento y la contabilidad, modificar tablas de enrutamiento, etc..1

### Casos de Uso Comunes

- Herramientas de configuración de red como ip, ifconfig.
- Software de firewall como iptables o nftables.
- Servicios de gestión de red.

### Llamadas al Sistema Asociadas

Esta capability puede estar relacionada con la llamada al sistema setsockopt.4

### Implicaciones de Seguridad

Otorgar esta capability permite un control total sobre la configuración de la red, lo que debe hacerse con precaución.

### Comandos y Herramientas Relacionadas

- ip, ifconfig, route, iptables, nftables.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.1

### Referencias

- [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
