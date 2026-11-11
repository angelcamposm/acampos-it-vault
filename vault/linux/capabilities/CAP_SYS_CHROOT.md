---
aliases:
date: 2024-07-31
description: Permite usar la llamada al sistema chroot
tags:
  - linux
  - capabilities
  - security
  - chroot
title: CAP_SYS_CHROOT
---

### Descripción de CAP_SYS_CHROOT  
  
La capability `CAP_SYS_CHROOT` permite usar la llamada al sistema chroot(2) para cambiar el directorio raíz.[1, 2, 7, 5, 6, 9]  
  
### Casos de Uso Comunes  
  
*   Utilidades que crean entornos aislados o jails.  
  
### Llamadas al Sistema Asociadas  
  
Esta capability está directamente relacionada con la llamada al sistema `chroot`.[4]  
  
### Implicaciones de Seguridad  
  
Aunque `chroot` proporciona cierto nivel de aislamiento, no es una solución de sandboxing completa y puede ser eludida en ciertas circunstancias.  
  
### Comandos y Herramientas Relacionadas  
  
*   La utilidad `chroot`.  
*   `capsh`: Shell con capacidades para pruebas y depuración de capabilities.[1, 5, 6]  
  
### Referencias  
  
*   [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
*   [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
  