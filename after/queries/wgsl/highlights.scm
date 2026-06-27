;; extends

; The upstream WGSL query captures every identifier as @variable. Re-capture
; identifiers that appear in type positions with higher priority so struct
; names do not inherit variable highlighting.
(type_declaration
  (identifier) @type
  (#set! "priority" 120))

(type_constructor_or_function_call_expression
  (type_declaration
    (identifier) @function.call
    (#set! "priority" 130)))

(struct_declaration
  name: (identifier) @type
  (#set! "priority" 120))

(struct_member
  (variable_identifier_declaration
    name: (identifier) @variable.member
    (#set! "priority" 120)))
