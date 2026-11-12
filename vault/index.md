---
aliases:
  - index
  - home
  - vault
date: 2026-11-11
description: Base de conocimiento técnico sobre ingeniería del software, sistemas distribuidos, redes, ciberseguridad, DevOps, SRE e ingeniería de plataformas para ingenieros júnior.
draft: false
publish: true
tags:
  - index
  - devops
  - sre
  - platform_engineering
  - distributed_systems
  - software_engineering
  - networking
  - cybersecurity
  - git
  - gitops
  - netops
title: Inicio
---

Bienvenido a este **segundo cerebro** y jardín digital técnico. Este espacio recopila apuntes, guías prácticas y conceptos fundamentales explicados en español claro y directo, pensados especialmente para **ingenieros júnior** que buscan consolidar sus bases técnicas y comprender cómo funcionan los sistemas reales en producción.

> [!NOTE] Filosofía de esta wiki
> En ingeniería es fácil perderse entre herramientas de moda y siglas en inglés. El objetivo de estas notas es bajar al detalle de **cómo funcionan las cosas por debajo**, empleando un lenguaje llano, riguroso y accesible, manteniendo los términos técnicos en inglés solo cuando son el estándar de la industria.

---

## Áreas de conocimiento

El contenido de este repositorio se organiza en torno a los pilares fundamentales de la infraestructura y el desarrollo moderno:

### 1. Ingeniería del software (`Software Engineering`)
Principios de diseño, arquitectura limpia, estructuras de datos, pruebas automatizadas, patrones de diseño y buenas prácticas para escribir código mantenible, legible y fácil de depurar.

### 2. Sistemas distribuidos (`Distributed Systems`)
Cómo lograr que múltiples máquinas trabajen juntas sin perder datos ni disponibilidad: consenso, replicación, particionamiento, tolerancia a fallos, colas de mensajería, latencia y concurrencia.

### 3. Sistemas operativos y Linux
El cimiento sobre el que corre casi toda la infraestructura actual: el núcleo (`kernel`), gestión de procesos, memoria, sistemas de archivos, aislamiento de contenedores (`namespaces`, `cgroups`) y control de privilegios.
- **Empezar por aquí:** [[linux/capabilities/index|Capacidades del núcleo de Linux (Linux capabilities)]] — Desglose de privilegios del superusuario (`root`), con fichas detalladas como [[CAP_NET_ADMIN]], [[CAP_SYS_ADMIN]] o [[CAP_DAC_OVERRIDE]].

### 4. Redes y automatización de red (`Networking` y `NetOps`)
Desde el modelo TCP/IP, enrutamiento (`routing`), conmutación (`switching`), DNS y cortafuegos (`firewalls`), hasta la gestión programática y automatizada de infraestructuras de red mediante código (`NetOps`).

### 5. Ciberseguridad (`Cybersecurity`)
Seguridad defensiva y ofensiva aplicada a sistemas e infraestructura: principio de mínimo privilegio, bastiones, endurecimiento de sistemas (`hardening`), criptografía aplicada, gestión de secretos y auditoría.

### 6. Control de versiones (`Git`)
Uso profesional de Git más allá de los comandos básicos: funcionamiento interno del grafo de confirmaciones (`commits`), estrategias de ramificación, resolución de conflictos, reescritura limpia del historial e integración en equipos de trabajo.

### 7. Cultura `DevOps` y `GitOps`
Automatización del ciclo de vida del software: integración y entrega continua (CI/CD), infraestructura como código (IaC), contenedores, orquestadores y operación declarativa guiada por repositorios Git (`GitOps`).

### 8. Ingeniería de fiabilidad de sitios (`SRE` — *Site Reliability Engineering*)
Aplicación de principios de ingeniería del software a las operaciones y a la estabilidad en producción: indicadores y objetivos de nivel de servicio (`SLI`, `SLO`, `SLA`), presupuestos de error (`error budgets`), reducción del trabajo operativo repetitivo (`toil`), observabilidad (métricas, registros y trazas), gestión de incidentes y análisis *post mortem* sin culpables (`blameless postmortems`).

### 9. Ingeniería de plataformas (`Platform Engineering`)
La evolución natural de `DevOps` para reducir la carga cognitiva de los equipos de desarrollo: diseño y construcción de plataformas internas de desarrollo (`IDP`, *Internal Developer Platforms*), herramientas de autoservicio (`self-service`), caminos pavimentados (`golden paths`) y mejora continua de la experiencia de desarrollo (`DevEx`).

---

## Cómo aprovechar este jardín digital

A diferencia de un libro tradicional, esta wiki no tiene un orden único de lectura. Puedes explorarla de varias maneras:

1. **Mediante enlaces internos:** sigue los enlaces entre notas para profundizar en los conceptos que no conozcas o entender cómo se relacionan dos tecnologías distintas.
2. **A través del grafo interactivo:** visualiza qué conceptos actúan como nodos centrales entre disciplinas (por ejemplo, cómo las [[linux/capabilities/index|capabilities de Linux]] conectan el sistema operativo, las redes y la ciberseguridad en contenedores).
3. **Con el buscador y las etiquetas (`tags`):** filtra rápidamente por áreas como `#linux`, `#networking`, `#capabilities` o `#cybersecurity`.

> [!TIP] Consejo para ingenieros júnior
> No intentes memorizar comandos ni parámetros de memoria. Céntrate siempre en entender **qué problema resuelve** cada herramienta, **qué ocurre en el sistema operativo o en la red** cuando ejecutas una acción y **qué implicaciones de seguridad** conlleva.