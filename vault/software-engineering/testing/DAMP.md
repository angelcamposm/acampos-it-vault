---
aliases:
  - DAMP
  - Descriptive And Meaningful Phrases
  - Principio DAMP en testing
date: 2026-11-15
description: Qué es el principio DAMP (Descriptive And Meaningful Phrases), por qué es el estándar recomendado para escribir pruebas automatizadas legibles y cómo implementarlo con Test Data Builders y el patrón AAA.
draft: false
enableToc: true
publish: true
tags:
  - software_engineering
  - testing
  - test_automation
  - clean_code
  - damp
title: "DAMP (Descriptive And Meaningful Phrases)"
---

El acrónimo **DAMP** (*Descriptive And Meaningful Phrases*, o «Frases descriptivas y con significado») fue acuñado por Jay Fields y adoptado como estándar de ingeniería en empresas como Google (véase el capítulo 12 de *Software Engineering at Google*).

Mientras que en el código de producción el objetivo primordial suele ser evitar la duplicación mediante **[[DRY]]** (*Don't Repeat Yourself*), en el código de pruebas automatizadas el objetivo principal es **que el test sirva como documentación ejecutable y permita diagnosticar fallos en segundos**.

> [!IMPORTANT] El principio rector de DAMP
> Un test se escribe una vez, pero se lee decenas de veces —especialmente a las 3 de la mañana o justo antes de un despliegue cuando un pipeline de `CI/CD` se pone en rojo—. **DAMP** establece que vale la pena repetir unas pocas líneas de código en cada test si a cambio cualquier ingeniero puede entender qué falló leyendo únicamente ese test de arriba abajo, sin saltar a otros archivos ni hacer *scroll* hacia un `beforeEach` lejano.

---

## ¿Qué hace que un test sea DAMP?

Un test diseñado bajo la filosofía **DAMP** cumple cuatro características esenciales:

1. **Autocontenido (*Self-Contained*):**
   Toda la información que explica **por qué** el test produce un resultado determinado está presente visualmente dentro del cuerpo del propio test. No hay «números mágicos» ocultos en archivos externos.
2. **Oculta lo irrelevante y destaca lo relevante:**
   Apoyándose en infraestructura **[[DRY]]** (como *Test Data Builders* o funciones factoría con valores por defecto), el test **solo especifica los parámetros que influyen en el comportamiento probado**. Si pruebas que una cuenta bloqueada no puede transferir dinero, el único atributo que pasas al crear la cuenta es `status="BLOCKED"`; el nombre, email o fecha de alta se rellenan solos por debajo.
3. **Estructura lineal *Arrange - Act - Assert* (AAA):**
   Cada test se divide visualmente en tres párrafos separados por una línea en blanco:
   * **Arrange (Given):** Preparar el estado y los datos explícitos del escenario.
   * **Act (When):** Ejecutar la acción única que se desea poner a prueba.
   * **Assert (Then):** Comprobar el resultado esperado mediante valores literales claros.
4. **Lenguaje del dominio (*Domain Language*):**
   Las funciones auxiliares y los métodos se nombran según lo que hacen en el negocio (`transfer_money`, `checkout_with_expired_card`), no según detalles de implementación (`click_button_3`, `post_json_payload`).

---

## Comparativa en código: de DRY extremo y WET a DAMP

Veamos cómo se transforma un mismo conjunto de pruebas en **Python (`pytest`)** y **TypeScript (`Playwright` / `Jest`)** cuando aplicamos **DAMP** apoyado sobre constructores **[[DRY]]**.

### Ejemplo 1: Pruebas unitarias / de integración en Python (`pytest`)

Supongamos que probamos el motor de concesión de préstamos de un banco:

* Si el test es **[[WET]]**, cada test tendrá 25 líneas rellenando nombre, DNI, dirección, teléfono, estado civil, antigüedad e ingresos del solicitante.
* Si el test peca de **exceso de [[DRY]]**, usará usuarios predefinidos opacos (`user_1`, `user_2`) creados en un `conftest.py` lejano y nadie sabrá por qué `user_2` es rechazado.
* Con **DAMP + Test Data Factory**, creamos una función constructora con valores válidos por defecto y en cada test **solo sobrescribimos el dato que causa el fallo o el éxito**:

```python
# Infraestructura DRY: Factoría con valores válidos por defecto (oculta el ruido)
def make_applicant(
    *,
    age: int = 30,
    monthly_income: float = 3000.0,
    has_unpaid_debts: bool = False,
) -> Applicant:
    return Applicant(
        full_name="Ana García",       # Irrelevante para las reglas de riesgo
        national_id="12345678Z",      # Irrelevante
        address="Calle Mayor 1",      # Irrelevante
        age=age,
        monthly_income=monthly_income,
        has_unpaid_debts=has_unpaid_debts,
    )


# ✅ Tests DAMP: Cada test se lee como una frase descriptiva y autónoma
def test_loan_is_approved_for_solvent_adult_applicant():
    applicant = make_applicant(age=35, monthly_income=2500.0, has_unpaid_debts=False)

    decision = evaluate_loan_request(applicant, requested_amount=10000.0)

    assert decision.approved is True
    assert decision.rejection_reason is None


def test_loan_is_rejected_when_applicant_is_underage():
    # Aunque 'make_applicant' se repite en cada test, aquí vemos de inmediato
    # que age=17 es la causa exacta por la que se rechaza el préstamo.
    underage_applicant = make_applicant(age=17)

    decision = evaluate_loan_request(underage_applicant, requested_amount=1000.0)

    assert decision.approved is False
    assert decision.rejection_reason == "APPLICANT_MUST_BE_ADULT"


def test_loan_is_rejected_when_applicant_has_unpaid_debts():
    indebted_applicant = make_applicant(has_unpaid_debts=True)

    decision = evaluate_loan_request(indebted_applicant, requested_amount=1000.0)

    assert decision.approved is False
    assert decision.rejection_reason == "ACTIVE_DELINQUENCY_RECORD"
```

Fíjate en la ventaja diagnóstica: en `test_loan_is_rejected_when_applicant_is_underage`, no necesitas mirar qué valores tienen el sueldo o el DNI; al ver únicamente `make_applicant(age=17)`, tu cerebro conecta en medio segundo la causa (`age=17`) con el efecto (`"APPLICANT_MUST_BE_ADULT"`).

---

### Ejemplo 2: Refactorizando tests E2E de [[WET]] a DAMP en Playwright (TypeScript)

En la ficha sobre **[[WET]]** vimos dos tests de compra con tarjeta donde se repetían 15 líneas de selectores CSS (`page.locator(...)`). Veamos cómo quedan esos mismos dos tests al combinar **DAMP** en el test con **[[DRY]]** en los *Page Objects*:

```typescript
// ✅ Tests E2E con DAMP: Expresivos, legibles y resistentes a cambios de interfaz
import { test, expect } from '@playwright/test';
import { StoreApp } from './support/StoreApp';
import { validCard, expiredCard } from './support/testCards';

test('un usuario estándar puede finalizar una compra con una tarjeta válida', async ({ page }) => {
  const store = new StoreApp(page);

  await store.loginAsStandardCustomer();
  await store.addProductToCart('teclado-mecanico');
  await store.checkoutWithCard(validCard({ number: '4111111111111111', expiry: '12/29' }));

  await expect(store.orderConfirmationBanner).toContainText('Pedido confirmado');
});

test('muestra un error claro si el usuario intenta pagar con una tarjeta caducada', async ({ page }) => {
  const store = new StoreApp(page);

  await store.loginAsStandardCustomer();
  await store.addProductToCart('teclado-mecanico');
  await store.checkoutWithCard(expiredCard({ expiry: '01/20' }));

  await expect(store.paymentErrorAlert).toContainText('La tarjeta ha caducado');
});
```

Observa por qué este enfoque es **DAMP** y no **[[DRY]]** extremo:
* **Se repiten tres líneas** (`new StoreApp`, `loginAsStandardCustomer`, `addProductToCart`) en ambos tests.
* Un fanático del **[[DRY]]** habría metido esas tres líneas en un `beforeEach`. Pero si más adelante añades un tercer test en ese mismo archivo (`test('un usuario con el carrito vacío no puede ir al checkout')`), el `beforeEach` que añade un teclado mecánico al carrito te estorbaría.
* Al mantener esas tres frases descriptivas (`loginAsStandardCustomer`, `addProductToCart`, `checkoutWithCard`) explícitas en cada test, cualquier persona entiende el flujo completo de principio a fin sin que el mantenimiento sufra (porque los selectores reales están encapsulados dentro de `StoreApp`).

---

## Patrones clave para lograr tests DAMP

| Patrón | Qué problema resuelve | Cómo ayuda a DAMP |
| :--- | :--- | :--- |
| **Test Data Builder / Factory** | Crear entidades de dominio requiere pasar 15 parámetros al constructor. | Define valores válidos por defecto para todos los campos y permite sobrescribir con nombre (*named arguments*) solo el dato relevante para el test. |
| **Page Object Model (`POM`) / App Actions** | Los selectores del DOM (`#btn-submit`, `xpath`) ensucian el test y se rompen a menudo. | Expone métodos con nombres de negocio (`checkoutWithCard()`) que hacen que el test se lea como prosa en inglés o español. |
| **Custom Assertions / Matchers** | Comprobar el estado de una respuesta compleja requiere 6 líneas de `assert` técnicos. | Agrupa comprobaciones técnicas bajo una frase con significado de dominio, por ejemplo: `expect(response).toBeRejectedWithCode('CARD_EXPIRED')`. |

> [!TIP] La prueba de fuego para saber si tu test es DAMP
> Abre uno de tus archivos de test, tapa con la mano los `import` y los bloques `beforeEach`, y lee únicamente una función `test(...)`.
> * ¿Puedes explicar exactamente **qué condición inicial** provoca **qué resultado esperado** sin mover el cursor fuera de esa función?
> * Si la respuesta es **sí**, tu test es **DAMP**.
> * Si tienes que navegar a la definición de tres *fixtures* o leer 40 líneas de selectores HTML para enterarte, tu test sufre de exceso de **[[DRY]]** o de **[[WET]]**.

---

## Referencias

1. Winters, T., Manshreck, T., & Wright, H. (2020). *Software Engineering at Google* (Capítulo 12: *Unit Testing* — "Make Tests DAMP, Not DRY"). O'Reilly Media. [https://abseil.io/resources/swe-book/html/ch12.html](https://abseil.io/resources/swe-book/html/ch12.html)
2. Fields, J. (2014). *Working Effectively with Unit Tests*. Leanpub.
3. Google Testing Blog (2019). *Testing on the Toilet: Tests Too DRY? Make Them DAMP!*. [https://testing.googleblog.com/2019/12/testing-on-toilet-tests-too-dry-make.html](https://testing.googleblog.com/2019/12/testing-on-toilet-tests-too-dry-make.html)
4. Pryce, N. (2007). *Test Data Builders: an alternative to the Object Mother pattern*. [http://www.natpryce.com/articles/000714.html](http://www.natpryce.com/articles/000714.html)
