---
aliases:
date: 2024-07-31
description: Permite realizar operaciones de E/S directamente a dispositivos
draft: false
publish: true
tags:
  - linux
  - capabilities
  - e/s
  - devices
title: CAP_SYS_RAWIO
---

### Descripción de CAP_SYS_RAWIO

La capability `CAP_SYS_RAWIO` permite realizar operaciones de E/S directamente a dispositivos (mmap(2) de `/dev/mem`, `/dev/kmem`, `/dev/raw*`, ioctl(2) con comandos de disco).

### Casos de Uso Comunes

- Utilidades de bajo nivel para acceder directamente al hardware, como herramientas de diagnóstico de disco o de memoria.

### Llamadas al Sistema Asociadas

Esta capability puede estar relacionada con llamadas al sistema como ioperm e iopl y el acceso a ficheros de dispositivo como /dev/kmem y /dev/mem.

### Implicaciones de Seguridad

Permitir el acceso directo al hardware puede ser muy peligroso si se abusa de esta capability.

### Comandos y Herramientas Relacionadas

- hdparm, dd.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.

### Referencias

- [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
