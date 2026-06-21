# understand-anything-csharp-fsharp

**Goal**: Add high-quality C# and F# language support to [Egonex-AI/Understand-Anything](https://github.com/Egonex-AI/Understand-Anything) using its Tree-sitter + config-driven `LanguageConfig` plugin registry.

This repository contains:
- Proposed implementation outline
- Starter `LanguageConfig` + Tree-sitter query stubs for C# and F#
- Cross-platform setup scripts using [`just`](https://github.com/casey/just)
- Development workflow for testing changes against the original plugin

## Why C# and F#?

- C# has excellent `tree-sitter-c-sharp` support and is widely used in enterprise/.NET ecosystems.
- F# brings functional programming strengths (records, discriminated unions, computation expressions) and is relevant for data, finance, and safe systems code.
- Both would greatly benefit users working in the Microsoft/.NET stack (similar to how Python + Django and TypeScript are already well-supported).

## Current State of Understand-Anything Language Support

- Uses **web-tree-sitter (WASM)** for deterministic parsing.
- **Config-driven plugin registry** for 12+ languages + framework detection.
- Custom structural parsers for 12+ infra/config file types (Dockerfile, SQL, Terraform, YAML, etc.) → 26+ file types total.
- Hybrid: Tree-sitter structure + LLM semantic enrichment (layers, summaries, domain mapping, tours).

See the [original repo](https://github.com/Egonex-AI/Understand-Anything) for full details.

## Proposed Approach to Add C#/F# Support

1. **Add Tree-sitter grammars** (WASM)
   - C#: `tree-sitter-c-sharp` (mature)
   - F#: Community `tree-sitter-fsharp` (verify completeness)

2. **Register `LanguageConfig`** (following the Dart addition pattern)
   - Language name, file extensions (`.cs`, `.fs`/`.fsi`/`.fsx`)
   - Tree-sitter parser reference
   - Queries for:
     - Definitions (classes, interfaces, structs, methods, properties, modules, types...)
     - References (calls, imports, inheritance, attributes)
     - .NET-specific constructs

3. **Update file scanner & plugin registry**
   - Recognize new extensions
   - Optional: framework detection (ASP.NET, Blazor, Entity Framework, Giraffe, etc.)

4. **Enhance extraction** (if needed beyond generic analyzer)
   - Handle partial classes, async patterns, LINQ (C#)
   - Handle discriminated unions, records, computation expressions (F#)

5. **Test thoroughly**
   - Small sample projects + real-world .NET codebases
   - Verify graph quality, incremental updates, diff analysis

## Repository Structure

```
.
├── README.md
├── justfile
├── setup.sh          # Linux / macOS
├── setup.ps1         # Windows
├── .gitignore
├── proposed/
│   ├── csharp/
│   │   ├── language-config.ts   # Stub
│   │   ├── queries.scm      # Tree-sitter queries
│   │   └── notes.md
│   └── fsharp/
│       ├── language-config.ts
│       ├── queries.scm
│       └── notes.md
└── scripts/
    └── ...
```

## Quick Start (Recommended)

```bash
# 1. Clone this repo
git clone https://github.com/ThomasRizzo/understand-anything-csharp-fsharp.git
cd understand-anything-csharp-fsharp

# 2. Run the setup script for your OS
# Linux/macOS:
./setup.sh

# Windows (PowerShell):
.\setup.ps1

# 3. Follow the instructions printed by the script
```

The setup script will:
- Install `just` (if missing)
- Clone the original Understand-Anything repo
- Install dependencies (pnpm, etc.)
- Prepare a local development environment for plugin changes

Then use `just` commands for common tasks (see `just --list`).

## Contributing / Next Steps

1. Improve the Tree-sitter queries in `proposed/csharp/` and `proposed/fsharp/`
2. Create a patch or branch against the original repo
3. Test on real C# and F# codebases
4. Open a PR or issue on Egonex-AI/Understand-Anything with the proposed changes

This repo is intended as a **collaboration and development workspace** for the feature.

## License

Same as original project (to be confirmed) — contributions intended to be upstreamed.

---

*Created by Thomas Rizzo — June 2026*