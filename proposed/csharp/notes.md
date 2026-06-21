# C# Support Notes

## Status
- Stub files created
- Awaiting real implementation inside Understand-Anything core

## Key Challenges
- Handling partial classes and partial methods
- Good support for attributes and decorators
- Async/await and Task patterns
- LINQ and expression trees (may be treated as complex calls)
- .NET project file integration (.csproj) for better dependency graphs

## Recommended Next Steps
1. Verify `tree-sitter-c-sharp` WASM loads correctly in the plugin
2. Expand queries.scm with more comprehensive patterns from the grammar
3. Add framework detectors for ASP.NET Core, Blazor, Minimal APIs, etc.
4. Test on real-world repositories (e.g., ASP.NET samples, eShop, etc.)

## Resources
- tree-sitter-c-sharp: https://github.com/tree-sitter/tree-sitter-c-sharp
- Understand-Anything core package location (in original repo)