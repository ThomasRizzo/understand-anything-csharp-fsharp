// proposed/fsharp/language-config.ts
// Starter LanguageConfig for F#

// F# support may require more custom handling due to its functional nature
// (discriminated unions, computation expressions, modules, etc.)

export const fsharpConfig = {
  name: 'fsharp',
  extensions: ['.fs', '.fsi', '.fsx'],
  // Note: tree-sitter-fsharp grammar quality should be verified
};

// Potential extra categories for F#:
// - module declarations
// - discriminated union cases
// - record fields
// - computation expressions (let!, do!, etc.)
// - type providers

console.log('F# LanguageConfig stub loaded');