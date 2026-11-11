---
aliases:
date: 2024-07-31
description: Una capability amplia que abarca muchas tareas de administración del sistema
tags:
  - linux
  - capabilities
  - system_management
title: CAP_SYS_ADMIN
---
  
### Descripción de CAP_SYS_ADMIN  
  
La capability `CAP_SYS_ADMIN` es una capability amplia que abarca muchas tareas de administración del sistema relacionadas con el sistema de archivos, recursos e inspección de procesos.[1, 2, 4, 8, 7, 9] Funcionalidades se están moviendo fuera de esta capability en kernels más recientes.[4]  
  
### Casos de Uso Comunes  
  
*   Muchas herramientas de administración del sistema que requieren privilegios elevados.  
*   Software de virtualización y contenedores.  
  
### Llamadas al Sistema Asociadas  
  
Esta capability está asociada con numerosas llamadas al sistema, incluyendo `clone`, `mount`, `ptrace`, `unshare` y muchas otras.[4]  
  
### Implicaciones de Seguridad  
  
Debido a su amplio alcance, otorgar `CAP_SYS_ADMIN` es casi equivalente a otorgar privilegios de root completos y debe evitarse siempre que sea posible en favor de capabilities más específicas.  
  
### Comandos y Herramientas Relacionadas  
  
*   Muchas utilidades de administración del sistema.  
*   `capsh`: Shell con capacidades para pruebas y depuración de capabilities.[1, 5, 6]  
  
### Referencias  
  
*   [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
*   [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
  