---
aliases:
date: 2024-07-31
description: Permite enlazar un socket a puertos privilegiados del dominio de Internet
draft: false
publish: true
tags:
  - linux
  - capabilities
  - network
  - ports
title: CAP_NET_BIND_SERVICE
---
  
### Descripción de CAP_NET_BIND_SERVICE  
  
La capability `CAP_NET_BIND_SERVICE` permite enlazar un socket a puertos privilegiados del dominio de Internet (números de puerto menores de 1024).  
  
### Casos de Uso Comunes  
  
* Servidores de red como HTTP (puerto 80) o SMTP (puerto 25) que necesitan escuchar en puertos bien conocidos.  
  
### Llamadas al Sistema Asociadas  
  
Esta capability está relacionada con la llamada al sistema `bind`.  
  
### Implicaciones de Seguridad  
  
Permitir a un proceso enlazar puertos privilegiados le da la capacidad de interceptar tráfico destinado a servicios estándar.  
  
### Comandos y Herramientas Relacionadas  
  
* Servidores web como Apache o Nginx.  
* Servidores de correo electrónico como Postfix o Exim.  
* `capsh`: Shell con capacidades para pruebas y depuración de capabilities.  
  
### Referencias  
  
* [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
* [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
  