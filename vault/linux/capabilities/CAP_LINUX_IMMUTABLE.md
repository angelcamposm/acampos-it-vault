---
aliases:
date: 2024-07-31
description: Permite establecer los flags FS_APPEND_FL y FS_IMMUTABLE_FL en inodos
draft: false
publish: true
tags:
  - linux
  - capabilities
  - security
  - filesystem
title: CAP_LINUX_IMMUTABLE
---

### Descripción de CAP_LINUX_IMMUTABLE

La capability `CAP_LINUX_IMMUTABLE` permite establecer los flags `FS_APPEND_FL` y `FS_IMMUTABLE_FL` en inodos (ver FS_IOC_SETFLAGS(2const)).1

### Casos de Uso Comunes

- Utilidades que necesitan proteger ficheros críticos del sistema contra modificaciones o eliminaciones accidentales o maliciosas.

### Llamadas al Sistema Asociadas

Esta capability está relacionada con la llamada al sistema ioctl_iflags.4

### Implicaciones de Seguridad

Establecer el flag immutable en ficheros importantes puede mejorar la seguridad del sistema.

### Comandos y Herramientas Relacionadas

- chattr: Utilidad para modificar los atributos de los ficheros en un sistema de archivos Linux.
- lsattr: Utilidad para listar los atributos de los ficheros en un sistema de archivos Linux.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.1

### Referencias

- [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
