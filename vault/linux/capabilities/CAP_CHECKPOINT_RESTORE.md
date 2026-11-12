---
aliases:
date: 2024-07-31
description: Permite realizar operaciones de checkpoint y restore
draft: false
publish: true
tags:
  - linux
  - capabilities
  - virtualization
  - containers
title: CAP_CHECKPOINT_RESTORE
---

### Descripción de CAP_CHECKPOINT_RESTORE

La capability `CAP_CHECKPOINT_RESTORE` permite realizar operaciones de checkpoint y restore. Esta capability se añadió en Linux 5., permitiendo a usuarios no root crear y restaurar checkpoints.

### Casos de Uso Comunes

- Software de virtualización y contenedores que necesita guardar y restaurar el estado de los procesos.
- Herramientas de migración en vivo de aplicaciones.

### Llamadas al Sistema Asociadas

Esta capability puede utilizar la llamada al sistema clone e interactuar con archivos como `/proc/sys/kernel/ns_last_pid` y `/proc/PID/map_files`.

### Implicaciones de Seguridad

Permitir operaciones de checkpoint y restore podría ser utilizado para eludir mecanismos de seguridad o para inspeccionar el estado de otros procesos.

### Comandos y Herramientas Relacionadas

- CRIU (Checkpoint/Restore in Userspace).
- Herramientas de gestión de contenedores.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.

### Referencias

- [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
