---
aliases:
date: 2024-07-31
description: Permite saltarse las comprobaciones de permisos que normalmente requieren que el UID del proceso coincida con el UID del fichero
tags:
  - linux
  - capabilities
  - security
  - permissions
title: CAP_FOWNER
---

### Descripción de CAP_FOWNER

La capability `CAP_FOWNER` permite saltarse las comprobaciones de permisos que normalmente requieren que el UID del proceso coincida con el UID del fichero, excluyendo las operaciones cubiertas por [[CAP_DAC_OVERRIDE]] y [[CAP_DAC_READ_SEARCH]].1

### Casos de Uso Comunes

- Servicios que gestionan ficheros en nombre de otros usuarios y necesitan realizar operaciones como cambiar permisos o borrar ficheros.
- Tareas de limpieza o mantenimiento que requieren modificar ficheros propiedad de diferentes usuarios.

### Llamadas al Sistema Asociadas

Esta capability podría ser necesaria para llamadas al sistema como chmod, open, rename, rmdir, unlink, utime y utimensat.4

### Implicaciones de Seguridad

Un proceso con esta capability puede modificar o eliminar ficheros propiedad de otros usuarios, lo que podría llevar a la pérdida de datos o a la manipulación del sistema.

### Comandos y Herramientas Relacionadas

- Algunos servicios de gestión de ficheros.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.1

### Referencias

- [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)