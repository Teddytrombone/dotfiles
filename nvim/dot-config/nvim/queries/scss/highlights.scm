; inherits: css

[
  "@at-root"
  "@debug"
  "@error"
  "@extend"
  "@forward"
  "@mixin"
  "@use"
  "@warn"
  (important)
  (default)
] @keyword

"@function" @keyword.function

"@return" @keyword.return

"@include" @include

[
  "@while"
  "@each"
  "@for"
  "from"
  "through"
  "in"
] @repeat

[
 "@if"
 "@else"
 "if"
] @conditional

(single_line_comment) @comment @spell
(function_name) @function


[
  ">="
  "<="
] @operator


(mixin_statement (name) @function)
(mixin_statement (parameters (parameter) @parameter))

(function_statement (name) @function)
(function_statement (parameters (parameter) @parameter))

(selectors) @property

(plain_value) @string
(keyword_query) @function
(identifier) @variable
(variable_name) @variable
(variable_value) @variable

(each_statement (key) @parameter)
(each_statement (value) @parameter)
(each_statement (variable_value) @parameter)

(for_statement (variable) @parameter)
(for_statement (_ (variable_value) @parameter))

(condition (variable_value) @parameter)
(condition (_ (variable_value) @parameter))

(argument) @parameter
(arguments (variable_value) @parameter)

[
  "["
  "]"
] @punctuation.bracket

(include_statement (identifier) @function)

(string_value) @string
(color_value) @string.special

(integer_value) @number
(integer_value (unit) @number)
(float_value) @number
(float_value (unit) @number)

