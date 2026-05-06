---
description: Sincronización manual de datos de GitHub con extracción de metadatos.
---

### Objetivo
Sincronizar manualmente la información del perfil y proyectos de GitHub, garantizando que los metadatos de sincronización se mantengan actualizados para el seguimiento de la frescura de los datos.

### Pre-requisitos
- El usuario debe tener la GitHub MCP configurada.
- Archivo `Fuentes/perfil_github.md` presente.

### Estado Actual (Antes de la ejecución)
- `last_updated`: [Verificar el valor en la sección de metadatos de `Fuentes/perfil_github.md`]

### Pasos
1. **Verificación**: Antes de iniciar, revisar el valor de `last_updated` en el encabezado YAML de `Fuentes/perfil_github.md`.
2. **Sincronización**: Ejecutar el script `scripts/sync-github.ps1`.
3. **Validación de Metadatos**:
   - Una vez finalizado el script, actualizar manualmente el campo `last_updated` en el encabezado YAML de `Fuentes/perfil_github.md` con la fecha actual.
4. **Finalización**: Verificar que la sección `<!-- GITHUB_SYNC_START -->` en `Fuentes/perfil_github.md` contenga la información actualizada.
