# Exploration: Project Restructuring and CLI Tooling

## Current State
The project currently uses a flat structure where sources, output, and templates coexist in the root. The knowledge base (`conocimiento.md`) depends on static files in `Fuentes/`. Specifically, `perfil_github.md` is a manual compilation that becomes obsolete as repositories are updated or created.

## Recommended Structure
To support scalability and automation, the following structure is proposed:

```text
CV-agent/
├── .agent/              # Core Skills & Workflows
│   ├── skills/          # Agent personality and task definitions
│   └── workflows/       # Multi-step process definitions
├── scripts/             # Internal automation tools
│   └── github-sync/     # GitHub data extraction & MD generation
├── Fuentes/             # SSOT Source components
│   ├── perfil_github.md # (Target of automation)
│   ├── LinkedIn.md
│   └── ...
├── templates/           # CV designs (Formerly cv-format)
├── CVs/                 # Final output artifacts
├── AGENTS.md            # Project metadata
└── conocimiento.md      # Consolidated SSOT
```

## GitHub Integration Analysis
The `gh` CLI is the optimal tool for data extraction.

### Extraction Commands:
- **Profile**: `gh api user` (Full name, bio, public_repos, company).
- **Repos**: `gh repo list --json name,description,languages,createdAt,pushedAt,url,isArchived`.

### Update Strategy: "The Smart Merge"
To avoid losing manual enrichment (like specific project highlights or "Especialidades"), the script should:
1. **Define Update Zones**: Use HTML comments as markers:
   ```markdown
   <!-- START_STATS -->
   ... auto-generated ...
   <!-- END_STATS -->
   ```
2. **Key-based Preservation**: Use a `metadata.json` or frontmatter to map repo names to manual descriptions, falling back to GitHub's description if none exists.

## Findings
- `gh` CLI is available and authenticated in the environment.
- Current `perfil_github.md` has a very high quality of manual summaries that **must not** be lost.
- Moving `cv-format/` to `templates/` aligns with standard project naming conventions.

## Next Steps
1. Create `scripts/github-sync/`.
2. Implement a Python-based sync script.
3. Update `AGENTS.md` to include the restructuring in the "Pre-flight Check".
