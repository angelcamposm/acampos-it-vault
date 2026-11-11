---
aliases:
date: 2024-07-31
description: Permite operaciones BPF privilegiadas
tags:
  - linux
  - capabilities
  - network
  - security
title: CAP_BPF
---
  
### Descripción de CAP_BPF  
  
La capability `CAP_BPF` permite operaciones BPF privilegiadas; ver bpf(2) y bpf-helpers(7).[1, 2, 4, 8] 
Esta capability se añadió en Linux 5.8 para separar la funcionalidad de monitorización del rendimiento de la sobrecargada capability [[CAP_SYS_ADMIN]].[2]  
  
### Casos de Uso Comunes  
  
*   Herramientas de monitorización de red y rendimiento que utilizan Berkeley Packet Filters extendidos (eBPF).  
*   Sistemas de seguridad que implementan sandboxing y políticas de red mediante eBPF.  
  
### Llamadas al Sistema Asociadas  
  
La llamada al sistema `bpf` está directamente asociada con esta capability.[4]  
  
### Implicaciones de Seguridad  
  
Permitir operaciones BPF privilegiadas puede dar a un proceso la capacidad de inspeccionar y modificar el tráfico de red, así como de realizar otras operaciones de bajo nivel en el kernel.  
  
### Comandos y Herramientas Relacionadas  
  
*   `perf`: Herramienta de análisis de rendimiento que puede utilizar eBPF.  
*   Herramientas que interactúan directamente con la API de BPF.  
*   `capsh`: Shell con capacidades para pruebas y depuración de capabilities.[1, 5, 6]  
  
### Referencias  
  
*   [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)  
*   [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)  