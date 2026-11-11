---
aliases:
date: 2024-07-31
description: Permite crear ficheros especiales usando mknod
tags:
  - linux
  - capabilities
  - filesystem
title: CAP_MKNOD
---
## Descripción de CAP_MKNOD  
  
La capability `CAP_MKNOD` permite crear ficheros especiales usando mknod.[1, 2, 7, 5, 6]  
  
### Casos de Uso Comunes  
  
*   Utilidades para la gestión de dispositivos que necesitan crear nodos de dispositivo en el sistema de archivos.  
  
### Llamadas al Sistema Asociadas  
  
Esta capability está directamente relacionada con la llamada al sistema `mknod`.[4]  
  
### Implicaciones de Seguridad  
  
La creación de ficheros especiales puede tener implicaciones de seguridad si se permite a procesos no autorizados crear nodos de dispositivo arbitrarios.  
  
### Comandos y Herramientas Relacionadas  
  
*   La utilidad `mknod`.  
*   `capsh`: Shell con capacidades para pruebas y depuración de capabilities.[1, 5, 6]  
  
### Referencias  
  
*   [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
*   [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
