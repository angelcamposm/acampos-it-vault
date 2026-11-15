---
aliases:
  - snake_case
  - Snake Case
  - SCREAMING_SNAKE_CASE
  - CONSTANT_CASE
  - pothole_case
date: 2026-11-15
description: Qué es la convención snake_case y su variante SCREAMING_SNAKE_CASE, por qué es el estándar en Python (PEP 8), Rust, bases de datos SQL, Terraform y variables de entorno en Linux.
draft: false
enableToc: true
publish: true
tags:
  - software_engineering
  - clean_code
  - naming_conventions
  - snake_case
  - python
  - linux
title: "snake_case y SCREAMING_SNAKE_CASE"
---

La convención **snake_case** (también conocida históricamente como *pothole_case* o *c_case*) separa cada palabra mediante un carácter de **guion bajo** (`_`, *underscore*) y escribe todas las letras en **minúscula**: `max_retry_count`, `user_profile_id`, `calculate_tax_rate`.

Su variante en mayúsculas, **`SCREAMING_SNAKE_CASE`** (también llamada `CONSTANT_CASE` o `MACRO_CASE`), mantiene el guion bajo como separador pero escribe todas las letras en **mayúscula**: `DATABASE_CONNECTION_URL`, `MAX_CONNECTIONS`, [[CAP_SYS_ADMIN]].

> [!TIP] ¿Por qué es tan fácil de leer?
> Diversos estudios de seguimiento ocular (*eye-tracking*) sobre lectura de código fuente han demostrado que el cerebro humano reconoce palabras compuestas en **snake_case** entre un 15 % y un 20 % más rápido que en [[camel-case|camelCase]], porque el guion bajo (`_`) imita visualmente el espacio en blanco que estamos acostumbrados a leer en el lenguaje natural.

---

## Dónde es estándar `snake_case` (minúsculas)

### 1. Python (`PEP 8`), Rust y Ruby
En **Python**, la guía de estilo oficial (`PEP 8`) establece `snake_case` como la norma obligatoria para nombres de variables, funciones, métodos, argumentos y módulos (archivos `.py`):

```python
# Python (PEP 8): funciones, variables, parámetros y módulos en snake_case
def calculate_monthly_installment(principal_amount: float, annual_interest_rate: float) -> float:
    monthly_rate = annual_interest_rate / 12 / 100
    return principal_amount * monthly_rate
```

De igual manera, el compilador de **Rust** (`rustc`) emite una advertencia automática (*warning* `non_snake_case`) si declaras una variable o función en [[camel-case|camelCase]] en lugar de `snake_case`.

### 2. Bases de datos relacionales (`SQL` / `PostgreSQL`)
En motores SQL como **PostgreSQL**, los identificadores que no van encerrados entre comillas dobles se convierten automáticamente a minúsculas internamente. Si creas una columna llamada `createdAt` sin comillas en PostgreSQL, el motor la guardará como `createdat` (en `flatcase`, perdiendo la separación de palabras).

Por esta razón, **en diseño de bases de datos SQL el estándar indiscutible para tablas, vistas, índices y columnas es `snake_case`**:

```sql
-- SQL (PostgreSQL): Tablas y columnas siempre en snake_case para evitar problemas de case-sensitivity
CREATE TABLE user_sessions (
    session_id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(user_id),
    ip_address INET NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    expires_at TIMESTAMPTZ NOT NULL
);
```

### 3. Infraestructura como Código (`Terraform` y `Ansible`)
En **Terraform (`HCL`)** y **Ansible**, todos los identificadores de recursos, variables de entrada, *outputs* y tareas se escriben en `snake_case`:

```hcl
# Terraform: Tipo de recurso y nombre interno en snake_case
resource "aws_security_group" "public_load_balancer" {
  name_prefix = "public-lb-" # El nombre externo en la nube suele ir en kebab-case
  vpc_id      = var.main_vpc_id
}
```

### 4. Nombres de tests descriptivos (Testing Automation)
Incluso en equipos donde el código de producción usa otro estilo, en frameworks como `pytest` o `Rust` los nombres de las funciones de prueba aprovechan `snake_case` para escribir frases largas y descriptivas siguiendo el principio **[[DAMP]]**:
`def test_transfer_fails_when_sender_account_is_frozen():`

---

## La variante `SCREAMING_SNAKE_CASE`

Cuando todas las letras de un identificador `snake_case` se escriben en mayúsculas, obtenemos **`SCREAMING_SNAKE_CASE`**. Su aspecto llamativo tiene un propósito intencional: advertir al lector de que ese valor **proviene del entorno del sistema operativo** o es una **constante inmutable global**.

### Casos de uso universales de `SCREAMING_SNAKE_CASE`

1. **Variables de entorno en Linux, Docker y Kubernetes (`POSIX`):**
   `PATH`, `HOME`, `KUBECONFIG`, `AWS_ACCESS_KEY_ID`, `POSTGRES_PASSWORD`.
2. **Constantes globales en casi todos los lenguajes:**
   Tanto en Python (`DEFAULT_TIMEOUT = 30`), como en Java (`public static final int MAX_RETRIES = 5;`), TypeScript/JavaScript (`export const API_BASE_URL = ...`) y Rust (`const BUFFER_SIZE: usize = 1024;`).
3. **Constantes del kernel de Linux y macros de C (`POSIX`):**
   Las señales del sistema (`SIGTERM`, `SIGKILL`), los códigos de error (`EACCES`, `ENOENT`) y las [[linux/capabilities/index|capabilities de Linux]] como [[CAP_NET_ADMIN]], [[CAP_SYS_ADMIN]] o [[CAP_CHOWN]] siguen estrictamente esta notación.

---

## Uso especial del guion bajo (`_`) en programación

En lenguajes que usan `snake_case`, el guion bajo al principio o al final tiene significados especiales que todo ingeniero debe conocer:

| Patrón | Ejemplo | Significado técnico |
| :--- | :--- | :--- |
| **Un guion bajo inicial** (`_var`) | `_internal_cache` | En **Python**, indica por convención que el atributo o función es **privado/interno**. En **Rust** y **TypeScript**, silencia el aviso de «variable declarada pero no utilizada». |
| **Guion bajo al final** (`var_`) | `class_`, `type_` | Se usa en **Python** cuando necesitas llamar a una variable igual que una palabra reservada del lenguaje (`class`, `def`, `from`, `id`) sin provocar un error de sintaxis. |
| **Doble guion bajo (*Dunder*)** (`__var__`) | `__init__`, `__str__` | En **Python**, representa métodos mágicos o especiales del protocolo del lenguaje (*double underscore* -> *dunder*). Nunca inventes nombres propios con este formato. |
| **Guion bajo solitario** (`_`) | `for _ in range(5):` | Variable descartable (*throwaway variable*) cuando no te interesa usar el valor devuelto en un bucle o desempaquetado de tupla. |

---

## Referencias

1. van Rossum, G., Warsaw, B., & Coghlan, N. (2001). *PEP 8 – Style Guide for Python Code: Descriptive Naming Styles*. [https://peps.python.org/pep-0008/#descriptive-naming-styles](https://peps.python.org/pep-0008/#descriptive-naming-styles)
2. Sharif, B., & Maletic, J. I. (2010). *An Eye Tracking Study on camelCase and under_score Identifier Styles*. IEEE 18th International Conference on Program Comprehension (ICPC).
3. HashiCorp Terraform Documentation — *Style Conventions*. [https://developer.hashicorp.com/terraform/language/style](https://developer.hashicorp.com/terraform/language/style)
