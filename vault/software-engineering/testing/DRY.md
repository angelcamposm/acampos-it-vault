---
aliases:
  - DRY
  - Don't Repeat Yourself
  - Principio DRY en testing
date: 2026-11-15
description: Qué es el principio DRY (Don't Repeat Yourself), cómo aplicarlo correctamente en la infraestructura de automatización de pruebas y por qué su abuso dentro de los tests destruye la legibilidad.
draft: false
enableToc: true
publish: true
tags:
  - software_engineering
  - testing
  - test_automation
  - clean_code
  - dry
title: "DRY (Don't Repeat Yourself)"
---

El principio **DRY** (*Don't Repeat Yourself*, o «No te repitas») fue formulado por Andy Hunt y Dave Thomas en su libro clásico *The Pragmatic Programmer* (1999). Su definición original establece que:

> *"Cada pieza de conocimiento debe tener una representación única, inequívoca y autoritativa dentro de un sistema."*

En el código de producción, aplicar **DRY** evita que una misma regla de negocio o configuración esté dispersa en múltiples archivos. Sin embargo, en **automatización de pruebas** (*Testing Automation*), aplicar DRY de forma ciega eliminando cualquier línea similar entre tests suele producir suites frágiles, difíciles de leer y propensas a errores ocultos.

Para dominar DRY en testing es fundamental distinguir entre **duplicación de infraestructura técnica** (donde DRY es obligatorio) y **duplicación declarativa del escenario de prueba** (donde debe prevalecer [[DAMP]]).

---

## Dónde sí aplicar DRY en Testing Automation

El principio DRY brilla cuando se aplica a la **capa de soporte e infraestructura de pruebas** (todo aquello que responde al *cómo* interactuar con el sistema y no al *qué* se está verificando):

### 1. Localizadores y acciones de interfaz (*Page Object Model* / *Screenplay*)
Si tienes 40 pruebas *End-to-End* (`E2E`) con Playwright que interactúan con el formulario de pago, el selector CSS o `data-testid` del botón de pagar **debe existir en un único lugar**. Si el equipo de frontend cambia `data-testid="pay-btn"` por `data-testid="checkout-submit"`, solo tendrás que actualizar una línea en tu clase `CheckoutPage` en lugar de editar 40 tests (lo que sería un caso grave de código [[WET]]).

### 2. Clientes de API y serialización
La construcción de cabeceras HTTP (`Authorization: Bearer ...`), URLs base, manejo de reintentos y parseo de respuestas debe centralizarse en un cliente o *wrapper* reutilizable.

### 3. Factorías de datos y *Test Data Builders*
Crear una entidad en base de datos suele requerir rellenar decenas de campos obligatorios (`id`, `created_at`, `email`, `country`, `currency`...) que no tienen relevancia para el caso concreto que estás probando. Encapsular esa creación en una función factoría o *Builder* aplica DRY sobre los detalles irrelevantes y deja el test limpio.

```typescript
// ✅ Buen uso de DRY en la capa de infraestructura (Playwright + TypeScript)
// Archivo: tests/pages/LoginPage.ts
import { Page, Locator } from '@playwright/test';

export class LoginPage {
  private readonly emailInput: Locator;
  private readonly passwordInput: Locator;
  private readonly submitButton: Locator;

  constructor(private readonly page: Page) {
    this.emailInput = page.getByTestId('login-email');
    this.passwordInput = page.getByTestId('login-password');
    this.submitButton = page.getByTestId('login-submit');
  }

  async login(email: string, password: string): Promise<void> {
    await this.emailInput.fill(email);
    await this.passwordInput.fill(password);
    await this.submitButton.click();
  }
}
```

---

## El peligro del "Over-DRY" (Sobreabstracción en los tests)

Cuando un ingeniero intenta eliminar **toda** repetición visual dentro de los archivos de test (`.spec.ts` o `test_*.py`), suele introducir antipatrones clásicos documentados por Gerard Meszaros en *xUnit Test Patterns*:

### Antipatrones causados por exceso de DRY

1. **El Huésped Misterioso (*Mystery Guest*):**
   Para no repetir la creación de usuarios en cada test, alguien mueve todos los `INSERT` a un `beforeEach` global o a un archivo `seed_data.sql` de 500 líneas. Al leer el test solo ves `expect(getCartTotal(userId: 42)).toBe(150.00)`. ¿Por qué da `150.00`? ¿Qué productos tiene el usuario `42`? ¿Tiene un cupón VIP? Para saberlo tienes que abrir otros tres archivos.
2. **Lógica condicional y bucles dentro del test:**
   Para ahorrarse escribir tres tests parecidos, se mete un bucle `for` con bloques `if/else` que calculan dinámicamente el resultado esperado. **Si tu test tiene la misma complejidad ciclomática que el código de producción, es muy probable que tenga los mismos bugs.**
3. **Aserciones calculadas (*Computed Assertions*):**
   Reutilizar la misma fórmula o concatenación del código de producción dentro del `assert` para "no repetir constantes". Si la fórmula está mal planteada, tanto el código como el test darán el mismo resultado erróneo y el test pasará en verde (falso positivo).

### Ejemplo de mal uso de DRY vs refactorización a [[DAMP]]

Observa este ejemplo en **Python (`pytest`)** donde un exceso de DRY hace que el test sea casi imposible de auditar a simple vista:

```python
# ❌ MAL: Exceso de DRY (Lógica compleja, bucles y cálculo dinámico en el test)
BASE_PRICES = [100.0, 250.0, 50.0]
ROLES = ["STANDARD", "VIP", "EMPLOYEE"]
DISCOUNTS = {"STANDARD": 0.0, "VIP": 0.10, "EMPLOYEE": 0.30}

def test_discounts_for_all_roles():
    for price in BASE_PRICES:
        for role in ROLES:
            user = create_user(role=role)
            # Calculamos el esperado usando la misma fórmula que producción:
            # Si nos equivocamos en la fórmula, ¡el test nunca detectará el bug!
            expected = round(price * (1 - DISCOUNTS[role]), 2)
            assert calculate_final_price(price, user) == expected
```

¿Qué ocurre cuando este test falla en la iteración 7 del bucle? El mensaje de error es confuso y tienes que hacer cuentas mentales para saber qué valores se estaban probando. Además, si quieres usar parametrización sin perder claridad, `pytest` ofrece `@pytest.mark.parametrize` con valores literales explícitos (combinando la reutilización de estructura de **DRY** con la claridad de **[[DAMP]]**):

```python
# ✅ BIEN: Parametrización limpia con valores literales explícitos (DRY + DAMP)
import pytest

@pytest.mark.parametrize(
    "base_price, role, expected_final_price",
    [
        (100.0, "STANDARD", 100.0),  # Sin descuento para clientes estándar
        (100.0, "VIP", 90.0),        # 10% de descuento para clientes VIP
        (100.0, "EMPLOYEE", 70.0),   # 30% de descuento para empleados
    ],
)
def test_calculate_final_price_applies_role_discount(base_price, role, expected_final_price):
    user = create_user(role=role)

    actual_price = calculate_final_price(base_price, user)

    assert actual_price == expected_final_price
```

> [!WARNING] Cuidado con los bloques `beforeEach` / `setUp` gigantes
> Extraer 10 líneas de preparación a un `beforeEach` parece una gran idea cuando tienes 3 tests que usan exactamente el mismo escenario. Pero seis meses después, el archivo tiene 25 tests: 10 de ellos solo necesitan la mitad de ese `beforeEach`, otros 5 sobrescriben los datos creados en el `beforeEach` porque necesitan un estado distinto, y todos los tests se vuelven lentos porque ejecutan preparaciones innecesarias. Prefiere funciones *helper* llamadas explícitamente dentro de cada test.

---

## Resumen: Reglas prácticas para aplicar DRY en pruebas

* **Extrae el *cómo*, no el *qué*:** Oculta en funciones auxiliares o *Page Objects* los detalles de bajo nivel (selectores DOM, cabeceras HTTP, conexiones SQL), pero deja visibles en el test los datos de entrada y los resultados esperados.
* **Prohíbe estructuras de control en el cuerpo del test:** Un test no debe contener `if`, `switch`, `while`, bloques `try/catch` genéricos ni cálculos matemáticos en el lado esperado del `assert`.
* **Compara siempre con [[WET]] y [[DAMP]]:** Revisa la [[software-engineering/testing/index|guía comparativa general]] para ver cómo equilibrar tus abstracciones.

---

## Referencias

1. Hunt, A., & Thomas, D. (1999). *The Pragmatic Programmer: From Journeyman to Master*. Addison-Wesley.
2. Meszaros, G. (2007). *xUnit Test Patterns: Refactoring Test Code* (Capítulos sobre *Test Smells*: *Mystery Guest*, *Conditional Test Logic*). Addison-Wesley.
3. Google Testing Blog (2014). *Don't Put Logic in Tests*. [https://testing.googleblog.com/2014/07/testing-on-toilet-dont-put-logic-in.html](https://testing.googleblog.com/2014/07/testing-on-toilet-dont-put-logic-in.html)
