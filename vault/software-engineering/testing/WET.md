---
aliases:
  - WET
  - Write Everything Twice
  - We Enjoy Typing
  - AHA
  - Rule of Three
date: 2026-11-15
description: Qué significa el código WET (Write Everything Twice) en la automatización de pruebas, por qué encarece el mantenimiento de suites E2E y API, y cuándo la duplicación temporal es preferible a una mala abstracción.
draft: false
enableToc: true
publish: true
tags:
  - software_engineering
  - testing
  - test_automation
  - clean_code
  - wet
title: "WET (Write Everything Twice)"
---

El acrónimo **WET** (*Write Everything Twice*, *We Enjoy Typing* o *Waste Everyone's Time*) nace como una contraposición irónica al principio **[[DRY]]** (*Don't Repeat Yourself*). Describe aquel código en el que la misma lógica, configuración o estructura técnica se ha copiado y pegado una y otra vez a lo largo del repositorio.

En el mundo del **Testing Automation**, el código **WET** suele aparecer bajo una excusa aparente de velocidad: *"Para añadir el test del nuevo caso borde, copio el test de arriba, lo pego abajo, cambio un parámetro y ya está en verde"*. Aunque esto ahorra cinco minutos hoy, genera una deuda técnica masiva que puede inutilizar toda la suite de pruebas en pocos meses.

---

## Síntomas de una suite de pruebas WET

Cuando una suite de pruebas automatizadas cae en el antipatrón **WET**, presenta síntomas muy fáciles de reconocer:

1. **Efecto dominó ante cambios triviales (*Fragile Tests*):**
   El equipo de producto decide añadir un campo obligatorio `telefono` en el endpoint `POST /api/users` o renombra el `id` de un botón en el HTML. Aunque la funcionalidad sigue siendo correcta, **se rompen 120 tests** porque cada uno de ellos construía el diccionario JSON o buscaba el selector CSS manualmente por su cuenta.
2. **Ruido visual extremo (*Obscure Test*):**
   Cada test ocupa 80 líneas de código donde 75 líneas son código repetido de inicialización (crear conexiones, instanciar 6 objetos relacionados, rellenar 20 atributos obligatorios) y solo 5 líneas contienen lo que realmente diferencia a ese test del anterior.
3. **Errores de copia y pega (*Copy-Paste Bugs*):**
   Al duplicar un test de 60 líneas para probar un caso negativo, el desarrollador modifica el dato de entrada pero olvida actualizar una de las tres aserciones finales o deja el mismo título en la descripción del test.

### Ejemplo de un test WET en Playwright (TypeScript)

Observa cómo se ven dos pruebas E2E escritas siguiendo un enfoque **WET** puro, donde tanto los selectores de bajo nivel como los pasos mecánicos se repiten íntegramente:

```typescript
// ❌ MAL: Tests WET con selectores acoplados y pasos mecánicos copiados y pegados
import { test, expect } from '@playwright/test';

test('un usuario estándar puede finalizar una compra con tarjeta', async ({ page }) => {
  await page.goto('https://tienda.ejemplo.local/login');
  await page.locator('input[name="user_email"]').fill('cliente@ejemplo.local');
  await page.locator('input[name="user_pass"]').fill('Secreto123!');
  await page.locator('button.btn-primary.submit-login').click();

  await page.goto('https://tienda.ejemplo.local/products/teclado-mecanico');
  await page.locator('#add-to-cart-button-main').click();
  await page.locator('a.header-cart-icon').click();
  await page.locator('button[data-action="proceed-to-checkout"]').click();

  await page.locator('input#cc-number').fill('4111111111111111');
  await page.locator('input#cc-exp').fill('12/29');
  await page.locator('input#cc-cvc').fill('123');
  await page.locator('button#confirm-order-btn').click();

  await expect(page.locator('div.alert-success.order-confirmation')).toContainText(
    'Pedido confirmado'
  );
});

test('muestra error si la tarjeta está caducada al finalizar compra', async ({ page }) => {
  // ¡Copiado y pegado línea por línea! Si cambia el selector de login o del carrito,
  // habrá que buscar y reemplazar en decenas de tests como este.
  await page.goto('https://tienda.ejemplo.local/login');
  await page.locator('input[name="user_email"]').fill('cliente@ejemplo.local');
  await page.locator('input[name="user_pass"]').fill('Secreto123!');
  await page.locator('button.btn-primary.submit-login').click();

  await page.goto('https://tienda.ejemplo.local/products/teclado-mecanico');
  await page.locator('#add-to-cart-button-main').click();
  await page.locator('a.header-cart-icon').click();
  await page.locator('button[data-action="proceed-to-checkout"]').click();

  await page.locator('input#cc-number').fill('4111111111111111');
  await page.locator('input#cc-exp').fill('01/20'); // <-- Único cambio real en todo el test
  await page.locator('input#cc-cvc').fill('123');
  await page.locator('button#confirm-order-btn').click();

  await expect(page.locator('div.alert-danger.payment-error')).toContainText(
    'La tarjeta ha caducado'
  );
});
```

En el segundo test, lo único que nos importaba probar era la fecha de caducidad `'01/20'`, pero está enterrada entre 15 líneas de selectores CSS duplicados. Si refactorizamos la infraestructura aplicando **[[DRY]]** (mediante *Page Objects*) y dejamos el cuerpo del test aplicando **[[DAMP]]**, el resultado pasa a ser mantenible y legible al instante.

---

## ¿Cuándo es aceptable ser WET temporalmente?

Aunque una suite permanentemente **WET** es un problema grave de mantenibilidad, muchos ingenieros sénior advierten que **una abstracción equivocada es mucho más cara de deshacer que el código duplicado**.

Como resumió Sandi Metz en una frase célebre de la ingeniería del software:

> *"La duplicación es mucho más barata que la abstracción equivocada."* (*Duplication is far cheaper than the wrong abstraction.*)

De esta idea surgen dos conceptos prácticos muy útiles al escribir tests:

### 1. La Regla de Tres (*Rule of Three*)
Popularizada por Martin Fowler en *Refactoring*:
1. La primera vez que necesitas preparar un escenario en un test, simplemente escríbelo de forma lineal.
2. La segunda vez que necesitas algo muy parecido en otro test, **permítete duplicarlo (sé WET a propósito)** y observa qué partes cambian y cuáles permanecen idénticas.
3. **A la tercera vez** que vayas a escribir ese mismo bloque de código, ya tienes suficiente contexto real para saber qué es común y qué es variable. Ese es el momento exacto de refactorizar y extraer un *Builder*, una *Fixture* o un método en tu *Page Object* ([[DRY]]).

### 2. El principio AHA (*Avoid Hasty Abstractions*)
Propuesto por Kent C. Dodds como alternativa al falso dilema entre [[DRY]] y **WET**. Significa **«Evita las abstracciones precipitadas»**:
* Si intentas crear un *framework* genérico de pruebas o una jerarquía de clases `BaseAbstractIntegrationTest` antes de haber escrito siquiera cinco tests reales, terminarás con un monstruo lleno de parámetros booleanos (`setupUser(isAdmin=True, withCart=False, skipValidation=True)`).
* Es preferible tolerar una pequeña cantidad de código repetido durante un par de días mientras entiendes el dominio del problema, y luego refactorizar hacia tests **[[DAMP]]** apoyados en utilidades **[[DRY]]** bien diseñadas.

> [!TIP] Diferencia entre WET (malo) y DAMP (bueno)
> No confundas **WET** con **[[DAMP]]**:
> * Un test **WET** repite **detalles técnicos irrelevantes** (selectores CSS, 20 campos de un JSON que no afectan al test, configuración de sockets).
> * Un test **[[DAMP]]** repite deliberadamente **la estructura narrativa del escenario** (`Arrange -> Act -> Assert`) llamando a funciones con nombres descriptivos para que el lector no tenga que saltar de archivo en archivo para entender qué ocurre.

---

## Cómo migrar una suite WET hacia DAMP + DRY

Si heredas un proyecto de automatización lleno de tests **WET** copiados y pegados, sigue estos pasos incrementales sin intentar reescribirlo todo de golpe:

1. **Extrae primero los selectores y endpoints ([[DRY]]):** Mueve todos los `page.locator(...)` y rutas HTTP a *Page Objects* o clientes de API. Esto detendrá inmediatamente la sangría de tests rotos cuando cambie la interfaz.
2. **Introduce constructores con valores por defecto (*Builders* / *Factories*):** Reemplaza los bloques de 30 líneas de creación de diccionarios JSON por una función `build_order(**overrides)` que rellene todos los campos obligatorios con datos válidos por defecto y solo reciba por parámetro el campo que el test necesita alterar.
3. **Deja la historia visible en el test ([[DAMP]]):** Conserva en cada función `test_...` los pasos de alto nivel (`crear_usuario`, `intentar_pago_con_tarjeta_caducada`, `verificar_rechazo`) para que cualquier compañero pueda diagnosticar un fallo en segundos.

Consulta la ficha de **[[DAMP]]** para ver el código resultante tras aplicar esta refactorización paso a paso.

---

## Referencias

1. Metz, S. (2016). *The Wrong Abstraction*. [https://sandimetz.com/blog/2016/1/20/the-wrong-abstraction](https://sandimetz.com/blog/2016/1/20/the-wrong-abstraction)
2. Dodds, K. C. (2020). *AHA Programming (Avoid Hasty Abstractions)*. [https://kentcdodds.com/blog/aha-programming](https://kentcdodds.com/blog/aha-programming)
3. Fowler, M. (2018). *Refactoring: Improving the Design of Existing Code* (2nd Edition — *Rule of Three*). Addison-Wesley.
