---
aliases:
date: 2024-07-31
description: Permite configurar terminales
draft: false
publish: true
tags:
  - linux
  - capabilities
  - terminal
  - tty
title: CAP_SYS_TTY_CONFIG
---
  
### Descripción de CAP_SYS_TTY_CONFIG  
  
La capability `CAP_SYS_TTY_CONFIG` permite configurar terminales (ioctl(2) en tty fd).  
  
### Casos de Uso Comunes  
  
* Utilidades que necesitan realizar configuraciones especiales en los dispositivos de terminal.  
  
### Llamadas al Sistema Asociadas  
  
Esta capability está relacionada con la llamada al sistema `ioctl_console` y `vhangup`.  
  
### Implicaciones de Seguridad  
  
La configuración de terminales podría, en ciertos casos, tener implicaciones de seguridad.  
  
### Comandos y Herramientas Relacionadas  
  
* Utilidades como `stty`.  
* `capsh`: Shell con capacidades para pruebas y depuración de capabilities.  
  
### Referencias  
  
* [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
* [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
  