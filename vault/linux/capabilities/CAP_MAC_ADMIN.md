---
aliases:
date: 2024-07-31
description: Permite la configuración o cambios de estado de MAC (Mandatory Access Control)
draft: false
publish: true
tags:
  - linux
  - capabilities
  - security
  - mac
title: CAP_MAC_ADMIN
---
  
## Descripción de CAP_MAC_ADMIN  
  
La capability `CAP_MAC_ADMIN` permite la configuración o cambios de estado de MAC (Mandatory Access Control). Específicamente para el módulo de seguridad de Linux (LSM) Smack.  
  
### Casos de Uso Comunes  
  
* Herramientas de administración que necesitan configurar o modificar las políticas de control de acceso obligatorio, como las implementadas por Smack.  
  
### Llamadas al Sistema Asociadas  
  
Esta capability está relacionada con las interfaces específicas del LSM Smack.  
  
### Implicaciones de Seguridad  
  
Permitir la administración de MAC puede tener un impacto significativo en la seguridad del sistema.  
  
### Comandos y Herramientas Relacionadas  
  
* Herramientas de configuración de Smack.  
* `capsh`: Shell con capacidades para pruebas y depuración de capabilities.  
  
### Referencias  
  
* [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
* [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  