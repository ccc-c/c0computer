# c0c EBNF (current)

This EBNF describes the current supported C subset implemented by the compiler.

```
program      = { top_level } ;
top_level    = function
             | struct_def
             | typedef_stmt ;

function     = type_or_void identifier "(" [ param_list ] ")" ( block | ";" ) ;
param_list   = param { "," param } ;
param        = type identifier ;

type_or_void = type | "void" ;
type         = base_type [ "*" ] ;
base_type    = [ "const" ] type_spec ;
type_spec    = builtin
             | struct_type
             | typedef_name ;
builtin      = [ "unsigned" ] [ "short" | "long" ] ( "int" | "char" )
             | "int" | "char" | "float" | "double" ;
struct_type  = "struct" identifier ;

block        = "{" { statement } "}" ;

statement    = struct_def
             | typedef_stmt
             | decl_stmt
             | if_stmt
             | switch_stmt
             | do_while_stmt
             | while_stmt
             | for_stmt
             | break_stmt
             | continue_stmt
             | return_stmt
             | assign_stmt
             | expr_stmt ;

struct_def   = "struct" identifier "{" { field_decl } "}" ";" ;
field_decl   = type identifier ";" ;

typedef_stmt = "typedef" ( type | struct_typedef ) identifier ";" ;
struct_typedef = "struct" [ identifier ] ( "{" { field_decl } "}" | identifier ) ;

decl_stmt    = type identifier [ array_suffix ] [ "=" init ] ";" ;
array_suffix = "[" [ number ] "]" ;
init         = expr
             | string
             | "{" [ init_list ] "}" ;
init_list    = expr { "," expr } [ "," ] ;

if_stmt      = "if" "(" expr ")" ( block | statement )
               [ "else" ( block | statement ) ] ;

switch_stmt  = "switch" "(" expr ")" "{"
               { case_clause | default_clause } "}" ;
case_clause  = "case" ( number | char_lit ) ":" { statement } ;
default_clause = "default" ":" { statement } ;

do_while_stmt = "do" ( block | statement ) "while" "(" expr ")" ";" ;

while_stmt   = "while" "(" expr ")" ( block | statement ) ;

for_stmt     = "for" "(" [ for_init ] ";" [ expr ] ";" [ for_update ] ")"
               ( block | statement ) ;
for_init     = decl_stmt_no_semi | assign_expr | expr ;
for_update   = assign_expr | expr ;

break_stmt   = "break" ";" ;
continue_stmt= "continue" ";" ;
return_stmt  = "return" [ expr ] ";" ;

assign_stmt  = assign_expr ";" ;
assign_expr  = lvalue ( "=" | "+=" ) expr ;
lvalue       = identifier
             | "*" unary
             | postfix
             | identifier "[" expr "]" ;

expr_stmt    = expr ";" ;

expr         = logical_or ;
logical_or   = logical_and { "||" logical_and } ;
logical_and  = equality { "&&" equality } ;
equality     = relational { ( "==" | "!=" ) relational } ;
relational   = additive { ( "<" | ">" | "<=" | ">=" ) additive } ;
additive     = multiplicative { ( "+" | "-" ) multiplicative } ;
multiplicative = unary { ( "*" | "/" | "%" ) unary } ;

unary        = ( "!" | "-" | "++" | "--" | "&" | "*" ) unary
             | cast
             | sizeof_expr
             | postfix ;

cast         = "(" type ")" unary ;
sizeof_expr  = "sizeof" ( unary | "(" type ")" ) ;

postfix      = primary { postfix_op } ;
postfix_op   = "[" expr "]"
             | "." identifier
             | "->" identifier
             | "++"
             | "--" ;

primary      = number
             | float_lit
             | char_lit
             | string
             | identifier
             | call
             | "(" expr ")" ;

call         = identifier "(" [ arg_list ] ")" ;
arg_list     = expr { "," expr } ;

identifier   = letter { letter | digit | "_" } ;
number       = digit { digit } ;
float_lit    = digit { digit } "." digit { digit } [ ( "e" | "E" ) [ "+" | "-" ] digit { digit } ] [ "f" | "F" ] ;
char_lit     = "'" character "'" ;
string       = "\"" { character } "\"" ;
```

Notes:
- `#include` lines are accepted but ignored by the lexer.
- `printf` is a special-cased variadic call; other functions use fixed signatures.
- `char` values are `i8`, `short` is `i16`, `int` is `i32`, `long` is `i64`; implicit casts are inserted.
- Arrays are represented as pointers in expressions; array initializers support `{}` lists or string literals for `char[]`.
- `struct` definitions are required before use; `struct` values are not directly assignable or passable.

Semantic restrictions (current implementation):
- `struct` values cannot be assigned, returned, or passed as parameters.
- `struct` variables cannot be directly initialized (`struct S s = ...` is unsupported).
- `struct` arrays cannot be initialized.
- `struct` casts are not supported.
- `void*` is not supported.
- Pointer comparisons:
  - `==`/`!=` only allow pointer-vs-pointer of compatible pointer types, or pointer-vs-`0`.
  - `< <= > >=` only allow pointer-vs-pointer of compatible pointer types.
  - Pointer arithmetic allows `ptr +/- int` and `ptr - ptr` (same element type); `int - ptr` is unsupported.
- `++`/`--` only apply to variables (not to `*p`, `a[i]`, or `s.x`), and do not support pointers or `struct`.
- `%` only applies to integer types.
- For `printf`, float arguments are promoted to double; small integers are promoted to int.
