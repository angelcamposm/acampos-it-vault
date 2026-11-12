---
aliases:
date: 2024-07-31
description: Permite usar acct para activar o desactivar la contabilidad de procesos
draft: false
publish: true
tags:
  - linux
  - capabilities
  - system_management
  - process_accountability
title: CAP_SYS_PACCT
---

### Descripción de CAP_SYS_PACCT

La capability `CAP_SYS_PACCT` permite usar acct(2) para activar o desactivar la contabilidad de procesos.

### Casos de Uso Comunes

- Utilidades de administración que gestionan la contabilidad de procesos del sistema.

### Llamadas al Sistema Asociadas

Esta capability está relacionada con la llamada al sistema acct.

### Implicaciones de Seguridad

La manipulación de la contabilidad de procesos podría utilizarse para ocultar la actividad del sistema.

### Comandos y Herramientas Relacionadas

- La utilidad accton.
- capsh: Shell con capacidades para pruebas y depuración de capabilities.

### Referencias

- [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)
- [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
