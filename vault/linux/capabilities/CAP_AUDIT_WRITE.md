---
aliases:
date: 2024-07-31
description: Permite escribir registros en el log de auditoría
draft: false
publish: true
tags:
  - linux
  - capabilities
  - security
  - audit
title: CAP_AUDIT_WRITE
---

### Descripción de CAP_AUDIT_WRITE

La capability `CAP_AUDIT_WRITE` permite escribir registros en el log de auditoría del kernel.

### Casos de Uso Comunes

*  Aplicaciones o servicios que necesitan registrar eventos específicos en el log de auditoría para fines de seguimiento o cumplimiento.

### Llamadas al Sistema Asociadas

Esta capability se utiliza con la llamada al sistema `sendto` al escribir eventos en el log de auditoría.

### Implicaciones de Seguridad

Un proceso con esta capability podría potencialmente inyectar logs falsos o manipular el registro de auditoría.

### Comandos y Herramientas Relacionadas

*  Aplicaciones personalizadas de logging que interactúan con el subsistema de auditoría.
*  `capsh`: Shell con capacidades para pruebas y depuración de capabilities.

### Referencias

*  [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)
*  [Linux Capabilities - Linux Audit](https://linux-audit.com/kernel/capabilities/)
