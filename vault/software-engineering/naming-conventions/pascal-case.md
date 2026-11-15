---
aliases:
  - PascalCase
  - Pascal Case
  - UpperCamelCase
  - CapWords
  - StudlyCase
date: 2026-11-15
description: Qué es la convención PascalCase (UpperCamelCase), por qué es el estándar universal para nombrar clases, tipos, interfaces y componentes de React, y su papel semántico en Go y C#.
draft: false
enableToc: true
publish: true
tags:
  - software_engineering
  - clean_code
  - naming_conventions
  - pascal_case
title: "PascalCase (UpperCamelCase)"
---

La convención **PascalCase** (también denominada **UpperCamelCase**, o `CapWords` en la guía `PEP 8` de Python) concatena múltiples palabras sin espacios ni guiones, escribiendo **la primera letra de absolutamente todas las palabras en mayúscula** (incluida la primera) y el resto de letras de cada palabra en minúscula: `UserAccount`, `DatabaseConnectionPool`, `PaymentGatewayException`.

Recibe su nombre en honor al lenguaje de programación **Pascal** (diseñado por Niklaus Wirth en 1970) y fue popularizada masivamente por el ecosistema de **Microsoft (.NET / C#)**, aunque hoy es un estándar transversal en prácticamente todos los lenguajes modernos.

---

## El estándar universal para Tipos y Clases

Independientemente de si un lenguaje prefiere [[camel-case|camelCase]] (como TypeScript o Java) o [[snake-case|snake_case]] (como Python o Rust) para sus variables y funciones, **casi todos los lenguajes coinciden en usar `PascalCase` para definir tipos de datos y estructuras**:

* **Clases (`class`) y Excepciones:** `UserRepository`, `OrderNotFoundError`, `CheckoutPage`.
* **Interfaces (`interface`) y `traits`:** `Authenticatable`, `PaymentProcessor`, `Serializable`.
* **Estructuras (`struct`), `type` aliases y `enums`:** `HttpRequestConfig`, `InvoiceStatus`.

```python
# Python: Las clases y excepciones usan PascalCase (CapWords),
# mientras que los métodos y atributos usan snake_case.
class BankAccount:
    def __init__(self, owner_name: str, initial_balance: float) -> None:
        self.owner_name = owner_name
        self.current_balance = initial_balance
```

```typescript
// TypeScript: Interfaces, Types y Clases en PascalCase; propiedades en camelCase.
interface PaymentResult {
  transactionId: string;
  isApproved: boolean;
}

export class StripePaymentGateway {
  async processCharge(amountInCents: number): Promise<PaymentResult> {
    // ...
    return { transactionId: 'tx_123', isApproved: true };
  }
}
```

> [!NOTE] ¿Por qué separar el estilo de los tipos (`PascalCase`) del de las variables (`camelCase` / `snake_case`)?
> Permite distinguir instantáneamente al leer una línea de código si un identificador hace referencia a **un molde o tipo abstracto** (`User`) o a **una instancia concreta en memoria** (`user` / `current_user`). Por ejemplo, en `const user: User = new User()`, la mayúscula inicial elimina cualquier ambigüedad visual.

---

## Casos donde `PascalCase` tiene significado para el compilador

En varios ecosistemas modernos, escribir un identificador en `PascalCase` no es solo una buena práctica de estilo, sino que **altera el comportamiento del compilador o del transpilador**:

### 1. Componentes en React, Vue y Astro (`JSX` / `TSX`)
En `JSX` (utilizado por React y frameworks similares), el compilador decide qué hacer con una etiqueta mirando únicamente su primera letra:
* Si empieza en **minúscula** (`<button>`, `<header>`, `<usercard>`), React asume que es una **etiqueta HTML nativa del navegador** y la envía tal cual al DOM.
* Si empieza en **mayúscula (`PascalCase`)** (`<Button />`, `<UserCard />`, `<AuthProvider />`), React sabe que es un **componente personalizado de JavaScript/TypeScript** y ejecuta su función correspondiente.

### 2. Go (Golang): exportación pública fuera del paquete
En **Go** no existen las palabras clave `public` ni `private`. La visibilidad de cualquier función, estructura (`struct`), interfaz, constante o campo de un `struct` se controla mediante su primera letra:
* **`PascalCase` (Empieza por mayúscula):** Símbolo **exportado (público)**. Puede ser importado y utilizado desde otros paquetes, y es visible para librerías de serialización como `encoding/json`.
* **[[camel-case|camelCase]] (Empieza por minúscula):** Símbolo **no exportado (privado)** al paquete actual.

```go
package billing

// Invoice y CalculateTax están en PascalCase -> Son PÚBLICOS fuera del paquete 'billing'
type Invoice struct {
    InvoiceId   string  // Público (exportado a JSON)
    TotalAmount float64 // Público (exportado a JSON)
    internalNotes string // camelCase -> Privado (ignorado por encoding/json)
}

func CalculateTax(amount float64) float64 {
    return amount * 0.21
}
```

### 3. Objetos de recursos (`Kind`) en Kubernetes
En los manifiestos `YAML` de **Kubernetes**, existe una distinción muy clara de convenciones según el campo:
* El tipo de recurso (`kind`) usa siempre **`PascalCase`**: `Deployment`, `StatefulSet`, `ServiceAccount`, `ClusterRoleBinding`, `NetworkPolicy`.
* Las claves de configuración usan **[[camel-case|camelCase]]**: `replicaCount`, `imagePullPolicy`, `containerPort`.
* Los nombres de las instancias (`metadata.name`) usan **[[kebab-case|kebab-case]]**: `payment-api-deployment`.

### 4. El ecosistema C# y .NET
A diferencia de Java o TypeScript, en **C# (`.NET`)** la guía oficial de Microsoft establece el uso de **`PascalCase` también para métodos públicos, propiedades (`Properties`) y constantes**, dejando [[camel-case|camelCase]] únicamente para parámetros de métodos y variables locales:
`public string GetUserFullName(int userId)`

---

## Manejo de acrónimos en `PascalCase`

Al igual que en [[camel-case|camelCase]], las guías de estilo modernas recomiendan capitalizar únicamente la primera letra de los acrónimos largos (de 3 o más letras) para mantener el ritmo visual de lectura:

* ✅ Recomendado: `HttpServer`, `XmlParser`, `JsonSerializer`, `UuidGenerator`, `JwtAuthMiddleware`.
* ❌ Desaconsejado: `HTTPServer`, `XMLParser`, `JSONSerializer` (dificulta identificar dónde termina la sigla y empieza el sustantivo `Server` o `Parser`).

---

## Referencias

1. Microsoft .NET Design Guidelines — *Capitalization Conventions (PascalCase)*. [https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/capitalization-conventions](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/capitalization-conventions)
2. React Documentation — *Your First Component (Component names must start with a capital letter)*. [https://react.dev/learn/your-first-component](https://react.dev/learn/your-first-component)
3. Kubernetes Documentation — *Objects In Kubernetes (Kinds and Names)*. [https://kubernetes.io/docs/concepts/overview/working-with-objects/](https://kubernetes.io/docs/concepts/overview/working-with-objects/)
