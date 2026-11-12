---
aliases:
date: 2024-07-31
description: Permite reiniciar el sistema
draft: false
publish: true
tags:
  - linux
  - capabilities
  - system_management
  - restart
title: CAP_SYS_BOOT
---

### Descripción de CAP_SYS_BOOT

La capability `CAP_SYS_BOOT` permite reiniciar el sistema.1

### Casos de Uso Comunes

- Utilidades de apagado y reinicio del sistema.

### Llamadas al Sistema Asociadas

Esta capability está relacionada con llamadas al sistema como kexec_load y reboot.4

### Implicaciones de Seguridad

Permitir a un proceso reiniciar el sistema puede ser disruptivo si se utiliza de forma malintencionada.

### Comandos y Herramientas Relacionadas

- reboot, shutdown.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.1

### Referencias

- [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
