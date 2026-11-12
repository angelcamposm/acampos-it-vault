---
aliases:
date: 2024-07-31
description: Permite saltarse las comprobaciones de permisos de acceso discrecional (DAC)
draft: false
publish: true
tags:
  - linux
  - capabilities
  - security
  - permissions
title: CAP_DAC_OVERRIDE
---

### Descripción de CAP_DAC_OVERRIDE

La capability `CAP_DAC_OVERRIDE` permite saltarse las comprobaciones de permisos de acceso discrecional (DAC) para lectura, escritura y ejecución de ficheros.1

### Casos de Uso Comunes

- Herramientas de backup y restauración que necesitan acceder a todos los ficheros independientemente de sus permisos.
- Procesos de indexación o búsqueda que deben leer el contenido de todos los ficheros.

### Llamadas al Sistema Asociadas

Esta capability puede estar relacionada con llamadas al sistema como mount, utime y utimensat.4

### Implicaciones de Seguridad

Un proceso con esta capability puede leer o modificar cualquier fichero del sistema, lo que representa un riesgo de seguridad significativo si se utiliza de forma indebida.

### Comandos y Herramientas Relacionadas

- Herramientas de backup como tar o rsync (a menudo requieren esta capability).
- capsh: Shell con capacidades para pruebas y depuración de capabilities.1

### Referencias

- [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
