---
aliases:
date: 2024-07-31
description: Permite leer el registro de auditoría
tags:
  - linux
  - capabilities
  - security
  - audit
title: CAP_AUDIT_READ
---

### Descripción de CAP_AUDIT_READ

La capability `CAP_AUDIT_READ` permite leer el registro de auditoría a través de un socket netlink multicast.  

### Casos de uso comunes

- Herramientas de análisis de seguridad que necesitan acceder a los logs de auditoría para detectar patrones sospechosos.
- Sistemas de monitorización que recopilan información de auditoría para el cumplimiento normativo.

### Llamadas al Sistema Asociadas

Esta capability se utiliza al leer datos del socket netlink configurado para recibir eventos de auditoría.  

### Implicaciones de seguridad

Permitir la lectura del registro de auditoría puede exponer información sensible sobre la actividad del sistema.

### Comandos y herramientas relacionadas

- Herramientas que interactúan con el subsistema de auditoría a través de netlink sockets.
- `capsh`: Shell con capacidades para pruebas y depuración de capabilities.

### Referencias

- [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)