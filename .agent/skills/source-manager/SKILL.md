---
name: Source Manager
description: Gestiona la validación, filtrado y extracción de metadatos de archivos fuente (.md) para asegurar la integridad de la base de conocimiento del CV-Agent.
version: 1.0.0
---

## Sanity Check
- **Cumplimiento de Formato**: Procesar ESTRICTAMENTE archivos `.md`.
- **Límite de Tamaño**: Máximo 1MB por archivo.
- **Acciones de Validación**:
  - Archivo no Markdown: Ignorar y emitir advertencia.
  - Archivo > 1MB: Rechazar y solicitar optimización o división.

## Capacidades
- **Extracción de Metadatos**: Extrae metadatos (fecha, autor, tipo de fuente, versión) del encabezado YAML de archivos fuente.
- **Validación de Integridad**: Asegura que la estructura Markdown cumple con los estándares del proyecto antes de la ingesta.
- **Pre-procesamiento**: Normalización de formato Markdown para facilitar el consumo posterior por otros agentes.

## Uso
Esta skill debe ejecutarse antes de cualquier operación de lectura o procesamiento masivo de datos para asegurar que los datos fuente sean válidos y seguros.
