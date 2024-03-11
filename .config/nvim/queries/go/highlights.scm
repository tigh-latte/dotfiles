;; extends

((identifier) @variable (#not-any-of? @variable
    "any" "bool" "byte" "complex128" "complex64" "error" "float32" "float64" "int" "int16"
    "int32" "int64" "int8" "rune" "string" "uint" "uint16" "uint32" "uint64" "uint8" "uintptr"
  ))

(call_expression
  function: (identifier) @function.call (#not-any-of? @function.call
    "any" "bool" "byte" "complex128" "complex64" "error" "float32" "float64" "int" "int16"
    "int32" "int64" "int8" "rune" "string" "uint" "uint16" "uint32" "uint64" "uint8" "uintptr"
  ))

(call_expression
  function: (identifier) @type.builtin (#any-of? @type.builtin
    "any" "bool" "byte" "complex128" "complex64" "error" "float32" "float64" "int" "int16"
    "int32" "int64" "int8" "rune" "string" "uint" "uint16" "uint32" "uint64" "uint8" "uintptr"
  ))
