---
aliases:
date: 2024-07-31
description: Permite activar alarmas que pueden despertar el sistema
tags:
  - linux
  - capabilities
  - power_management
  - alerts
title: CAP_WAKE_ALARM
---
  
### Descripción de CAP_WAKE_ALARM  
  
La capability `CAP_WAKE_ALARM` permite activar alarmas que pueden despertar el sistema.[1, 2]  
  
### Casos de Uso Comunes  
  
*   Aplicaciones que necesitan programar tareas para que se ejecuten después de que el sistema haya entrado en suspensión.  
  
### Llamadas al Sistema Asociadas  
  
Esta capability puede estar relacionada con llamadas al sistema como `clock_nanosleep` y `timer_create`.[4]  
  
### Implicaciones de Seguridad  
  
El uso excesivo de alarmas de despertar podría afectar la eficiencia energética del sistema.  
  
### Comandos y Herramientas Relacionadas  
  
*   Aplicaciones que utilizan temporizadores para despertar el sistema.  
*   `capsh`: Shell con capacidades para pruebas y depuración de capabilities.[1, 5, 6]  
  
### Referencias  
  
*   [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
*   [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
  