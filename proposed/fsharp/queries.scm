; proposed/fsharp/queries.scm
; Tree-sitter queries for F# (community grammar dependent)

; Module / Namespace
(module_declaration
  name: (_) @definition.module)

; Type / Record / Discriminated Union definitions
(type_definition
  name: (identifier) @definition.type)

; Function / Member definitions
(function_declaration
  name: (identifier) @definition.function)

(member_declaration
  name: (identifier) @definition.member)

; Let bindings (common in F#)
(let_binding
  pattern: (identifier) @definition.variable)

; Open / Use directives
(open_directive
  (long_identifier) @reference.import)

; Function application / calls
(application_expression
  (long_identifier) @reference.call)

; TODO: Add patterns for:
; - Discriminated union cases
; - Record fields
; - Computation expressions (let!, do!)
; - Attributes
; - Type providers
; - Active patterns