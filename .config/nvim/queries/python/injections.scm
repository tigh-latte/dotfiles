; SQL highlighting for django migrations.RunSQL
(call
  function: (attribute
    object: (_) @_import (#eq? @_import "migrations")
    attribute: (_) @_func (#eq? @_func "RunSQL"))
  arguments: (argument_list
    (string
      (string_content) @injection.content (#set! injection.language "sql"))
  ))

(call
  function: (attribute
    object: (_) @_import (#eq? @_import "migrations")
    attribute: (_) @_func (#eq? @_func "RunSQL"))
  arguments: (argument_list
    (keyword_argument
      value: (list
        (parenthesized_expression
          (string
            (string_content) @injection.content (#set! injection.language "sql")
  ))))))
