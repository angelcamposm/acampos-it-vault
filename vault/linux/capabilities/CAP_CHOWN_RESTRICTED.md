---
aliases:
date: 2024-07-31
description: Restringe el cambio de propietario de ficheros
tags:
  - linux
  - capabilities
  - security
  - permissions
title: CAP_CHOWN_RESTRICTED
---

### Descripción de CAP_CHOWN_RESTRICTED

La capability `CAP_CHOWN_RESTRICTED` restringe el cambio de propietario de ficheros. [[CAP_CHOWN]] la omite cuando está activo.1

### Casos de Uso Comunes

- Esta capability se utiliza para imponer restricciones adicionales sobre quién puede cambiar la propiedad de los ficheros, incluso para usuarios con la capability [[CAP_CHOWN]].

### Llamadas al Sistema Asociadas

Esta capability afecta el comportamiento de la llamada al sistema `chown`.

### Implicaciones de Seguridad

Ayuda a reforzar la seguridad al limitar la capacidad de cambiar la propiedad de los ficheros.

### Comandos y Herramientas Relacionadas

- La llamada al sistema chown.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.1

### Referencias

- [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
