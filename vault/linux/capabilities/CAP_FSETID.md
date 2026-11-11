---
aliases:
date: 2024-07-31
description: Permite no borrar los bits de modo set-user-ID y set-group-ID al modificar un fichero
tags:
  - linux
  - capabilities
  - security
  - permissions
title: CAP_FSETID
---

### Descripción de CAP_FSETID  
  
La capability `CAP_FSETID` permite no borrar los bits de modo set-user-ID y set-group-ID al modificar un fichero; establecer el bit set-group-ID para un fichero cuyo GID no coincide con el GID del sistema de archivos o cualquiera de los GIDs suplementarios del proceso llamante.[1, 2, 7, 5, 6, 9]  
  
### Casos de Uso Comunes  
  
*   Utilidades que necesitan modificar ficheros ejecutables manteniendo los bits setuid o setgid.  
*   Procesos de instalación de software que configuran permisos especiales en los ejecutables.  
  
### Llamadas al Sistema Asociadas  
  
Esta capability está relacionada con la llamada al sistema `chmod`.[4]  
  
### Implicaciones de Seguridad  
  
Mantener o establecer bits setuid/setgid puede permitir a usuarios sin privilegios ejecutar comandos con los permisos del propietario del fichero, lo que debe gestionarse con cuidado para evitar escaladas de privilegios no deseadas.  
  
### Comandos y Herramientas Relacionadas  
  
*   Utilidades como `chmod`.  
*   `capsh`: Shell con capacidades para pruebas y depuración de capabilities.[1, 5, 6]  
  
### Referencias  
  
*   [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
*   [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  