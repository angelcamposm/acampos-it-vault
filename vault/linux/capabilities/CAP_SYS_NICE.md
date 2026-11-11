---
aliases:
date: 2024-07-31
description: Permite aumentar la prioridad de otros procesos y establecer políticas de programación
tags:
  - linux
  - capabilities
  - processes
  - priority
  - scheduling
title: CAP_SYS_NICE
---
  
### Descripción de CAP_SYS_NICE  
  
La capability `CAP_SYS_NICE` permite aumentar la prioridad de otros procesos (nice(2), setpriority(2)) y establecer políticas de programación (sched\_setscheduler(2), sched\_setparam(2)).[1, 2]  
  
### Casos de Uso Comunes  
  
*   Utilidades como `nice` o `renice` que modifican la prioridad de los procesos.  
*   Planificadores de recursos o sistemas de gestión de carga de trabajo.  
  
### Llamadas al Sistema Asociadas  
  
Esta capability está relacionada con llamadas al sistema como `nice` y `sched_setaffinity`.[4]  
  
### Implicaciones de Seguridad  
  
La capacidad de aumentar la prioridad de otros procesos podría utilizarse para acaparar recursos del sistema.  
  
### Comandos y Herramientas Relacionadas  
  
*   `nice`, `renice`, `chrt`.  
*   `capsh`: Shell con capacidades para pruebas y depuración de capabilities.[1, 5, 6]  
  
### Referencias  
  
*   [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
*   [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
