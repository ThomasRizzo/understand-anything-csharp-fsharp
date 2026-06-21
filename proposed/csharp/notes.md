# C# Support Notes

## Current Status (June 2026)
- Improved `queries.scm` with rich definitions and references
- Ready for integration testing inside Understand-Anything core

## Framework Detection Ideas

C# / .NET has strong convention-based and attribute-based frameworks. We can detect:

- **Web API / Minimal APIs**: Presence of `[ApiController]`, `MapGet`/`MapPost`, or `WebApplication` patterns
- **Blazor**: `.razor` files + `@page`, `ComponentBase`
- **ASP.NET Core MVC**: Controllers inheriting from `Controller` or `ControllerBase`
- **Entity Framework**: `DbContext`, `DbSet<>`, `[Key]`, migrations
- **Dependency Injection**: Heavy use of `IServiceCollection`, `AddScoped`, etc.
- **gRPC / SignalR**: Specific package + attribute patterns

**Implementation approach**:
- Add a `frameworkDetectors` array in `LanguageConfig`
- Or post-process the extracted graph looking for specific types/attributes (cheaper than full static analysis)

## Project File Parsing (.csproj / .fsproj)

.csproj files are MSBuild XML. Options:

1. **Reuse existing XML parser** + custom post-processor for `<ItemGroup>`, `<PackageReference>`, `<ProjectReference>`
2. **Add dedicated MSBuild parser** (similar to how Terraform or Protobuf have custom parsers)
3. **Simple regex / XML DOM** for key elements during scanning phase

Recommended starting point: Extend the existing XML handling to extract:
- Target framework (`<TargetFramework>`)
- Package references (for dependency graph)
- Project references (for solution-level understanding)

This would significantly improve cross-project understanding in large .NET solutions.

## Testing Recommendations
- Small console app + class library
- ASP.NET Core Web API sample
- Blazor Server / WASM app
- Real internal codebase if available

## Open Questions
- How to best merge partial classes across files?
- Should we model dependency injection graphs explicitly?
- Performance impact of deeper attribute scanning