---
aliases:
date: 2024-07-31
description: Permite cargar y descargar módulos del kernel
draft: false
publish: true
tags:
  - linux
  - capabilities
  - kernel_modules
title: CAP_SYS_MODULE
---

### Descripción de CAP_SYS_MODULE

La capability `CAP_SYS_MODULE` permite cargar y descargar módulos del kernel.

### Casos de Uso Comunes

- Utilidades como insmod, rmmod o modprobe que gestionan los módulos del kernel.

### Llamadas al Sistema Asociadas

Esta capability está relacionada con llamadas al sistema como init_module y delete_module.

### Implicaciones de Seguridad

La capacidad de cargar módulos en el kernel otorga un control muy alto sobre el sistema y puede ser utilizada para actividades maliciosas.

### Comandos y Herramientas Relacionadas

- insmod, rmmod, modprobe.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.

### Referencias

- [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
