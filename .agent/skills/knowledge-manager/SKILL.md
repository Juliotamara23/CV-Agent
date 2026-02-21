# Skill: Knowledge Manager

## Descripción
Esta skill permite procesar múltiples fuentes de información profesional (CVs, perfiles de redes sociales, repositorios) para generar una "Single Source of Truth" (SSOT) en un archivo de conocimiento estructurado.

## Capacidades
- **Extracción Inteligente**: Identifica datos clave en archivos Markdown y texto.
- **Deduplicación**: Cruza información de múltiples fuentes para eliminar entradas repetidas (ej. la misma experiencia en LinkedIn y CV).
- **Estructuración Semántica**: Organiza la información en un formato altamente legible para LLMs y agentes de IA.
- **Categorización de Proyectos**: Clasifica automáticamente proyectos de GitHub por stack tecnológico y dominio.

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
