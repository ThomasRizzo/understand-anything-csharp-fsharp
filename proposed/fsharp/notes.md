# F# Support Notes

## Current Status (June 2026)
- Improved queries with modules, types, functions, discriminated unions, records, and computation expressions
- Grammar (ionide/tree-sitter-fsharp) is functional but still maturing

## Framework / Ecosystem Detection

F# is often used with specific stacks:

- **SAFE Stack** (Saturn + Azure + Fable + Elmish)
- **Giraffe** / **Falco** (web frameworks)
- **Bolero** (Blazor + F#)
- **Fable** (F# → JavaScript)
- **FsCheck** / property-based testing
- Finance / quant libraries (many internal F# codebases)

Detection can be done via:
- Specific `open` statements or module usage
- Package references in .fsproj
- File naming conventions (e.g., `*.fable.fs`)

## .fsproj Parsing

Similar to .csproj but F# projects often have more complex ordering and `Compile` includes.

High-value extractions:
- `<PackageReference>` for dependency graph
- `<ProjectReference>`
- `<Compile Include="..." />` order (important because F# is sensitive to declaration order)
- Target framework and F# tooling version

Recommendation: Start with a lightweight XML-based extractor focused on references and compile order, then feed into the graph as "project" level nodes.

## Challenges Specific to F#
- Declaration order matters (unlike C#)
- Heavy use of discriminated unions and pattern matching
- Computation expressions can represent complex workflows (async, result, etc.)
- Type providers generate code at compile time

## Recommended Implementation Path
1. Get basic module + type + function extraction working well
2. Add union_case and record_field support
3. Experiment with simple .fsproj parsing
4. Use LLM heavily for semantic interpretation of functional patterns
5. Test on real F# codebases (Giraffe apps, SAFE examples, internal quant code)

## Resources
- ionide/tree-sitter-fsharp grammar repo
- F# language specification (for node naming)
- Understand-Anything's existing handling of other functional languages