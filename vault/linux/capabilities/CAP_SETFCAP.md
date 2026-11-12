---
aliases:
date: 2024-07-31
description: Permite establecer capabilities arbitrarias en un fichero
draft: false
publish: true
tags:
  - linux
  - capabilities
  - security
  - file_permissions
title: CAP_SETFCAP
---

## Descripción de CAP_SETFCAP  
  
La capability `CAP_SETFCAP` permite establecer capabilities arbitrarias en un fichero. Desde Linux 5.12, también se necesita esta capability para mapear el ID de usuario 0 en un nuevo namespace de usuario.  
  
### Casos de Uso Comunes  
  
* Utilidades como `setcap` que permiten asignar capabilities a ejecutables.  
* Procesos de instalación de software que necesitan configurar capabilities en los binarios instalados.  
  
### Llamadas al Sistema Asociadas  
  
No se especifican llamadas al sistema particulares en las referencias proporcionadas, pero está directamente relacionada con la manipulación de los atributos extendidos de los ficheros para almacenar las capabilities.  
  
### Implicaciones de Seguridad  
  
Esta capability es crucial para el modelo de capabilities basado en ficheros y debe gestionarse con cuidado para evitar la concesión de privilegios no deseados.  
  
### Comandos y Herramientas Relacionadas  
  
* `setcap`.  
* `getcap`: Utilidad para consultar las file capabilities de un fichero.  
* `capsh`: Shell con capacidades para pruebas y depuración de capabilities.  
  
### Referencias  
  
* [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
* [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
  