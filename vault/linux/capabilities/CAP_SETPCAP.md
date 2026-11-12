---
aliases:
date: 2024-07-31
description: Permite a un proceso otorgar o eliminar capabilities
draft: false
publish: true
tags:
  - linux
  - capabilities
  - security
  - process_permissions
title: CAP_SETPCAP
---
  
### Descripción de CAP_SETPCAP  
  
La capability `CAP_SETPCAP` permite a un proceso otorgar o eliminar cualquier capability del conjunto permitido del llamante a cualquier otro proceso (si no se admiten file capabilities) o añadir cualquier capability del conjunto de límites del hilo llamante a su conjunto heredable; eliminar capabilities del conjunto de límites (vía prctl(2) `PR_CAPBSET_DROP`); realizar cambios en los flags securebits (si se admiten file capabilities).  
  
### Casos de Uso Comunes  
  
* Utilidades de administración de capabilities como `capsh`.  
* Agentes de gestión de contenedores o sandboxes que necesitan configurar las capabilities de los procesos que ejecutan.  
  
### Llamadas al Sistema Asociadas  
  
Esta capability puede estar relacionada con llamadas al sistema como `capget` y `prctl`.  
  
### Implicaciones de Seguridad  
  
Esta es una capability muy poderosa que permite modificar los privilegios de otros procesos, por lo que debe otorgarse con extrema precaución.  
  
### Comandos y Herramientas Relacionadas  
  
* `capsh`.  
* `setcap`.  
* `getcap`.  
* `pscap`: Utilidad para listar las capabilities de los procesos en ejecución.  
* `filecap`: Utilidad para listar las capabilities de los ficheros.  
* `captest`: Utilidad para probar capabilities.  
  
### Referencias  
  
* [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
* [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
  
