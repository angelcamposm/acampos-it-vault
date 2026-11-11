---
aliases:
date: 2024-07-31
description: Permite rastrear procesos usando ptrace
tags:
  - linux
  - capabilities
  - debug
  - ptrace
title: CAP_SYS_PTRACE
---
  
### Descripción de CAP_SYS_PTRACE  
  
La capability `CAP_SYS_PTRACE` permite rastrear procesos usando ptrace(2).[1, 2]  
  
### Casos de Uso Comunes  
  
*   Depuradores como `gdb` o herramientas de análisis del sistema como `strace`.  
  
### Llamadas al Sistema Asociadas  
  
Esta capability está directamente relacionada con la llamada al sistema `ptrace`.[4]  
  
### Implicaciones de Seguridad  
  
La capacidad de rastrear procesos permite inspeccionar su memoria y su ejecución, lo que podría utilizarse para obtener información sensible o para manipular otros procesos.  
  
### Comandos y Herramientas Relacionadas  
  
*   `gdb`, `strace`, `ltrace`.  
*   `capsh`: Shell con capacidades para pruebas y depuración de capabilities.[1, 5, 6]  
  
### Referencias  
  
*   [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
*   [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
  

