---
aliases:
date: 2024-07-31
description: Permite habilitar y deshabilitar la auditoría del kernel
tags:
  - linux
  - capabilities
  - security
  - audit
title: CAP_AUDIT_CONTROL
---

### Descripción de CAP_AUDIT_CONTROL

La capability `CAP_AUDIT_CONTROL` permite habilitar y deshabilitar la auditoría del kernel, cambiar las reglas del filtro de auditoría y recuperar el estado y las reglas de filtrado de la auditoría.1

### Casos de Uso Comunes

- Herramientas de administración del sistema que necesitan configurar la auditoría del kernel.
- Procesos de seguridad que requieren monitorear la actividad del sistema a través de los logs de auditoría.

### Llamadas al Sistema Asociadas

Esta capability está relacionada con las llamadas al sistema utilizadas para interactuar con el subsistema de auditoría de Linux, como auditctl y las interfaces relacionadas con netlink sockets para la auditoría.4

### Implicaciones de Seguridad

Otorgar esta capability permite un control total sobre la configuración de la auditoría, lo que podría ser mal utilizado para ocultar actividades maliciosas si cae en manos equivocadas.

### Comandos y Herramientas Relacionadas

- auditctl: Utilidad para controlar el demonio de auditoría del kernel.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.1

### Referencias

- [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)