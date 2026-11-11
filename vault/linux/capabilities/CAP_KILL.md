---
aliases:
date: 2024-07-31
description: Permite saltarse las comprobaciones de permisos para el envío de señales
tags:
  - linux
  - capabilities
  - processes
  - signals
title: CAP_KILL
---

### Descripción de CAP_KILL

La capability `CAP_KILL` permite saltarse las comprobaciones de permisos para el envío de señales, incluyendo el uso de la operación ioctl(2) KDSIGACCEPT.1

### Casos de Uso Comunes

- Utilidades de administración de procesos como kill o pkill que necesitan enviar señales a procesos propiedad de otros usuarios.
- Sistemas de gestión de servicios que deben poder detener o reiniciar procesos.

### Llamadas al Sistema Asociadas

Esta capability está relacionada con la llamada al sistema kill.4

### Implicaciones de Seguridad

Un proceso con esta capability puede enviar cualquier señal a cualquier otro proceso del sistema, lo que podría utilizarse para interrumpir servicios o incluso para escalar privilegios en ciertas circunstancias.

### Comandos y Herramientas Relacionadas

- kill, pkill, killall.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.1

### Referencias

- [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
