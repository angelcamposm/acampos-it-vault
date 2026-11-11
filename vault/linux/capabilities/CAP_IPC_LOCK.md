---
aliases:
date: 2024-07-31
description: Permite bloquear memoria
tags:
  - linux
  - capabilities
  - ipc
  - memory
title: CAP_IPC_LOCK
---

### Descripción de CAP_IPC_LOCK

La capability `CAP_IPC_LOCK` permite bloquear memoria (mlock(2), mlockall(2), mmap(2) con MAP_LOCKED).1

### Casos de Uso Comunes

- Aplicaciones que requieren acceso a memoria de baja latencia y necesitan evitar que se intercambie al disco (swapping).
- Bases de datos y otros sistemas de alto rendimiento.

### Llamadas al Sistema Asociadas

Esta capability está relacionada con las llamadas al sistema mlock, mlock2, mlockall y mmap con la opción MAP_LOCKED.4

### Implicaciones de Seguridad

Bloquear grandes cantidades de memoria podría afectar el rendimiento del sistema si se abusa de esta capability.

### Comandos y Herramientas Relacionadas

- Aplicaciones de bases de datos como PostgreSQL o MySQL.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.1

### Referencias

- [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)