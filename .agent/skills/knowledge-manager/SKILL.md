---
name: Knowledge Manager
description: Esta skill permite procesar múltiples fuentes de información profesional (CVs, perfiles de redes sociales, repositorios) para generar una "Single Source of Truth" (SSOT) en un archivo de conocimiento estructurado.
version: 1.0.1
---

## Sanity Check
- **Cumplimiento de Formato**: Procesar ESTRICTAMENTE archivos `.md`.
- **Límite de Tamaño**: Máximo 1MB por archivo.
- **Patrones de Ignorado**: Omitir automáticamente archivos `.tmp`, `~*`, `temp*` y `.DS_Store`.
- **Acciones de Validación**:
  - Archivo no Markdown: Ignorar y registrar una advertencia.
  - Archivo > 1MB: Rechazar e informar un error al usuario.

## Capacidades
- **Extracción Inteligente**: Identifica datos clave en archivos Markdown.
- **Deduplicación**: Cruza información de múltiples fuentes para eliminar entradas repetidas (ej. la misma experiencia en LinkedIn y CV).
- **Estructuración Semántica**: Organiza la información en un formato altamente legible para LLMs y agentes de IA.
- **Categorización de Proyectos**: Clasifica automáticamente proyectos de GitHub por stack tecnológico y dominio.

## Deduplicación Semántica
- **`computeFingerprint(entry)`**: Normaliza el texto de una entrada (minúsculas, eliminar puntuación, espacios extra) y calcula un hash N-gram (n=3) para identificar la estructura semántica.
- **`deduplicateEntries(entries[])`**: Agrupa entradas basadas en el fingerprint calculado. Resuelve conflictos manteniendo la entrada más larga o, en caso de empate, la más reciente basada en la fecha de modificación del archivo original.

## Uso
Para activar esta skill, el agente debe:
1. Leer los archivos en el directorio `Fuentes/`.
2. Seguir el esquema de organización definido en `conocimiento.md`.
3. Validar la consistencia de fechas y tecnologías mencionadas.

## Estructura de Salida Requerida
La skill debe producir o actualizar un archivo con las siguientes secciones:
1. Información Básica (Tabla)
2. Experiencia Laboral (Cronología inversa)
3. Proyectos Destacados (Categorizados)
4. Educación
5. Certificaciones
6. Habilidades Técnicas (Agrupadas)
7. Idiomas
8. Resumen de Perfil