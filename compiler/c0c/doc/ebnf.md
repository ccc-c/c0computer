# c0c EBNF (current)

This EBNF describes the current supported C subset implemented by the compiler.

```
program      = { function } ;

function     = type identifier "(" [ param_list ] ")" block ;
param_list   = param { "," param } ;
param        = type identifier ;

type         = base_type [ "*" ] ;
base_type    = "int" | "char" ;

block        = "{" { statement } "}" ;

statement    = decl_stmt
             | if_stmt
             | while_stmt
             | for_stmt
             | break_stmt
             | continue_stmt
             | return_stmt
             | assign_stmt
             | expr_stmt ;

decl_stmt    = type identifier [ array_suffix ] [ "=" expr ] ";" ;
array_suffix = "[" number "]" ;

if_stmt      = "if" "(" expr ")" ( block | statement )
               [ "else" ( block | statement ) ] ;

while_stmt   = "while" "(" expr ")" ( block | statement ) ;

for_stmt     = "for" "(" [ for_init ] ";" [ expr ] ";" [ for_update ] ")"
               ( block | statement ) ;
for_init     = decl_stmt_no_semi | assign_expr | expr ;
for_update   = assign_expr | expr ;

break_stmt   = "break" ";" ;
continue_stmt= "continue" ";" ;
return_stmt  = "return" expr ";" ;

assign_stmt  = assign_expr ";" ;
assign_expr  = lvalue ( "=" | "+=" ) expr ;
lvalue       = identifier
             | "*" unary
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
             | postfix ;

postfix      = primary [ "++" | "--" ] ;

primary      = number
             | string
             | identifier
             | call
             | identifier "[" expr "]"
             | "(" expr ")" ;

call         = identifier "(" [ arg_list ] ")" ;
arg_list     = expr { "," expr } ;

identifier   = letter { letter | digit | "_" } ;
number       = digit { digit } ;
string       = "\"" { character } "\"" ;
```

Notes:
- `#include` lines are accepted but ignored by the lexer.
- `printf` is a special-cased variadic call; other functions use fixed signatures.
- `char` values are `i8` and `int` values are `i32`; implicit casts are inserted.
