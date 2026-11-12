---
aliases:
date: 2024-07-31
description: Permite saltarse las comprobaciones de permisos para leer ficheros y buscar en directorios
draft: false
publish: true
tags:
  - linux
  - capabilities
  - security
  - permissions
title: CAP_DAC_READ_SEARCH
---

### Descripción de CAP_DAC_READ_SEARCH  
  
La capability `CAP_DAC_READ_SEARCH` permite saltarse las comprobaciones de permisos para leer ficheros y buscar en directorios.  
  
### Casos de Uso Comunes  
  
* Procesos que necesitan acceder a la estructura del directorio del sistema, como indexadores de ficheros o herramientas de búsqueda.  
* Algunas utilidades de archivado que necesitan leer la metadata de los ficheros sin acceder a su contenido.  
  
### Llamadas al Sistema Asociadas  
  
Esta capability puede estar relacionada con llamadas al sistema como `link`, `open` y `open_by_handle_at`.  
  
### Implicaciones de Seguridad  
  
Aunque menos permisiva que `CAP_DAC_OVERRIDE`, esta capability aún permite a un proceso inspeccionar la estructura de directorios y leer la metadata de los ficheros, lo que podría revelar información sensible.  
  
### Comandos y Herramientas Relacionadas  
  
* Utilidades como `find` o `locate`.  
* `capsh`: Shell con capacidades para pruebas y depuración de capabilities.  
  
### Referencias  
  
* [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
* [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
