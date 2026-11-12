---
aliases:
date: 2024-07-31
description: Permite cambiar el propietario de ficheros
draft: false
publish: true
tags:
  - linux
  - capabilities
  - security
  - permissions
title: CAP_CHOWN
---

### Descripción de CAP_CHOWN  
  
La capability `CAP_CHOWN` permite a un proceso cambiar el propietario (UID) y el grupo (GID) de un fichero. Normalmente, esta acción está restringida al usuario root o al propietario del fichero. Esta capability es relevante cuando la restricción POSIX `_POSIX_CHOWN_RESTRICTED` está activa, lo cual es común en la mayoría de los sistemas Linux.  
  
### Casos de Uso Comunes  
  
* Un servicio que se ejecuta con un UID específico necesita cambiar la propiedad de ciertos ficheros temporales que crea.  
* Una herramienta de administración de sistemas permite a usuarios autorizados modificar la propiedad de ficheros sin necesidad de otorgarles privilegios de root completos.  
  
### Llamadas al Sistema Asociadas  
  
La capability [[CAP_CHOWN]] está directamente relacionada con la llamada al sistema `chown(2)`, que permite cambiar el propietario y el grupo de un fichero.  
  
### Implicaciones de Seguridad  
  
Si un proceso tiene la capability `CAP_CHOWN`, puede potencialmente tomar posesión de ficheros críticos del sistema, lo que podría llevar a una escalada de privilegios si el proceso es comprometido. Por lo tanto, esta capability debe otorgarse con precaución y solo a procesos que realmente la necesiten.  
  
### Comandos y Herramientas Relacionadas  
  
* `setcap`: Utilidad para asignar file capabilities a ejecutables.  
* `getcap`: Utilidad para consultar las file capabilities de un fichero.  
* `capsh`: Shell con capacidades para pruebas y depuración de capabilities.  
  
### Referencias  
  
* [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
* [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
  