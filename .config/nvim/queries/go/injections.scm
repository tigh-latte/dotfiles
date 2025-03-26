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
