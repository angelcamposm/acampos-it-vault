---
aliases:
  - camelCase
  - Camel Case
  - lowerCamelCase
  - dromedaryCase
date: 2026-11-15
description: Qué es la convención camelCase (lowerCamelCase), dónde es el estándar de la industria (JavaScript, TypeScript, Java, Go, JSON) y cómo manejar acrónimos y números correctamente.
draft: false
enableToc: true
publish: true
tags:
  - software_engineering
  - clean_code
  - naming_conventions
  - camel_case
title: "camelCase (lowerCamelCase)"
---

La convención **camelCase** (también llamada formalmente **lowerCamelCase** o *dromedaryCase*) une varias palabras en un único identificador sin espacios ni signos de puntuación, escribiendo la **primera palabra completamente en minúsculas** y comenzando **cada palabra subsiguiente con una letra mayúscula**.

Su nombre proviene de que las letras mayúsculas intermedias sobresalen en mitad de la palabra como las jorobas de un camello: `usuarioActivo`, `calcularPrecioTotal`, `maxRetryAttempts`.

> [!NOTE] Diferencia entre `camelCase` y `PascalCase`
> A veces en literatura antigua se llamaba *CamelCase* tanto a `miVariable` como a `MiClase`. Hoy en día en la industria se distingue de forma estricta:
> * **camelCase** (*lowerCamelCase*): empieza siempre en **minúscula** (`httpClient`).
> * **[[pascal-case|PascalCase]]** (*UpperCamelCase*): empieza siempre en **mayúscula** (`HttpClient`).

---

## Reglas de formación

1. **Elimina todos los espacios y guiones** entre las palabras que componen el nombre.
2. **Convierte toda la primera palabra a minúsculas:** incluso si es un acrónimo (`xmlParser`, `httpRequest`, `idUsuario`).
3. **Capitaliza únicamente la primera letra de cada palabra siguiente:** el resto de letras de cada palabra van en minúscula (`getUserByEmail`).
4. **Prefijos booleanos claros:** cuando una variable o función en `camelCase` devuelve un booleano (`true`/`false`), el estándar es empezar con un verbo auxiliar en minúscula como `is`, `has`, `can` o `should` (`isActive`, `hasPermission`, `canExecute`).

---

## Dónde se utiliza `camelCase` como estándar

### 1. Ecosistema Web: JavaScript, TypeScript y JSON
En **JavaScript** y **TypeScript**, `camelCase` es la convención universal para variables, constantes locales, propiedades de objetos, parámetros y funciones o métodos:

```typescript
// TypeScript / JavaScript: variables, funciones y propiedades en camelCase
const maxConnectionRetries = 3;
let isDatabaseConnected = false;

function calculateDiscountedPrice(basePrice: number, discountPercentage: number): number {
  const discountAmount = basePrice * (discountPercentage / 100);
  return basePrice - discountAmount;
}
```

Además, dado que **JSON** (*JavaScript Object Notation*) nació directamente de la sintaxis de objetos de JavaScript, **`camelCase` es el estándar dominante para las claves de payloads JSON** en APIs REST y GraphQL modernas:

```json
{
  "userId": "usr_948102",
  "firstName": "Ada",
  "isVerified": true,
  "lastLoginAt": "2026-11-15T22:30:00Z"
}
```

### 2. Java y Kotlin
En **Java** y **Kotlin**, todos los métodos, atributos de instancia (*fields*), variables locales y parámetros de funciones siguen estrictamente `camelCase` (`getAccountBalance()`, `customerAddress`), reservando [[pascal-case|PascalCase]] para los nombres de las clases e interfaces.

### 3. Go (Golang): significado semántico de visibilidad privada
En **Go**, elegir entre `camelCase` y [[pascal-case|PascalCase]] **no es una preferencia estética, sino una instrucción para el compilador**:
* Si un identificador empieza con **minúscula (`camelCase`)**, es **privado al paquete** (*unexported*): ningún código fuera de ese paquete puede acceder a él.
* Si empieza con **mayúscula ([[pascal-case|PascalCase]])**, es **público** (*exported*).

```go
package auth

// maxTokenAge e hashPassword están en camelCase -> Son PRIVADOS del paquete 'auth'
const maxTokenAge = 3600

func hashPassword(rawPassword string) string {
    // ...
    return ""
}
```

---

## Casos especiales: acrónimos y números en `camelCase`

El mayor punto de fricción al usar `camelCase` aparece cuando el identificador incluye siglas (`HTTP`, `URL`, `API`, `ID`, `XML`, `JWT`):

* **Si el acrónimo va al principio del identificador**, debe escribirse **íntegramente en minúsculas** para respetar la regla de `lowerCamelCase`:
  * ✅ `apiEndpoint`, `jwtToken`, `htmlElement`, `urlPath`
  * ❌ `APIEndpoint`, `JWTToken` (esto sería [[pascal-case|PascalCase]])
* **Si el acrónimo va en medio o al final**, evita juntar dos acrónimos en mayúsculas seguidas:
  * ✅ `parseXmlToJson`, `generatePdfReport`, `fetchUserById`
  * ❌ `parseXMLToJSON` (cuesta leer dónde acaba una palabra y empieza otra)

> [!TIP] Ventaja y desventaja ergonómica
> * **Ventaja:** No requiere pulsar la tecla de guion bajo (`_`), lo que resulta más rápido al teclear y produce identificadores más compactos horizontalmente que [[snake-case|snake_case]].
> * **Desventaja:** En identificadores muy largos (más de 4 o 5 palabras), el ojo humano tarda unos milisegundos más en separar las palabras que cuando existe un delimitador explícito como en [[snake-case|snake_case]] o [[kebab-case|kebab-case]].

---

## Referencias

1. Google TypeScript Style Guide — *Identifiers*. [https://google.github.io/styleguide/tsguide.html#identifiers](https://google.github.io/styleguide/tsguide.html#identifiers)
2. Google JSON Style Guide — *Property Names*. [https://google.github.io/styleguide/jsoncstyleguide.xml#Property_Name_Format](https://google.github.io/styleguide/jsoncstyleguide.xml#Property_Name_Format)
3. Effective Go — *Names*. [https://go.dev/doc/effective_go#names](https://go.dev/doc/effective_go#names)
