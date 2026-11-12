---
aliases:
date: 2024-07-31
description: Permite realizar operaciones privilegiadas de syslog
draft: false
publish: true
tags:
  - linux
  - capabilities
  - syslog
  - logging
title: CAP_SYSLOG
---

### Descripción de CAP_SYSLOG

La capability `CAP_SYSLOG` permite realizar operaciones privilegiadas de syslog(2).

### Casos de Uso Comunes

- Demonios de syslog como rsyslog o syslog-ng que necesitan leer o borrar el buffer de mensajes del kernel.
    

### Llamadas al Sistema Asociadas

Esta capability está relacionada con la llamada al sistema syslog y la interacción con archivos como /proc/sys/kernel/kptr_restrict.

### Implicaciones de Seguridad

Permitir el acceso privilegiado a syslog puede tener implicaciones para la auditoría y la seguridad del sistema.

### Comandos y Herramientas Relacionadas

- rsyslogd, syslog-ng.
    
- capsh: Shell con capacidades para pruebas y depuración de capabilities.
    

### Referencias

- [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)
    
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
    