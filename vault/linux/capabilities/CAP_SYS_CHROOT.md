---
aliases:
date: 2024-07-31
description: Permite usar la llamada al sistema chroot
draft: false
publish: true
tags:
  - linux
  - capabilities
  - security
  - chroot
title: CAP_SYS_CHROOT
---

### Descripción de CAP_SYS_CHROOT  
  
La capability `CAP_SYS_CHROOT` permite usar la llamada al sistema chroot(2) para cambiar el directorio raíz.  
  
### Casos de Uso Comunes  
  
* Utilidades que crean entornos aislados o jails.  
  
### Llamadas al Sistema Asociadas  
  
Esta capability está directamente relacionada con la llamada al sistema `chroot`.  
  
### Implicaciones de Seguridad  
  
Aunque `chroot` proporciona cierto nivel de aislamiento, no es una solución de sandboxing completa y puede ser eludida en ciertas circunstancias.  
  
### Comandos y Herramientas Relacionadas  
  
* La utilidad `chroot`.  
* `capsh`: Shell con capacidades para pruebas y depuración de capabilities.  
  
### Referencias  
  
* [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
* [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
  