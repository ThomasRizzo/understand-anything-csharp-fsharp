// proposed/csharp/language-config.ts
// Starter LanguageConfig for C# (following Dart addition pattern in Understand-Anything)

// This is a conceptual stub. The actual registration happens inside the core package.

export interface LanguageConfig {
  name: string;
  extensions: string[];
  treeSitterLanguage: any; // web-tree-sitter Language
  queries: {
    definitions: string;
    references: string;
    // add more categories as needed
  };
  frameworkDetectors?: any[];
}

// Example registration (pseudo-code - adapt to actual internal API)
// registerLanguageConfig({
//   name: 'csharp',
//   extensions: ['.cs'],
//   treeSitterLanguage: await loadTreeSitterLanguage('tree-sitter-c-sharp'),
//   queries: {
//     definitions: csharpDefinitionsQuery,
//     references: csharpReferencesQuery,
//   },
//   frameworkDetectors: [detectAspNet, detectBlazor, detectEntityFramework],
// });

export const csharpConfig: Partial<LanguageConfig> = {
  name: 'csharp',
  extensions: ['.cs'],
  // queries will be loaded from queries.scm
};

console.log('C# LanguageConfig stub loaded');