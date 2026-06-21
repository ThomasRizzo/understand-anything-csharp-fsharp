# .NET Project File Handling Proposal (.csproj / .fsproj / .sln)

## Goal
Improve Understand-Anything's ability to understand large .NET solutions by parsing project files for:

- Target frameworks
- Package dependencies
- Project-to-project references
- Compile item ordering (especially important for F#)
- SDK style and tooling information

## Why This Matters
Current Understand-Anything already does excellent work on individual source files. Adding project-level understanding would allow:

- Better dependency graphs across multiple projects
- Framework/layer detection at the project level
- Onboarding tours that respect solution structure
- Impact analysis that considers project references

## Recommended Approach

### Option A: Lightweight XML Post-Processor (Fastest to implement)
- Reuse the existing XML parser (or Tree-sitter XML)
- Add a small dedicated extractor in the C#/F# language module that looks for:
  - `<TargetFramework>` / `<TargetFrameworks>`
  - `<PackageReference Include="..." Version="..." />`
  - `<ProjectReference Include="..." />`
  - `<Compile Include="..." />` (preserve order for F#)

### Option B: Dedicated MSBuild Parser (Higher quality)
Similar to how the project has custom parsers for Terraform, Protobuf, SQL, etc.
Create a small parser focused only on the MSBuild schema elements that matter for understanding.

### Option C: Hybrid
Use Tree-sitter/XML for structure + custom rules for known important elements.

## Proposed Data Model Additions

New node types or enriched project nodes:

- `project` node with metadata (name, path, targetFramework, sdk)
- `package_dependency` edges
- `project_reference` edges
- For F#: `compile_order` relationships between files

## Implementation Sketch (TypeScript pseudo)

```ts
// In the C#/F# language module or a shared dotnet-utils
interface DotnetProjectInfo {
  path: string;
  targetFramework: string;
  packageReferences: Array<{ include: string; version?: string }>;
  projectReferences: string[];
  compileItems: string[]; // ordered for F#
}

function parseCsprojOrFsproj(content: string): DotnetProjectInfo { ... }
```

## Next Actions
1. Decide on Option A vs B
2. Implement a minimal extractor
3. Wire it into the project-scanner or file-analyzer phase
4. Update the graph schema if new node/edge types are needed
5. Test on multi-project solutions

This would be a high-leverage addition for anyone working in the .NET ecosystem.