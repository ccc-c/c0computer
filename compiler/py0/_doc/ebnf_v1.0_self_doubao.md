/* 核心约定：
   ::=  定义为 | {X} 0/多次重复 | [X] 可选 | (X) 分组 | - 排除 | <X> 终结符/非终结符
   EOF  文件结束 | EOL 行结束（NEWLINE/NL/EOF） | INDENT/DEDENT 缩进/取消缩进（4空格级）
*/
<Program>        ::= { <Statement> | <Comment> } <EOF> ;
<Comment>        ::= "#" { <Char> } <EOL> ;
<EOL>            ::= <NEWLINE> | <NL> | <EOF> ;
<NEWLINE>        ::= Token(TK.NEWLINE, "\n" | "\r\n") ;
<NL>             ::= Token(TK.NL, "\n" | "\r\n") ;
<EOF>            ::= Token(TK.EOF, "") ;
<INDENT>         ::= Token(TK.INDENT, 4+) ;  // 4空格为1级缩进（数值为总空格数）
<DEDENT>         ::= Token(TK.DEDENT, 0+) ;  // 取消缩进（数值为剩余缩进数）

// 语句（所有语句需匹配缩进层级）
<Statement>      ::= <IndentLevel> (
    <Assignment> | <PrintStmt> | <ReturnStmt> | <FuncDef> | <IfStmt> | <WhileStmt> | <Block> | <Pass>
) ;
<IndentLevel>    ::= { <INDENT> } - { <DEDENT> } ;  // 缩进层级（INDENT/DEDENT 栈匹配）
<Block>          ::= { <Statement> } ;
<Pass>           ::= "pass" <EOL> ;

// 基础语句定义
<Assignment>     ::= <Identifier> "=" <Expr> <EOL> ;
<PrintStmt>      ::= "print" "(" [ <Expr> { "," <Expr> } ] ")" <EOL> ;
<ReturnStmt>     ::= "return" [ <Expr> ] <EOL> ;
<FuncDef>        ::= "def" <Identifier> "(" [ <ParamList> ] ")" ":" <EOL> <INDENT> <Block> <DEDENT> ;
<ParamList>      ::= <Identifier> { "," <Identifier> } ;
<IfStmt>         ::= "if" <Expr> ":" <EOL> <INDENT> <Block> <DEDENT> 
                     [ "else" ":" <EOL> <INDENT> <Block> <DEDENT> ] ;
<WhileStmt>      ::= "while" <Expr> ":" <EOL> <INDENT> <Block> <DEDENT> ;

// 表达式（优先级从低到高：逻辑→比较→算术→一元→原子）
<Expr>           ::= <LogicalExpr> ;
<LogicalExpr>    ::= <CompareExpr> { ( "and" | "or" ) <CompareExpr> } ;
<CompareExpr>    ::= <ArithExpr> { ( "==" | "!=" | "<" | ">" | "<=" | ">=" | "is" | "in" ) <ArithExpr> } ;
<ArithExpr>      ::= <Term> { ( "+" | "-" ) <Term> } ;
<Term>           ::= <Factor> { ( "*" | "/" | "//" | "%" | "**" ) <Factor> } ;
<Factor>         ::= ( "+" | "-" | "not" ) <Factor> | <PrimaryExpr> ;
<PrimaryExpr>    ::= <Identifier> | <Literal> | <FuncCall> | "(" <Expr> ")" ;
<FuncCall>       ::= <Identifier> "(" [ <ArgList> ] ")" ;
<ArgList>        ::= <Expr> { "," <Expr> } ;

// 词法终结符（与 ast.py 的 Token 对齐）
<Literal>        ::= <Integer> | <Float> | <String> ;
<Integer>        ::= Token(TK.NUM, [ "-" ] ( <Digit> { <Digit> | "_" } | "0x" <HexDigit> { <HexDigit> } | "0b" <BinDigit> { <BinDigit> } | "0o" <OctDigit> { <OctDigit> } )) ;
<Float>          ::= Token(TK.NUM, [ "-" ] ( <Digit> { <Digit> | "_" } "." { <Digit> | "_" } ( [ "e" | "E" ] [ "+" | "-" ] <Digit> { <Digit> } )? | "." <Digit> { <Digit> | "_" } ( [ "e" | "E" ] [ "+" | "-" ] <Digit> { <Digit> } )? | <Digit> { <Digit> | "_" } [ "e" | "E" ] [ "+" | "-" ] <Digit> { <Digit> } )) ;
<String>         ::= Token(TK.STR, ( "'" { <Char> | <EscChar> } "'" | "\"" { <Char> | <EscChar> } "\"" | "'''" { <Char> | <EOL> | <EscChar> } "'''" | "\"\"\"" { <Char> | <EOL> | <EscChar> } "\"\"\"" )) ;
<Identifier>     ::= Token(TK.NAME, ( <Letter> | "_" ) { <Letter> | <Digit> | "_" }) - <Keyword> ;
<Keyword>        ::= "def" | "if" | "else" | "while" | "return" | "print" | "pass" | "and" | "or" | "not" | "is" | "in" ;
<Letter>         ::= [a-zA-Z] ;
<Digit>          ::= [0-9] ;
<HexDigit>       ::= [0-9a-fA-F] ;
<BinDigit>       ::= [0-1] ;
<OctDigit>       ::= [0-7] ;
<Char>           ::= [^\\\n\r] ;  // 非转义、非换行字符
<EscChar>        ::= "\\" ( "n" | "t" | "r" | "\"" | "'" | "\\" | "b" | "f" ) ;
<OP>             ::= Token(TK.OP, "+" | "-" | "*" | "/" | "//" | "%" | "**" | "==" | "!=" | "<" | ">" | "<=" | ">=" | "=" | "(" | ")" | "," | ":" | "and" | "or" | "not" | "is" | "in" ) ;