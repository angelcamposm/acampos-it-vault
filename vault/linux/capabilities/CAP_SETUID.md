---
aliases:
date: 2024-07-31
description: Permite realizar manipulaciones arbitrarias de los UIDs de los procesos
draft: false
publish: true
tags:
  - linux
  - capabilities
  - security
  - uid
title: CAP_SETUID
---

### Descripción de CAP_SETUID

La capability `CAP_SETUID` permite realizar manipulaciones arbitrarias de los UIDs de los procesos; falsificar el UID al pasar credenciales de socket a través de sockets de dominio UNIX; escribir una asignación de ID de usuario en un namespace de usuario.

### Casos de Uso Comunes

- Utilidades como su que permiten cambiar el UID efectivo de un proceso.
- Servicios que necesitan operar con diferentes UIDs para acceder a recursos específicos.

### Llamadas al Sistema Asociadas

Esta capability puede estar relacionada con llamadas al sistema como clone, keyctl y setuid.

### Implicaciones de Seguridad

Permitir la manipulación de UIDs puede llevar a escaladas de privilegios si se utiliza incorrectamente.

### Comandos y Herramientas Relacionadas

- su, sudo.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.

### Referencias

- [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
