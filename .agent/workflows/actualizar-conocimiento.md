---
description: Sincroniza y actualiza la base de conocimientos (conocimiento.md) a partir de los archivos en la carpeta Fuentes.
---

### Objetivo
Mantener el archivo `conocimiento.md` actualizado con la información más reciente de las fuentes (`Fuentes/`), eliminando redundancias y organizando la información de manera óptima para el consumo por parte de agentes de IA.

### Pasos

1. **Recopilación de Fuentes**:
   - Listar el contenido del directorio `Fuentes/`.
   - Leer individualmente cada archivo encontrado (ej. `.md`, `.pdf`, `.txt`).

2. **Análisis y Consolidación**:
   - Identificar información duplicada entre las fuentes (ej. la misma experiencia laboral en el CV y en LinkedIn).
   - Resolver discrepancias priorizando la información más reciente o detallada.
   - Extraer proyectos específicos de GitHub del archivo `perfil_github.md`.

3. **Estructuración del Documento**:
   Organizar la información en `conocimiento.md` siguiendo exactamente este orden:
   - **Información Básica**: Nombre, contacto, ubicación, enlaces (LinkedIn, GitHub) e intereses.
   - **Experiencia Laboral**: Listado cronológico inverso con fechas, cargo, empresa, tecnologías y responsabilidades.
   - **Proyectos Destacados**: Categorizados (Full Stack, IA/Automatización, MCP, Herramientas CLI).
   - **Educación**: Títulos académicos y cursos relevantes.
   - **Certificaciones**: Certificados técnicos y skill badges.
   - **Habilidades Técnicas**: Desglosadas por categorías (Lenguajes, Frameworks, Bases de Datos, DevOps, IA).
   - **Idiomas**: Idioma y nivel.
   - **Resumen de Perfil**: Una síntesis profesional que resuma la propuesta de valor del usuario.

4. **Optimización para IA**:
   - Usar tablas Markdown para datos estructurados (Información Básica, Proyectos, Certificaciones, Idiomas).
   - Usar listas con viñetas para responsabilidades y habilidades.
   - Asegurar que los nombres de las tecnologías sean precisos y consistentes.

5. **Actualización del Archivo**:
   - Sobrescribir `conocimiento.md` con el nuevo contenido generado.
   - Verificar que no se haya perdido información crítica durante la consolidación.