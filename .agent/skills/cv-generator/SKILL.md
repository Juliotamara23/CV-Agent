---
name: CV Generator
description: Genera un CV profesional en formato Harvard (HTML/CSS bilingüe) a partir de la base de conocimiento del usuario y lo guarda en la carpeta CVs/.
version: 1.0.0
---

## Propósito

Esta skill transforma la información de `conocimiento.md` en un archivo HTML profesional siguiendo estrictamente la plantilla Harvard ubicada en `cv-format/Harvard-Template.html`. El archivo resultante se guarda en la carpeta `CVs/` con un nombre derivado del nombre completo del usuario.

---

## Requisitos Previos

Antes de ejecutar esta skill, el agente **DEBE** verificar:

1. **`conocimiento.md` existe y está actualizado.** Si no existe, ejecutar primero la skill `knowledge-manager`.
2. **La plantilla Harvard existe** en `cv-format/Harvard-Template.html`.

---

## Flujo de Ejecución

### Paso 1: Leer la Base de Conocimiento

- Leer el archivo `conocimiento.md` ubicado en la raíz del proyecto.
- Extraer **todos** los datos relevantes organizados en las siguientes categorías:
  - Información básica (nombre completo, ubicación, teléfono, email, LinkedIn, GitHub, sitio web)
  - Perfil profesional / Resumen ejecutivo
  - Proyectos destacados
  - Experiencia laboral
  - Educación
  - Habilidades técnicas
  - Certificaciones
  - Idiomas

### Paso 2: Leer la Plantilla Harvard

- Leer `cv-format/Harvard-Template.html` para obtener la estructura exacta de HTML y CSS.
- **NUNCA modificar la plantilla original.** Solo usarla como referencia.

### Paso 3: Determinar el Nombre del Archivo

- Extraer el **nombre completo** del usuario desde `conocimiento.md` (sección de Información Básica).
- Generar el nombre del archivo siguiendo este formato:
  ```
  CV-{NombreApellido}.html
  ```
  - Usar PascalCase sin espacios ni caracteres especiales.
  - Ejemplo: Si el nombre es "Pepito Perez" → `CV-PepitoPerez.html`
  - Usar solo el primer nombre y primer apellido para mantenerlo corto.

### Paso 4: Crear la Carpeta CVs/ (si no existe)

- Verificar si la carpeta `CVs/` existe en la raíz del proyecto.
- Si no existe, **crearla automáticamente**.

### Paso 5: Generar el CV HTML

Crear un archivo HTML **completo y autocontenido** que siga estas reglas:

#### 5.1 Estructura HTML/CSS Obligatoria

El CV generado **DEBE** replicar exactamente los estilos CSS de la plantilla Harvard, incluyendo:

```css
:root {
  --harvard-red: #a51c30;
  --text-gray: #1a1a1a;
  --light-gray: #666;
  --border-gray: #ccc;
}
```

- **Fuentes**: Crimson Pro (títulos) + Inter (cuerpo), importadas desde Google Fonts.
- **Layout**: Contenedor `.page` simulando hoja A4 (210mm × 297mm).
- **Tipografía**: `h1` en 22pt, `h2` en 11pt uppercase, texto general en 9.5pt.
- **Grid de habilidades**: Usar `.skills-grid` con `grid-template-columns: auto 1fr`.
- **Estilos de impresión**: Incluir `@media print` para ocultar botones y eliminar sombras.
- **Clase .hidden**: Incluir `.hidden { display: none; }` para elementos opcionales.

#### 5.2 Estructura de Secciones (Orden Obligatorio)

El contenido debe seguir este orden estricto, definido en `CV-Agent.md`:

1. **Header**: Nombre completo (h1) + información de contacto
2. **Perfil**: Resumen ejecutivo (2-3 oraciones)
3. **Proyectos Destacados**: Seleccionar los más relevantes
4. **Experiencia Profesional**: Orden cronológico inverso
5. **Educación**: Orden cronológico inverso
6. **Habilidades Técnicas**: Agrupadas por categoría usando `.skills-grid`
7. **Certificaciones**: Lista de certificaciones
8. **Idiomas**: Niveles de competencia

#### 5.3 Soporte Bilingüe Obligatorio

El CV **DEBE** ser bilingüe (Español/Inglés) con las siguientes características:

- **Cada sección** debe tener dos versiones: una con `data-lang="es"` y otra con `data-lang="en"`.
- **Por defecto** se muestra español (`[data-lang="es"] { display: block; }`).
- **Las secciones en inglés** están ocultas por defecto (`[data-lang] { display: none; }`).
- **El header de contacto** debe tener dos versiones (es/en).
- **El `<h1>` con el nombre** NO lleva `data-lang` (es igual en ambos idiomas).

CSS requerido para el toggle de idioma:
```css
/* Language toggle */
[data-lang] {
  display: none;
}
[data-lang="es"] {
  display: block;
}
.skills-grid[data-lang="es"] {
  display: grid;
}
```

#### 5.4 Botones Flotantes

Incluir **dos botones flotantes** (fuera del `.page`, dentro del `<body>`):

1. **Botón de idioma** (`.lang-btn`):
   - Texto inicial: `🌐 English`
   - Posición: `bottom: 96px; right: 32px`
   - Color de fondo: `#333`

2. **Botón de PDF** (`.pdf-btn`):
   - Texto inicial: `📄 Descargar PDF`
   - Posición: `bottom: 32px; right: 32px`
   - Color de fondo: `var(--harvard-red)`
   - Acción: `window.print()`
   - Ambos botones deben tener la clase `no-print` para ocultarse al imprimir.

#### 5.5 Script de Toggle de Idioma

Incluir el siguiente script al final del `<body>`:

```javascript
let currentLang = "es";

function toggleLang() {
  currentLang = currentLang === "es" ? "en" : "es";

  // Update html lang attribute
  document.documentElement.lang = currentLang;

  // Toggle all data-lang elements
  document.querySelectorAll("[data-lang]").forEach((el) => {
    if (el.getAttribute("data-lang") === currentLang) {
      // Restore correct display type
      if (el.classList.contains("skills-grid")) {
        el.style.display = "grid";
      } else {
        el.style.display = "block";
      }
    } else {
      el.style.display = "none";
    }
  });

  // Update button text and PDF button
  const langBtn = document.getElementById("langToggle");
  const pdfBtn = document.querySelector(".pdf-btn");

  if (currentLang === "en") {
    langBtn.textContent = "🌐 Español";
    pdfBtn.innerHTML = "&#128196; Download PDF";
  } else {
    langBtn.textContent = "🌐 English";
    pdfBtn.innerHTML = "&#128196; Descargar PDF";
  }
}
```

### Paso 6: Guardar el Archivo

- Guardar el archivo generado en `CVs/{nombre-archivo}.html`.
- Si ya existe un archivo con el mismo nombre, **sobrescribirlo** con la versión actualizada.

---

## Reglas de Redacción

1. **Nunca inventar información.** Usar exclusivamente datos de `conocimiento.md`.
2. **Verbos de acción.** Comenzar cada bullet point con un verbo de acción (Desarrollé, Implementé, Diseñé, etc.).
3. **Logros cuantificables.** Priorizar métricas y resultados cuando estén disponibles.
4. **Tono profesional.** Formal, conciso y orientado a resultados.
5. **Sin pronombres personales.** No usar "yo", "mi", etc. en las descripciones.

---

## Adaptación a Oferta Laboral (Opcional)

Si el usuario proporciona una oferta de trabajo junto con la solicitud de generación:

1. **Analizar requisitos** de la oferta (tecnologías, habilidades, experiencia).
2. **Reordenar y priorizar** proyectos y experiencias según relevancia.
3. **Ajustar el perfil** profesional para alinearlo con el puesto.
4. **Incluir solo** los proyectos y tecnologías relevantes para la oferta.
5. **Disponibilidad para viajar**: Si la oferta lo requiere, quitar la clase `hidden` del span de disponibilidad en el header de contacto para hacerlo visible.
6. Al final del CV (como comentario HTML o como sección adicional no imprimible), incluir un **Análisis de Compatibilidad**:
   - ✅ Requisitos cumplidos
   - ⚠️ Requisitos parcialmente cumplidos
   - ❌ Requisitos no cumplidos
   - 💡 Sugerencias para mejorar la candidatura

---

## Ejemplo de Salida

El archivo generado debería tener esta estructura general:

```
CVs/CV-{NombreApellido}.html
```

```html
<!doctype html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{Nombre Completo} - CV</title>
    <link href="https://fonts.googleapis.com/css2?family=Crimson+Pro:wght@400;600;700&family=Inter:wght@400;600&display=swap" rel="stylesheet" />
    <style>
      /* ... Estilos completos de la plantilla Harvard ... */
    </style>
  </head>
  <body>
    <div class="page">
      <header>
        <h1>NOMBRE COMPLETO EN MAYÚSCULAS</h1>
        <div class="contact-info" data-lang="es">...</div>
        <div class="contact-info" data-lang="en">...</div>
      </header>

      <!-- ==================== ESPAÑOL ==================== -->
      <section data-lang="es"><!-- Perfil --></section>
      <section data-lang="es"><!-- Proyectos --></section>
      <section data-lang="es"><!-- Experiencia --></section>
      <section data-lang="es"><!-- Educación --></section>
      <section data-lang="es"><!-- Habilidades --></section>
      <section data-lang="es"><!-- Certificaciones --></section>
      <section data-lang="es"><!-- Idiomas --></section>

      <!-- ==================== ENGLISH ==================== -->
      <section data-lang="en"><!-- Profile --></section>
      <section data-lang="en"><!-- Projects --></section>
      <section data-lang="en"><!-- Experience --></section>
      <section data-lang="en"><!-- Education --></section>
      <section data-lang="en"><!-- Skills --></section>
      <section data-lang="en"><!-- Certifications --></section>
      <section data-lang="en"><!-- Languages --></section>
    </div>

    <!-- Floating buttons -->
    <button class="no-print lang-btn" id="langToggle" onclick="toggleLang()">🌐 English</button>
    <button class="no-print pdf-btn" onclick="window.print()">&#128196; Descargar PDF</button>

    <script>
      /* ... Script de toggle de idioma ... */
    </script>
  </body>
</html>
```

---

## Verificación Post-Generación

Después de generar el CV, el agente debe confirmar:

- [ ] El archivo existe en `CVs/`.
- [ ] El HTML es válido y se puede abrir en un navegador.
- [ ] Ambos idiomas (ES/EN) funcionan correctamente.
- [ ] Los botones flotantes aparecen y funcionan.
- [ ] Los hipervínculos (email, WhatsApp, LinkedIn, GitHub) son correctos.
- [ ] El diseño respeta el formato Harvard (tipografía, colores, layout A4).
