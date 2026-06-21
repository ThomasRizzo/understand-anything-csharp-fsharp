# F# Support Notes

## Status
- Stub files created
- F# is more challenging due to its functional-first design

## Key Challenges
- Discriminated unions and pattern matching
- Computation expressions (let!, do!, return!)
- Modules and namespaces
- Records and anonymous records
- Type providers and quotations
- Active patterns
- .fsproj / solution file parsing for dependencies

## Recommended Next Steps
1. Evaluate quality of available `tree-sitter-fsharp` grammars
2. Start with basic module + function + type extraction
3. Consider hybrid approach: Tree-sitter for structure + extra LLM guidance for functional concepts
4. Test with F# codebases (e.g., SAFE Stack apps, Giraffe, finance libraries)

## Resources
- Search for community tree-sitter-fsharp grammars
- F# language specification for important constructs
- Original project's handling of other functional-ish languages (if any)