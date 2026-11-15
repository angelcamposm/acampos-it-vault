---
aliases:
  - kebab-case
  - Kebab Case
  - dash-case
  - param-case
  - lisp-case
  - spinal-case
  - Train-Case
date: 2026-11-15
description: Qué es la convención kebab-case (dash-case), por qué no se puede usar en variables de casi ningún lenguaje pero es el estándar en URLs, CSS, Kubernetes, Git y CLI.
draft: false
enableToc: true
publish: true
tags:
  - software_engineering
  - clean_code
  - naming_conventions
  - kebab_case
  - devops
  - kubernetes
title: "kebab-case (dash-case)"
---

La convención **kebab-case** (también llamada **dash-case**, **param-case**, **spinal-case** o **lisp-case**) escribe todas las palabras en **minúsculas** y las une mediante un **guion medio** (`-`, *hyphen* o *dash*): `user-profile`, `max-retry-count`, `kube-controller-manager`.

Su nombre popular proviene de que las palabras parecen trozos de comida ensartados en una brocheta (*kebab*) atravesada por los guiones medios.

---

## ¿Por qué NO se puede usar `kebab-case` en variables de código?

Si intentas declarar una variable en Python, JavaScript, Java, C, Go o Rust usando `kebab-case`, obtendrás inmediatamente un error de compilación o un comportamiento inesperado:

```python
# ❌ ERROR DE SINTAXIS: El intérprete evalúa el guion '-' como el operador matemático de RESTA
precio-total = 100
# SyntaxError: cannot assign to expression here
```

En casi todos los lenguajes derivados de C o Algol, el carácter `-` está reservado como el **operador aritmético de sustracción** (`a - b`). Las únicas excepciones notables de lenguajes donde sí se permite en identificadores son la familia **Lisp** (`Common Lisp`, `Clojure`, donde el operador de resta va delante en notación prefija `(- a b)`) y lenguajes de hojas de estilo como **CSS**.

Sin embargo, fuera del código fuente interno, **`kebab-case` es el estándar absoluto en la infraestructura web, redes, contenedores y herramientas de línea de comandos (`CLI`)**.

---

## Dónde es estándar `kebab-case`

### 1. URLs, slugs web y rutas de APIs REST (`SEO` y HTTP)
En el diseño de rutas web y APIs RESTful, `kebab-case` es la norma recomendada tanto por las guías de diseño de APIs como por los motores de búsqueda (Google trata el guion medio `-` como un separador de palabras en una URL, mientras que trata el guion bajo `_` de [[snake-case|snake_case]] como un carácter que une las palabras en una sola):

* ✅ Estándar: `https://acampos.it/software-engineering/naming-conventions/kebab-case`
* ✅ Endpoint REST: `POST /api/v2/payment-methods/credit-cards`
* ❌ Evitar en URLs: `/api/v2/paymentMethods/credit_cards`

> [!WARNING] Sensibilidad a mayúsculas en URLs (*Case Sensitivity*)
> Mientras que el nombre de dominio (`acampos.it`) es insensible a mayúsculas por el estándar DNS, la ruta que va después de la barra (`/Naming-Conventions`) **sí distingue entre mayúsculas y minúsculas** en servidores Linux (`Nginx`, `Apache`). Usar siempre `kebab-case` (todo en minúsculas) en rutas y nombres de archivos web evita enlaces rotos y errores `404 Not Found`.

### 2. Objetos en Kubernetes, contenedores Docker y nombres DNS (`RFC 1123`)
En **Kubernetes** y en la infraestructura de red moderna, la mayoría de los nombres de recursos (`metadata.name` de Pods, Deployments, Services, Ingresses y Namespaces) deben cumplir el estándar **DNS Subdomain / Label Name (`RFC 1123`)**, que exige:
* Contener **únicamente letras minúsculas (`a-z`), números (`0-9`) y guiones medios (`-`)**.
* **No permite guiones bajos (`_`)** ni letras mayúsculas.

```yaml
# Manifiesto de Kubernetes:
# - 'kind' en PascalCase
# - claves YAML en camelCase
# - 'metadata.name' y etiquetas de red en kebab-case (RFC 1123)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: payment-processor-worker
  namespace: production-eu-west
spec:
  replicas: 3
  template:
    spec:
      containers:
        - name: worker-container
          image: registry.ejemplo.local/billing/payment-worker:1.4.0
```

### 3. Banderas de línea de comandos (`CLI Flags` — estándar POSIX / GNU)
En Linux y herramientas `DevOps` (`git`, `kubectl`, `docker`, `terraform`, `curl`), las opciones largas de terminal siguen universalmente `kebab-case` precedido por doble guion (`--`):
* `git commit --amend --no-edit`
* `kubectl apply --dry-run=client --server-side`
* `docker compose up --build --remove-orphans`

### 4. HTML, CSS y atributos `data-*`
En el desarrollo frontend, todas las propiedades nativas de **CSS**, los nombres de clases (o componentes Web) y los atributos personalizados de prueba (`data-testid` en Playwright/Cypress) utilizan `kebab-case`:

```css
/* CSS: Selectores y propiedades siempre en kebab-case */
.main-navigation-bar {
  background-color: #1e293b;
  border-bottom-width: 2px;
}
```

### 5. Repositorios Git, ramas y gestores de paquetes (`npm`, `cargo`, `apt`)
* **Nombres de repositorios y ramas en Git:** `feat/add-oauth2-login`, `fix/database-connection-leak`.
* **Nombres de paquetes:** En `npm` (`package.json`), `Cargo` de Rust (`Cargo.toml`) y paquetes de Debian/Ubuntu (`apt install net-tools`), los paquetes se publican en `kebab-case`. (En Rust, aunque el paquete en `Cargo.toml` se llame `my-awesome-crate`, al importarlo en código `.rs` el compilador lo convierte automáticamente a [[snake-case|snake_case]]: `use my_awesome_crate::*;`).

---

## Variante relacionada: `Train-Case` (`HTTP-Header-Case` / `COBOL-CASE`)

Existe una variante de `kebab-case` en la que cada palabra separada por guion medio empieza con letra mayúscula, conocida como **`Train-Case`** o **`HTTP-Header-Case`**:
* Ejemplos: `Content-Type`, `Cache-Control`, `X-Forwarded-For`, `Strict-Transport-Security`.
* Se utiliza tradicionalmente en las **cabeceras del protocolo HTTP/1.1** (aunque a partir de `HTTP/2` y `HTTP/3` el estándar exige que todas las cabeceras viajen por la red convertidas estrictamente a `kebab-case` en minúsculas: `content-type`).

---

## Referencias

1. IETF RFC 1123 — *Requirements for Internet Hosts — Application and Support (Host Names and Numbers)*. [https://datatracker.ietf.org/doc/html/rfc1123](https://datatracker.ietf.org/doc/html/rfc1123)
2. Kubernetes Documentation — *Object Names and IDs (DNS Subdomain Names & RFC 1123 Labels)*. [https://kubernetes.io/docs/concepts/overview/working-with-objects/names/](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/)
3. Google Search Central — *URL Structure Best Practices for Google (Use hyphens, not underscores)*. [https://developers.google.com/search/docs/crawling-indexing/url-structure](https://developers.google.com/search/docs/crawling-indexing/url-structure)
