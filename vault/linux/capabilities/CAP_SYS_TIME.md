---
aliases:
date: 2024-07-31
description: Permite establecer el reloj del sistema
draft: false
publish: true
tags:
  - linux
  - capabilities
  - system_time
title: CAP_SYS_TIME
---

### Descripción de CAP_SYS_TIME

La capability `CAP_SYS_TIME` permite establecer el reloj del sistema (settimeofday(2), stime(2), adjtimex(2)).

### Casos de Uso Comunes

- Utilidades como date o ntpd que sincronizan o modifican la hora del sistema.

### Llamadas al Sistema Asociadas

Esta capability está relacionada con llamadas al sistema como settimeofday y adjtimex.

### Implicaciones de Seguridad

La capacidad de modificar la hora del sistema podría utilizarse para manipular logs o para afectar la sincronización de otros sistemas.

### Comandos y Herramientas Relacionadas

- date, ntpd, chronyd.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.

### Referencias

- [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
