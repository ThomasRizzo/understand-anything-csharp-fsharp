; proposed/fsharp/queries.scm
; Tree-sitter queries for F# (based on ionide/tree-sitter-fsharp grammar)
; Note: F# grammar is still evolving (WIP). These queries target common stable nodes.
; Focus on practical extractions for knowledge graph: modules, types, functions, bindings.

; ============================================
; DEFINITIONS
; ============================================

; Modules and Namespaces
(module_declaration
  name: (_) @definition.module)

; Type definitions (records, discriminated unions, classes, interfaces, structs)
(type_definition
  name: (identifier) @definition.type)

; Function and value definitions
(function_or_value_defn
  (identifier) @definition.function)

; Let bindings (very common in F#)
(let_binding
  pattern: (identifier) @definition.binding)

; Member definitions (in types)
(member_declaration
  name: (identifier) @definition.member)

; ============================================
; REFERENCES & RELATIONSHIPS
; ============================================

; Open / Use directives
(open_directive
  (long_identifier) @reference.import)

; Function application / calls
(application_expression
  (long_identifier) @reference.call)

; ============================================
; F#-SPECIFIC CONSTRUCTS (start simple)
; ============================================

; Discriminated union cases (very important in F#)
(union_case
  name: (identifier) @definition.union_case)

; Record fields
(record_field
  name: (identifier) @definition.record_field)

; Computation expressions / workflows (let!, do!, return! etc.)
; These are powerful in F# - capture the keyword for now
(computation_expression) @computation.expression

; Attributes (less common than C# but still used)
(attribute
  name: (identifier) @reference.attribute)

; ============================================
; NOTES FOR IMPLEMENTATION
; ============================================
; - F# grammar node names can differ slightly between .fs and .fsi files.
; - Start with basic module + type + function extraction.
; - The LLM layer will help interpret functional patterns.
; - Future improvements:
;     * Better handling of active patterns
;     * Type provider recognition
;     * Computation expression workflow extraction
;     * .fsproj parsing for project references