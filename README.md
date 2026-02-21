# CV-Agent 📄🤖

**CV-Agent** es un ecosistema inteligente diseñado para la gestión, optimización y generación dinámica de currículum vitae profesionales. Utiliza un enfoque basado en agentes para transformar una base de conocimiento desestructurada en documentos de alto impacto que cumplen con los estándares de reclutamiento más exigentes.

## 🚀 Propósito

El objetivo principal de este proyecto es automatizar la creación de CVs altamente personalizados y adaptados a ofertas laborales específicas, asegurando coherencia total mediante una "Fuente Única de Verdad" y utilizando el **formato Harvard** como estándar de diseño.

## 🛠️ Componentes Principales

### 1. Base de Conocimiento (`conocimiento.md`)
Es el núcleo del sistema. Contiene toda la trayectoria profesional, proyectos, habilidades y certificaciones del usuario. Al estar centralizada, garantiza que cualquier CV generado contenga información verificada y actualizada.

### 2. Agente de CV (`CV-Agent.md`)
El cerebro del proyecto. Este archivo define el comportamiento del asistente IA, incluyendo:
-   **Reglas de Formato**: Aplicación estricta del estilo Harvard.
-   **Flujo de Adaptación**: Análisis de ofertas laborales (JDs) para reordenar y destacar lo más relevante.
-   **Análisis de Compatibilidad**: Evaluación de requisitos cumplidos, brechas y sugerencias estratégicas.

### 3. Plantillas y Formatos
-   **Harvard-Template.html**: El estándar visual. Elegantemente estructurado en HTML/CSS, optimizado para legibilidad y sistemas de seguimiento de candidatos (ATS).
-   **Interactividad**: Los CVs generados incluyen un botón flotante inteligente para descargar en PDF (usando la función nativa del navegador para preservar hipervínculos).

## 📂 Estructura del Proyecto

```text
├── .agent/             # Skills y Workflows internos del agente
├── .gemini/            # Configuración específica del entorno de IA
├── CVs/                # (Ignorado) Salidas de CVs generados en HTML/CSS
├── Fuentes/            # (Ignorado) Documentos originales (GitHub, LinkedIn, etc.)
├── cv-format/          # Plantilla base en formato Harvard
├── conocimiento.md     # (Ignorado) Perfil consolidado del usuario
├── CV-Agent.md         # Definición del sistema y lógica del agente
└── README.md           # Este archivo
```

## 📋 Cómo Funciona

1.  **Recopilación**: Se extrae información de fuentes como LinkedIn y GitHub hacia `Fuentes/`.
2.  **Consolidación**: El agente procesa estas fuentes para mantener actualizado `conocimiento.md`.
3.  **Sincronización**: Cuando se requiere un CV, el agente lee `conocimiento.md` y lo inyecta en la estructura de la plantilla Harvard.
4.  **Adaptación**: Si el usuario proporciona una oferta laboral, el agente analiza la compatibilidad y genera una versión optimizada destacando las coincidencias clave.

## 📥 Uso Recomendado

Para generar o actualizar el CV:
1.  Asegúrate de que `conocimiento.md` esté al día.
2.  Pide al agente: *"Genera mi CV general"* o *"Adapta mi CV a esta oferta: [pegar descripción del empleo]"*.
3.  Abre el archivo generado en `CVs/`, revisa y usa el botón **Descargar PDF**.

---
*Desarrollado como una solución integral para profesionales que buscan eficiencia y precisión en su búsqueda de empleo.*
