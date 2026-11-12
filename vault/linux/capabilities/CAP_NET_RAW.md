---
aliases:
date: 2024-07-31
description: Permite usar sockets RAW y PACKET
draft: false
publish: true
tags:
  - linux
  - capabilities
  - network
  - raw_sockets
  - packet_sockets
title: CAP_NET_RAW
---

### Descripción de CAP_NET_RAW  
  
La capability `CAP_NET_RAW` permite usar sockets `RAW` y `PACKET`; enlazar a cualquier dirección para proxying transparente.* 2, 3, 7, 10, 5, 6]  
  
### Casos de Uso Comunes  
  
* Herramientas de diagnóstico de red como `ping` o `tcpdump`.  
* Aplicaciones que implementan protocolos de red personalizados.  
  
### Llamadas al Sistema Asociadas  
  
No se especifican llamadas al sistema particulares en las referencias proporcionadas, pero está relacionado con la creación y manipulación de sockets raw y packet.  
  
### Implicaciones de Seguridad  
  
El uso de sockets raw permite a un proceso enviar y recibir paquetes de red sin pasar por la pila de protocolos normal del kernel, lo que puede ser peligroso si se utiliza de forma malintencionada.  
  
### Comandos y Herramientas Relacionadas  
  
* `ping`, `tcpdump`, `wireshark`.  
* `capsh`: Shell con capacidades para pruebas y depuración de capabilities.  
  
### Referencias  
  
* [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
* [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  
  