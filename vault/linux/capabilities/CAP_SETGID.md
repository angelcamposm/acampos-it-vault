---
aliases:
date: 2024-07-31
description: Permite realizar manipulaciones arbitrarias de los GIDs de los procesos
tags:
  - linux
  - capabilities
  - security
  - gid
title: CAP_SETGID
---

### Descripción de CAP_SETGID

La capability `CAP_SETGID` permite realizar manipulaciones arbitrarias de los GIDs de los procesos y la lista de GIDs suplementarios; falsificar el GID al pasar credenciales de socket a través de sockets de dominio UNIX; escribir una asignación de ID de grupo en un namespace de usuario.1

### Casos de Uso Comunes

- Utilidades como su o sg que permiten cambiar el GID efectivo de un proceso.
- Servicios que necesitan operar con diferentes GIDs para acceder a recursos específicos.

### Llamadas al Sistema Asociadas

Esta capability puede estar relacionada con llamadas al sistema como clone, getgroups, setgid y setgroups.4

### Implicaciones de Seguridad

Permitir la manipulación de GIDs puede llevar a escaladas de privilegios si se utiliza incorrectamente.

### Comandos y Herramientas Relacionadas

- su, sg, chgrp.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.1

### Referencias

- [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
