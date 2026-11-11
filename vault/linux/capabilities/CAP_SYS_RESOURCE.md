---
aliases:
date: 2024-07-31
description: Permite anular los límites de recursos del sistema
tags:
  - linux
  - capabilities
  - system_resources
  - limits
title: CAP_SYS_RESOURCE
---
  
### Descripción de CAP_SYS_RESOURCE  
  
La capability `CAP_SYS_RESOURCE` permite anular los límites de recursos del sistema.[1, 2, 4, 8]  
  
### Casos de Uso Comunes  
  
*   Aplicaciones que necesitan superar los límites de recursos predeterminados, como el número máximo de ficheros abiertos o el uso de memoria.  
*   Sistemas de gestión de recursos.  
  
### Llamadas al Sistema Asociadas  
  
Esta capability puede estar relacionada con llamadas al sistema como `fcntl` y `getrlimit`.[4]  
  
### Implicaciones de Seguridad  
  
La capacidad de anular los límites de recursos podría utilizarse para realizar ataques de denegación de servicio.  
  
### Comandos y Herramientas Relacionadas  
  
*   Utilidades como `ulimit`.  
*   `capsh`: Shell con capacidades para pruebas y depuración de capabilities.[1, 5, 6]  
  
### Referencias  
  
*   [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
*   [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
  
