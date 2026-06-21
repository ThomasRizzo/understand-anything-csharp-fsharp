; proposed/csharp/queries.scm
; Enhanced Tree-sitter queries for C# (tree-sitter-c-sharp grammar)
; These are designed to feed the Understand-Anything file-analyzer and graph builder.
; Captures follow common conventions: @definition.*, @reference.*

; ============================================
; DEFINITIONS
; ============================================

; Types
(class_declaration
  name: (identifier) @definition.class)

(struct_declaration
  name: (identifier) @definition.struct)

(interface_declaration
  name: (identifier) @definition.interface)

(record_declaration
  name: (identifier) @definition.record)

(enum_declaration
  name: (identifier) @definition.enum)

; Methods / Constructors / Destructors
(method_declaration
  name: (identifier) @definition.method)

(constructor_declaration
  name: (identifier) @definition.constructor)

(destructor_declaration) @definition.destructor

; Properties, Fields, Events
(property_declaration
  name: (identifier) @definition.property)

(field_declaration
  (variable_declarator
    name: (identifier) @definition.field))

(event_declaration
  name: (identifier) @definition.event)

; Delegates
(delegate_declaration
  name: (identifier) @definition.delegate)

; Namespaces
(namespace_declaration
  name: (_) @definition.namespace)

; Using / Import directives
(using_directive
  (identifier) @reference.import
  .)
(using_directive
  (qualified_name) @reference.import)

; ============================================
; REFERENCES & RELATIONSHIPS
; ============================================

; Method / Function calls
(invocation_expression
  function: (member_access_expression
    name: (identifier) @reference.call))

(invocation_expression
  function: (identifier) @reference.call)

; Object creation
(object_creation_expression
  type: (identifier) @reference.instantiation)

; Inheritance / Implementation
(base_list
  (identifier) @reference.inheritance)
(base_list
  (qualified_name) @reference.inheritance)

; Attribute usage (very common in C# / .NET)
(attribute
  name: (identifier) @reference.attribute)
(attribute
  name: (qualified_name) @reference.attribute)

; Variable / Member access (for data flow hints)
(member_access_expression
  name: (identifier) @reference.member)

; ============================================
; ADDITIONAL USEFUL PATTERNS
; ============================================

; Async / Await (important for modern C#)
(await_expression) @keyword.async

; LINQ (common in data-heavy code)
(from_clause) @linq.from
(query_expression) @linq.query

; Partial classes / methods (important for code generation scenarios)
(partial) @modifier.partial

; Comments (if we want to capture XML docs or TODOs later)
(comment) @comment

; ============================================
; NOTES FOR IMPLEMENTATION
; ============================================
; - Map @definition.* captures → graph nodes of type "definition"
; - Map @reference.* captures → edges (calls, inherits, imports, uses_attribute, etc.)
; - The LLM layer in Understand-Anything will enrich these with summaries and layering.
; - Consider adding language-specific post-processing for:
;     * Partial class merging
;     * Attribute-driven framework detection (e.g. [ApiController] → Web API)
;     * Dependency injection patterns