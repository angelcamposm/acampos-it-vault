---
aliases:
date: 2024-07-31
description: Permite emplear operaciones privilegiadas de monitorización del rendimiento
draft: false
publish: true
tags:
  - linux
  - capabilities
  - performance
  - monitoring
title: CAP_PERFMON
---

### Descripción de CAP_PERFMON

La capability `CAP_PERFMON` permite emplear operaciones privilegiadas de monitorización del rendimiento; ver perf_event_open(2). Añadida en Linux 5. para separar la funcionalidad de monitorización del rendimiento de la sobrecargada capability [[CAP_SYS_ADMIN]].

### Casos de Uso Comunes

- Herramientas de análisis de rendimiento como perf.
- Aplicaciones que necesitan acceder a contadores de rendimiento del hardware.

### Llamadas al Sistema Asociadas

Esta capability está relacionada con la llamada al sistema perf_event_open.

### Implicaciones de Seguridad

Permitir la monitorización del rendimiento puede revelar información sobre el funcionamiento interno del sistema.

### Comandos y Herramientas Relacionadas

- perf.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.

### Referencias

- [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
