---
aliases:
date: 2024-07-31
description: Permite emplear características que pueden bloquear la suspensión del sistema
tags:
  - linux
  - capabilities
  - power_management
title: CAP_BLOCK_SUSPEND
---

### Descripción de CAP_BLOCK_SUSPEND

La capability `CAP_BLOCK_SUSPEND` permite emplear características que pueden bloquear la suspensión del sistema (epoll(7) EPOLLWAKEUP, /proc/sys/wake_lock).1

### Casos de Uso Comunes

- Aplicaciones que necesitan evitar que el sistema entre en suspensión durante operaciones críticas.
- Servicios que deben permanecer activos para responder a eventos en tiempo real.

### Llamadas al Sistema Asociadas

Esta capability está relacionada con el uso de epoll_ctl y la interacción con el archivo /proc/sys/wake_lock.4

### Implicaciones de Seguridad

Un proceso malicioso con esta capability podría mantener el sistema activo innecesariamente, consumiendo energía.

### Comandos y Herramientas Relacionadas

- Aplicaciones que utilizan mecanismos de wakelock.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.1

### Referencias

- [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)