; proposed/csharp/queries.scm
; Tree-sitter queries for extracting C# structures
; Based on tree-sitter-c-sharp grammar

; Class / Struct / Interface / Record definitions
(class_declaration
  name: (identifier) @definition.class)

(struct_declaration
  name: (identifier) @definition.struct)

(interface_declaration
  name: (identifier) @definition.interface)

(record_declaration
  name: (identifier) @definition.record)

; Method definitions
(method_declaration
  name: (identifier) @definition.method)

; Property definitions
(property_declaration
  name: (identifier) @definition.property)

; Namespace / Using directives
(namespace_declaration
  name: (_) @definition.namespace)

(using_directive
  (identifier) @reference.import)

; Method calls / invocations
(invocation_expression
  (member_access_expression
    name: (identifier) @reference.call))

; Inheritance
(base_list
  (identifier) @reference.inheritance)

; TODO: Expand with more patterns for:
; - Attributes
; - Partial classes
; - Async/await patterns
; - LINQ expressions
; - Events, delegates, etc.