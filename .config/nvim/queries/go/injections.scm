; language based highlighting for strings

(short_var_declaration
  (comment) @__comment (#match? @__comment "html")
  right: (expression_list
    [
      (interpreted_string_literal
        (interpreted_string_literal_content) @injection.content (#set! injection.language "html")
      )
      (raw_string_literal
        (raw_string_literal_content) @injection.content (#set! injection.language "html")
      )
    ]
  )
)

(call_expression
  function: (selector_expression
    field: (field_identifier) @__method (#any-of?
          @__method
          "Printf"
          "Appendf"
          "Fatalf" "Panicf"
          "Infof" "Warnf" "Errorf" "Debugf"
          "Fscanf" "Fprintf"
          "Scanf" "Sscanf" "Sprintf")
  )
  arguments: (argument_list .
      (interpreted_string_literal
        (interpreted_string_literal_content) @injection.content (#set! injection.language "printf"))
  ))
