<h1 align="center">CV-Agent</h1>

**CV-Agent** es un sistema de gestión de carrera basado en agentes, diseñado para la creación automatizada de currículum vitae profesionales de alto impacto. Transforma fuentes de información desestructuradas en una **Single Source of Truth (SSOT)** verificada, asegurando coherencia y relevancia en cada aplicación.

## Características Clave

### 🧠 Identidad Senior & Humilde
El agente opera bajo el estándar `AGENTS.md`, priorizando hechos cuantificables sobre buzzwords. Su personalidad es data-driven, profesional y orientada a resultados técnicos reales.

### 🛡️ Integridad de Conocimiento (Shielding)
- **Deduplicación Semántica**: Análisis automático de N-gramas para evitar repeticiones de proyectos o experiencias en tu SSOT.
- **Validación de Fuentes**: Solo procesa archivos Markdown (.md) de menos de 1MB, garantizando una ingesta de datos limpia y eficiente.
- **Auditoría de Integridad**: El flujo de actualización (`actualizar-conocimiento.md`) es bloqueante: si detecta duplicados o archivos corruptos, el agente detiene el proceso hasta que tú los resuelvas.

### 🔄 Sincronización Inteligente
- **GitHub Deep Sync**: Automatización vía CLI (`gh`) que extrae logros técnicos directamente de tus repositorios, analizando tanto READMEs como el historial de commits cuando la documentación es escasa.
- **Persistencia Conversacional**: El usuario gestiona las fuentes de forma dialogada. El agente no edita `conocimiento.md` a ciegas; propone cambios en archivos de `Fuentes/` que tú apruebas.

## Estructura del Proyecto

```text
CV-agent/
├── .agent/              # Core: Skills (Knowledge Manager, Source Manager) y Workflows
├── Fuentes/             # Fuentes de Verdad (Markdown único, archivos <1MB)
├── scripts/             # Automatización (Deep Sync GitHub, Sanity Checks)
├── templates/           # Plantilla visual Harvard (HTML/CSS)
├── CVs/                 # Salida de documentos generados
└── conocimiento.md      # SSOT final, validada y libre de duplicados
```

## Flujo de Trabajo (SDD)

1.  **Ingesta**: Colocas tus fuentes Markdown en `Fuentes/`.
2.  **Validación**: Ejecutas la sincronización (GitHub vía `scripts/sync-github.ps1`).
3.  **Consolidación**: El `knowledge-manager` ejecuta el *Sanity Check* y deduplicación.
4.  **Discusión**: Ajustas la información conversando con el agente sobre tus logros.
5.  **Generación**: Tras la aprobación, se genera el CV bilingüe en `CVs/` bajo el estándar Harvard.

## Uso

Para iniciar, asegúrate de que tus archivos en `Fuentes/` estén en formato `.md`.
Pide al agente: *"Genera mi CV"* o *"Adapta mi CV a esta oferta: [URL/Texto]"*.

---
*Diseñado para la integridad, automatizado para la precisión.*
