/* ==========================================
   1. 詞法單位 (Lexical Tokens)
   ========================================== */
NAME      ::= /[a-zA-Z_][a-zA-Z0-9_]*/
NUM       ::= /* 整數、浮點數、十六進位、八進位、二進位或複數 */
STR       ::= /* 單引號/雙引號/三引號字串，支援 f, r, b 等前綴 */
NEWLINE   ::= /* 實質換行符號 (不在括號內) */
INDENT    ::= /* 縮排增加 */
DEDENT    ::= /* 縮排減少 */
EOF       ::= /* 檔案結尾 */

/* ==========================================
   2. 頂層與區塊 (Top-level & Blocks)
   ========================================== */
module    ::= { stmt } EOF
block     ::= NEWLINE INDENT { stmt } DEDENT
stmt      ::= { decorator } ( funcdef | classdef )
            | if_stmt | while_stmt | for_stmt | try_stmt | with_stmt
            | simple_stmt_line

/* ==========================================
   3. 複合語句 (Compound Statements)
   ========================================== */
decorator ::= '@' primary_expr NEWLINE
funcdef   ::= [ 'async' ] 'def' NAME '(' [ parameters ] ')' [ '->' expr ] ':' block
classdef  ::= 'class' NAME [ '('[ call_args_raw ] ')' ] ':' block

if_stmt   ::= 'if' expr ':' block 
              { 'elif' expr ':' block } 
              [ 'else' ':' block ]

while_stmt::= 'while' expr ':' block 
              [ 'else' ':' block ]

for_stmt  ::= 'for' target_list 'in' expr ':' block 
              [ 'else' ':' block ]

try_stmt  ::= 'try' ':' block 
              { 'except' [ expr [ 'as' NAME ] ] ':' block } 
              [ 'else' ':' block ] 
              [ 'finally' ':' block ]

with_stmt ::= 'with' with_item { ',' with_item } ':' block
with_item ::= expr [ 'as' target_expr ]

/* ==========================================
   4. 簡單語句 (Simple Statements)
   ========================================== */
simple_stmt_line ::= small_stmt { ';' small_stmt } [ ';' ] ( NEWLINE | EOF )

small_stmt       ::= pass_stmt | break_stmt | continue_stmt | return_stmt 
                   | raise_stmt | del_stmt | global_stmt | nonlocal_stmt 
                   | import_stmt | from_import_stmt | assert_stmt 
                   | assign_stmt | expr_stmt

pass_stmt        ::= 'pass'
break_stmt       ::= 'break'
continue_stmt    ::= 'continue'
return_stmt      ::= 'return'[ tuple_expr ]
raise_stmt       ::= 'raise' [ expr [ 'from' expr ] ]
del_stmt         ::= 'del' del_target { ',' del_target }
global_stmt      ::= 'global' NAME { ',' NAME }
nonlocal_stmt    ::= 'nonlocal' NAME { ',' NAME }
assert_stmt      ::= 'assert' expr [ ',' expr ]

import_stmt      ::= 'import' import_alias { ',' import_alias }
from_import_stmt ::= 'from' { '.' }[ NAME { '.' NAME } ] 'import' 
                     ( '*' 
                     | '(' import_alias { ',' import_alias } [ ',' ] ')' 
                     | import_alias { ',' import_alias } )
import_alias     ::= NAME { '.' NAME } [ 'as' NAME ]

assign_stmt      ::= target_list ( augassign expr 
                                 | ':' expr [ '=' expr ] 
                                 | { '=' target_list } '=' tuple_expr )
expr_stmt        ::= tuple_expr

augassign        ::= '+=' | '-=' | '*=' | '/=' | '//=' | '%=' | '**='
                   | '&=' | '|=' | '^=' | '<<=' | '>>=' | '@='

/* 賦值目標 (Targets) */
target_list      ::= target_expr { ',' target_expr } [ ',' ]
target_expr      ::= NAME | '*' NAME | primary_expr
del_target       ::= target_expr

/* ==========================================
   5. 運算式 (Expressions - 依優先權由低至高)
   ========================================== */
tuple_expr       ::= expr { ',' expr } [ ',' ]

expr             ::= lambda_expr | yield_expr | named_expr
lambda_expr      ::= 'lambda'[ lambda_params ] ':' expr
yield_expr       ::= 'yield' [ 'from' expr | tuple_expr ]
named_expr       ::= ternary_expr [ ':=' expr ]

ternary_expr     ::= or_expr [ 'if' or_expr 'else' expr ]

or_expr          ::= and_expr { 'or' and_expr }
and_expr         ::= not_expr { 'and' not_expr }
not_expr         ::= 'not' not_expr | compare_expr

compare_expr     ::= bitor_expr { comp_op bitor_expr }
comp_op          ::= '<' | '>' | '<=' | '>=' | '==' | '!=' 
                   | 'in' | 'is' | 'not' 'in' | 'is' 'not'

bitor_expr       ::= bitxor_expr { '|' bitxor_expr }
bitxor_expr      ::= bitand_expr { '^' bitand_expr }
bitand_expr      ::= shift_expr { '&' shift_expr }
shift_expr       ::= add_expr { ( '<<' | '>>' ) add_expr }
add_expr         ::= mul_expr { ( '+' | '-' ) mul_expr }
mul_expr         ::= unary_expr { ( '*' | '/' | '//' | '%' | '@' ) unary_expr }

unary_expr       ::= ( '+' | '-' | '~' ) unary_expr | power_expr
power_expr       ::= await_expr [ '**' unary_expr ]
await_expr       ::=[ 'await' ] primary_expr

primary_expr     ::= atom { call_suffix | subscript_suffix | attr_suffix }
call_suffix      ::= '(' [ call_args_raw ] ')'
subscript_suffix ::= '[' slice_list ']'
attr_suffix      ::= '.' NAME

/* ==========================================
   6. 基本元素 (Atoms)
   ========================================== */
atom             ::= NUM 
                   | { STR }+ 
                   | 'True' | 'False' | 'None' | '...'
                   | NAME
                   | '*' expr
                   | '(' [ tuple_or_gen ] ')'
                   | '['[ list_or_comp ] ']'
                   | '{' [ dict_or_set_or_comp ] '}'

tuple_or_gen     ::= expr 'for' comp_generators
                   | expr { ',' expr }[ ',' ]

list_or_comp     ::= expr 'for' comp_generators
                   | expr { ',' expr } [ ',' ]

dict_or_set_or_comp ::= '**' expr { ',' dict_item }
                      | expr ':' expr 'for' comp_generators
                      | expr 'for' comp_generators
                      | dict_item { ',' dict_item } [ ',' ]
                      | expr { ',' expr } [ ',' ]

dict_item        ::= '**' expr | expr ':' expr

/* ==========================================
   7. 參數、切片與推導式 (Args, Slices & Comprehensions)
   ========================================== */
parameters       ::= param_item { ',' param_item } [ ',' ]
param_item       ::= '**' NAME [ ':' expr ]
                   | '*' [ NAME [ ':' expr ] ]
                   | '/'
                   | NAME [ ':' expr ] [ '=' expr ]

lambda_params    ::= l_param_item { ',' l_param_item } [ ',' ]
l_param_item     ::= '**' NAME | '*' [ NAME ] | NAME [ '=' expr ]

call_args_raw    ::= arg_item { ',' arg_item } [ ',' ]
arg_item         ::= '**' expr
                   | '*' expr
                   | NAME '=' expr
                   | expr 'for' comp_generators
                   | expr

slice_list       ::= slice_item { ',' slice_item } [ ',' ]
slice_item       ::= [ expr ] ':' [ expr ] [ ':'[ expr ] ]
                   | expr

comp_generators  ::= comp_for { comp_for }
comp_for         ::= [ 'async' ] 'for' target_list 'in' or_expr { 'if' or_expr }