---
aliases:
date: 2024-07-31
description: Permite anular la configuración de MAC
draft: false
publish: true
tags:
  - linux
  - capabilities
  - security
  - mac
title: CAP_MAC_OVERRIDE
---

### Descripción de CAP_MAC_OVERRIDE

La capability `CAP_MAC_OVERRIDE` permite anular la configuración de MAC. También implementada para el LSM Smack.

### Casos de Uso Comunes

- Procesos que necesitan operar fuera de las restricciones impuestas por las políticas de control de acceso obligatorio, como en ciertas tareas de administración o recuperación.

### Llamadas al Sistema Asociadas

Esta capability está relacionada con las interfaces específicas del LSM Smack.

### Implicaciones de Seguridad

Permitir la anulación de MAC puede debilitar las políticas de seguridad del sistema.

### Comandos y Herramientas Relacionadas

- Herramientas que interactúan con las políticas de Smack.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.

### Referencias

- [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
