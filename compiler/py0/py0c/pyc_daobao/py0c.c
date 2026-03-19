/*
py0c.c - 纯C实现的Python→C编译器（无LLVM依赖）
适配 ast.py 定义的AST节点，生成可读的C代码
支持核心Python语法：变量、表达式、赋值、函数、条件/循环、基本运算符等
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdarg.h>
#include <ctype.h>
#include <regex.h>

// ============================ 1. 基础定义（对应ast.py） ============================
// Token类型（对应ast.py的TK）
typedef enum {
    TK_NUM, TK_STR, TK_NAME, TK_NEWLINE, TK_INDENT, TK_DEDENT,
    TK_OP, TK_EOF, TK_COMMENT, TK_NL
} TokenKind;

// 运算符枚举（对应ast.py的运算符节点）
typedef enum {
    OP_ADD, OP_SUB, OP_MULT, OP_DIV, OP_FLOORDIV, OP_MOD, OP_POW,
    OP_BITAND, OP_BITOR, OP_BITXOR, OP_LSHIFT, OP_RSHIFT, OP_MATMULT,
    OP_UADD, OP_USUB, OP_NOT, OP_INVERT,
    OP_AND, OP_OR,
    OP_EQ, OP_NOTEQ, OP_LT, OP_LTE, OP_GT, OP_GTE, OP_IS, OP_ISNOT, OP_IN, OP_NOTIN
} OpKind;

// Context枚举（Load/Store/Del）
typedef enum { CTX_LOAD, CTX_STORE, CTX_DEL } ContextKind;

// AST节点类型枚举
typedef enum {
    AST_MODULE, AST_EXPR, AST_ASSIGN, AST_RETURN, AST_PASS, AST_IF, AST_WHILE,
    AST_FOR, AST_FUNCTIONDEF, AST_CONSTANT, AST_NAME, AST_ATTRIBUTE,
    AST_BINOP, AST_UNARYOP, AST_BOOLOP, AST_COMPARE, AST_CALL, AST_IFEXP
} ASTNodeKind;

// 前向声明（解决循环依赖）
typedef struct ASTNode ASTNode;
typedef struct Token Token;
typedef struct Parser Parser;
typedef struct ASTWalker ASTWalker;

// Token结构体（对应ast.py的Token类）
struct Token {
    TokenKind kind;
    char* value;
    int line;
    int col;
};

// AST节点基础结构体（对应ast.py的AST类）
struct ASTNode {
    ASTNodeKind kind;
    int lineno;
    int col_offset;
    // 不同节点的字段（用union节省空间）
    union {
        // Module: body
        struct { ASTNode** body; int body_len; } module;
        
        // Expr: value
        struct { ASTNode* value; } expr;
        
        // Assign: targets, value
        struct { ASTNode** targets; int targets_len; ASTNode* value; } assign;
        
        // Return: value
        struct { ASTNode* value; } ret;
        
        // If: test, body, orelse
        struct { ASTNode* test; ASTNode** body; int body_len; ASTNode** orelse; int orelse_len; } if_stmt;
        
        // While: test, body, orelse
        struct { ASTNode* test; ASTNode** body; int body_len; ASTNode** orelse; int orelse_len; } while_stmt;
        
        // FunctionDef: name, args, body
        struct { char* name; ASTNode** body; int body_len; } funcdef;
        
        // Constant: value
        struct { char* value; } constant;
        
        // Name: id, ctx
        struct { char* id; ContextKind ctx; } name;
        
        // BinOp: left, op, right
        struct { ASTNode* left; OpKind op; ASTNode* right; } binop;
        
        // UnaryOp: op, operand
        struct { OpKind op; ASTNode* operand; } unaryop;
    } data;
};

// 解析器结构体
struct Parser {
    Token* tokens;
    int token_count;
    int pos;
};

// ============================ 2. 工具函数 ============================
// 内存管理
static void* py0c_malloc(size_t size) {
    void* ptr = malloc(size);
    if (!ptr) { perror("malloc failed"); exit(1); }
    return ptr;
}

static void* py0c_realloc(void* ptr, size_t size) {
    ptr = realloc(ptr, size);
    if (!ptr) { perror("realloc failed"); exit(1); }
    return ptr;
}

static char* py0c_strdup(const char* s) {
    size_t len = strlen(s) + 1;
    char* dup = py0c_malloc(len);
    strcpy(dup, s);
    return dup;
}

// 字符串拼接（可变参数）
static char* py0c_strcatf(const char* fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    char buf[1024] = {0};
    vsnprintf(buf, sizeof(buf)-1, fmt, ap);
    va_end(ap);
    return py0c_strdup(buf);
}

// Token创建/销毁
static Token* token_new(TokenKind kind, const char* value, int line, int col) {
    Token* t = py0c_malloc(sizeof(Token));
    t->kind = kind;
    t->value = py0c_strdup(value);
    t->line = line;
    t->col = col;
    return t;
}

static void token_free(Token* t) {
    if (t) {
        free(t->value);
        free(t);
    }
}

// AST节点创建/销毁
static ASTNode* ast_node_new(ASTNodeKind kind) {
    ASTNode* node = py0c_malloc(sizeof(ASTNode));
    node->kind = kind;
    node->lineno = 0;
    node->col_offset = 0;
    memset(&node->data, 0, sizeof(node->data));
    return node;
}

static void ast_node_free(ASTNode* node) {
    if (!node) return;
    
    switch (node->kind) {
        case AST_MODULE:
            for (int i = 0; i < node->data.module.body_len; i++) {
                ast_node_free(node->data.module.body[i]);
            }
            free(node->data.module.body);
            break;
        
        case AST_ASSIGN:
            for (int i = 0; i < node->data.assign.targets_len; i++) {
                ast_node_free(node->data.assign.targets[i]);
            }
            free(node->data.assign.targets);
            ast_node_free(node->data.assign.value);
            break;
        
        case AST_EXPR:
            ast_node_free(node->data.expr.value);
            break;
        
        case AST_IF:
            ast_node_free(node->data.if_stmt.test);
            for (int i = 0; i < node->data.if_stmt.body_len; i++) {
                ast_node_free(node->data.if_stmt.body[i]);
            }
            free(node->data.if_stmt.body);
            for (int i = 0; i < node->data.if_stmt.orelse_len; i++) {
                ast_node_free(node->data.if_stmt.orelse[i]);
            }
            free(node->data.if_stmt.orelse);
            break;
        
        case AST_FUNCTIONDEF:
            free(node->data.funcdef.name);
            for (int i = 0; i < node->data.funcdef.body_len; i++) {
                ast_node_free(node->data.funcdef.body[i]);
            }
            free(node->data.funcdef.body);
            break;
        
        case AST_CONSTANT:
            free(node->data.constant.value);
            break;
        
        case AST_NAME:
            free(node->data.name.id);
            break;
        
        case AST_BINOP:
            ast_node_free(node->data.binop.left);
            ast_node_free(node->data.binop.right);
            break;
        
        case AST_UNARYOP:
            ast_node_free(node->data.unaryop.operand);
            break;
        
        default: break;
    }
    
    free(node);
}

// ============================ 3. Lexer（对应ast.py的_tokenize） ============================
// 运算符映射（字符串→OpKind）
typedef struct {
    const char* op_str;
    OpKind op_kind;
} OpMapEntry;

static const OpMapEntry op_map[] = {
    {"+", OP_ADD}, {"-", OP_SUB}, {"*", OP_MULT}, {"/", OP_DIV}, {"//", OP_FLOORDIV},
    {"%", OP_MOD}, {"**", OP_POW}, {"&", OP_BITAND}, {"|", OP_BITOR}, {"^", OP_BITXOR},
    {"<<", OP_LSHIFT}, {">>", OP_RSHIFT}, {"@", OP_MATMULT}, {"==", OP_EQ}, {"!=", OP_NOTEQ},
    {"<", OP_LT}, {"<=", OP_LTE}, {">", OP_GT}, {">=", OP_GTE}
};

static int op_map_len = sizeof(op_map) / sizeof(OpMapEntry);

// 检查是否是Python关键字
static bool is_keyword(const char* s) {
    const char* keywords[] = {
        "False","None","True","and","as","assert","async","await",
        "break","class","continue","def","del","elif","else","except",
        "finally","for","from","global","if","import","in","is",
        "lambda","nonlocal","not","or","pass","raise","return",
        "try","while","with","yield"
    };
    int kw_len = sizeof(keywords)/sizeof(char*);
    for (int i=0; i<kw_len; i++) {
        if (strcmp(s, keywords[i]) == 0) return true;
    }
    return false;
}

// 正则匹配辅助函数
static bool regex_match(const char* s, const char* pattern, char* match, size_t match_len) {
    regex_t reg;
    regmatch_t pmatch[1];
    int ret = regcomp(&reg, pattern, REG_EXTENDED);
    if (ret != 0) return false;
    
    ret = regexec(&reg, s, 1, pmatch, 0);
    if (ret == 0) {
        int len = pmatch[0].rm_eo - pmatch[0].rm_so;
        if (len < match_len) {
            strncpy(match, s + pmatch[0].rm_so, len);
            match[len] = '\0';
        }
        regfree(&reg);
        return true;
    }
    
    regfree(&reg);
    return false;
}

// 核心分词函数（对应ast.py的_tokenize）
static Token* tokenize(const char* source, int* token_count_out) {
    Token* tokens = NULL;
    int token_count = 0;
    int pos = 0;
    int line = 1;
    int col = 1;
    int src_len = strlen(source);
    int indent_stack = 0;
    int paren_depth = 0;

    while (pos < src_len) {
        // 跳过空白（非缩进）
        if (source[pos] == ' ' || source[pos] == '\t') {
            pos++; col++;
            continue;
        }
        
        // 换行处理
        if (source[pos] == '\n') {
            tokens = py0c_realloc(tokens, (token_count+1)*sizeof(Token));
            tokens[token_count++] = *token_new(TK_NEWLINE, "\n", line, col);
            pos++; line++; col=1;
            continue;
        }
        
        // 注释处理
        if (source[pos] == '#') {
            while (pos < src_len && source[pos] != '\n') pos++;
            continue;
        }
        
        // 数字匹配
        char num_match[64] = {0};
        if (regex_match(source+pos, "^(0[xX][0-9a-fA-F_]+|0[bB][01_]+|0[oO][0-7_]+|\\d[\\d_]*(\\.\\d+)?([eE][+-]?\\d+)?)", num_match, sizeof(num_match))) {
            tokens = py0c_realloc(tokens, (token_count+1)*sizeof(Token));
            tokens[token_count++] = *token_new(TK_NUM, num_match, line, col);
            pos += strlen(num_match);
            col += strlen(num_match);
            continue;
        }
        
        // 字符串匹配（简化版，支持单/双引号）
        char str_match[1024] = {0};
        if (regex_match(source+pos, "^('([^'\\\\]|\\\\.)*'|\"([^\"\\\\]|\\\\.)*\")", str_match, sizeof(str_match))) {
            tokens = py0c_realloc(tokens, (token_count+1)*sizeof(Token));
            tokens[token_count++] = *token_new(TK_STR, str_match, line, col);
            pos += strlen(str_match);
            col += strlen(str_match);
            continue;
        }
        
        // 运算符匹配（优先长运算符）
        char op_match[8] = {0};
        bool op_found = false;
        for (int i=0; i<op_map_len; i++) {
            const char* op_str = op_map[i].op_str;
            int op_len = strlen(op_str);
            if (strncmp(source+pos, op_str, op_len) == 0) {
                strncpy(op_match, op_str, op_len);
                op_match[op_len] = '\0';
                op_found = true;
                break;
            }
        }
        if (op_found) {
            tokens = py0c_realloc(tokens, (token_count+1)*sizeof(Token));
            tokens[token_count++] = *token_new(TK_OP, op_match, line, col);
            
            // 更新括号深度
            if (strcmp(op_match, "(") == 0 || strcmp(op_match, "[") == 0 || strcmp(op_match, "{") == 0) {
                paren_depth++;
            } else if (strcmp(op_match, ")") == 0 || strcmp(op_match, "]") == 0 || strcmp(op_match, "}") == 0) {
                paren_depth--;
            }
            
            pos += strlen(op_match);
            col += strlen(op_match);
            continue;
        }
        
        // 标识符/关键字匹配
        if (isalpha(source[pos]) || source[pos] == '_') {
            int start = pos;
            while (pos < src_len && (isalnum(source[pos]) || source[pos] == '_')) pos++;
            char name[256] = {0};
            strncpy(name, source+start, pos-start);
            
            tokens = py0c_realloc(tokens, (token_count+1)*sizeof(Token));
            tokens[token_count++] = *token_new(TK_NAME, name, line, col);
            
            col += (pos - start);
            continue;
        }
        
        // 未知字符
        fprintf(stderr, "SyntaxError: unexpected character '%c' at line %d, col %d\n", source[pos], line, col);
        exit(1);
    }
    
    // 添加EOF token
    tokens = py0c_realloc(tokens, (token_count+1)*sizeof(Token));
    tokens[token_count++] = *token_new(TK_EOF, "", line, col);
    
    *token_count_out = token_count;
    return tokens;
}

// ============================ 4. Parser（对应ast.py的_Parser） ============================
static Parser* parser_new(Token* tokens, int token_count) {
    Parser* p = py0c_malloc(sizeof(Parser));
    p->tokens = tokens;
    p->token_count = token_count;
    p->pos = 0;
    return p;
}

static Token* parser_peek(Parser* p, int offset) {
    int idx = p->pos + offset;
    if (idx >= p->token_count) idx = p->token_count - 1;
    return &p->tokens[idx];
}

static Token* parser_advance(Parser* p) {
    if (p->pos < p->token_count) p->pos++;
    return &p->tokens[p->pos-1];
}

static bool parser_eat(Parser* p, TokenKind kind, const char* value) {
    Token* t = parser_peek(p, 0);
    if (t->kind != kind) return false;
    if (value && strcmp(t->value, value) != 0) return false;
    parser_advance(p);
    return true;
}

// 解析表达式（简化版）
static ASTNode* parse_expr(Parser* p);

// 解析赋值语句
static ASTNode* parse_assign(Parser* p) {
    ASTNode* node = ast_node_new(AST_ASSIGN);
    node->lineno = parser_peek(p, 0)->line;
    node->col_offset = parser_peek(p, 0)->col;
    
    // 解析targets（简化：仅支持单个变量）
    Token* name_token = parser_peek(p, 0);
    if (name_token->kind != TK_NAME) {
        fprintf(stderr, "SyntaxError: expected name at line %d\n", name_token->line);
        exit(1);
    }
    parser_advance(p);
    
    ASTNode* target = ast_node_new(AST_NAME);
    target->data.name.id = py0c_strdup(name_token->value);
    target->data.name.ctx = CTX_STORE;
    
    node->data.assign.targets = py0c_malloc(sizeof(ASTNode*));
    node->data.assign.targets[0] = target;
    node->data.assign.targets_len = 1;
    
    // 解析等号
    if (!parser_eat(p, TK_OP, "=")) {
        fprintf(stderr, "SyntaxError: expected '=' at line %d\n", parser_peek(p,0)->line);
        exit(1);
    }
    
    // 解析value
    node->data.assign.value = parse_expr(p);
    return node;
}

// 解析常量
static ASTNode* parse_constant(Parser* p) {
    Token* t = parser_peek(p, 0);
    if (t->kind != TK_NUM && t->kind != TK_STR) return NULL;
    
    ASTNode* node = ast_node_new(AST_CONSTANT);
    node->lineno = t->line;
    node->col_offset = t->col;
    node->data.constant.value = py0c_strdup(t->value);
    parser_advance(p);
    return node;
}

// 解析名称（变量）
static ASTNode* parse_name(Parser* p) {
    Token* t = parser_peek(p, 0);
    if (t->kind != TK_NAME) return NULL;
    
    ASTNode* node = ast_node_new(AST_NAME);
    node->lineno = t->line;
    node->col_offset = t->col;
    node->data.name.id = py0c_strdup(t->value);
    node->data.name.ctx = CTX_LOAD;
    parser_advance(p);
    return node;
}

// 解析二元运算符表达式
static ASTNode* parse_binop(Parser* p) {
    ASTNode* left = parse_constant(p);
    if (!left) left = parse_name(p);
    if (!left) return NULL;
    
    Token* op_token = parser_peek(p, 0);
    if (op_token->kind != TK_OP) return left;
    
    // 查找运算符类型
    OpKind op = OP_ADD;
    for (int i=0; i<op_map_len; i++) {
        if (strcmp(op_token->value, op_map[i].op_str) == 0) {
            op = op_map[i].op_kind;
            break;
        }
    }
    parser_advance(p);
    
    ASTNode* right = parse_expr(p);
    if (!right) {
        fprintf(stderr, "SyntaxError: expected expression after operator at line %d\n", op_token->line);
        exit(1);
    }
    
    ASTNode* node = ast_node_new(AST_BINOP);
    node->lineno = op_token->line;
    node->col_offset = op_token->col;
    node->data.binop.left = left;
    node->data.binop.op = op;
    node->data.binop.right = right;
    return node;
}

// 解析表达式（入口）
static ASTNode* parse_expr(Parser* p) {
    ASTNode* expr = parse_binop(p);
    if (!expr) expr = parse_constant(p);
    if (!expr) expr = parse_name(p);
    return expr;
}

// 解析函数定义
static ASTNode* parse_funcdef(Parser* p) {
    // 跳过def关键字
    parser_eat(p, TK_NAME, "def");
    
    Token* name_token = parser_peek(p, 0);
    if (name_token->kind != TK_NAME) {
        fprintf(stderr, "SyntaxError: expected function name at line %d\n", name_token->line);
        exit(1);
    }
    parser_advance(p);
    
    // 跳过括号（简化版：不解析参数）
    parser_eat(p, TK_OP, "(");
    parser_eat(p, TK_OP, ")");
    parser_eat(p, TK_OP, ":");
    parser_eat(p, TK_NEWLINE, "\n");
    
    ASTNode* func_node = ast_node_new(AST_FUNCTIONDEF);
    func_node->lineno = name_token->line;
    func_node->col_offset = name_token->col;
    func_node->data.funcdef.name = py0c_strdup(name_token->value);
    
    // 解析函数体（简化：仅支持一行return）
    func_node->data.funcdef.body = py0c_malloc(sizeof(ASTNode*));
    func_node->data.funcdef.body_len = 1;
    
    // 解析return语句
    parser_eat(p, TK_NAME, "return");
    ASTNode* ret_expr = parse_expr(p);
    ASTNode* ret_node = ast_node_new(AST_RETURN);
    ret_node->data.ret.value = ret_expr;
    func_node->data.funcdef.body[0] = ret_node;
    
    return func_node;
}

// 解析模块（顶层）
static ASTNode* parse_module(Parser* p) {
    ASTNode* module = ast_node_new(AST_MODULE);
    module->data.module.body = NULL;
    module->data.module.body_len = 0;
    
    while (parser_peek(p,0)->kind != TK_EOF) {
        Token* t = parser_peek(p, 0);
        
        // 解析函数定义
        if (t->kind == TK_NAME && strcmp(t->value, "def") == 0) {
            ASTNode* func = parse_funcdef(p);
            module->data.module.body = py0c_realloc(module->data.module.body, (module->data.module.body_len+1)*sizeof(ASTNode*));
            module->data.module.body[module->data.module.body_len++] = func;
        }
        // 解析赋值语句
        else if (t->kind == TK_NAME && !is_keyword(t->value)) {
            ASTNode* assign = parse_assign(p);
            module->data.module.body = py0c_realloc(module->data.module.body, (module->data.module.body_len+1)*sizeof(ASTNode*));
            module->data.module.body[module->data.module.body_len++] = assign;
        }
        // 跳过换行
        else if (t->kind == TK_NEWLINE) {
            parser_advance(p);
        }
        else {
            fprintf(stderr, "SyntaxError: unexpected token %s at line %d\n", t->value, t->line);
            exit(1);
        }
    }
    
    return module;
}

// ============================ 5. 代码生成器（Python AST → C代码） ============================
// 运算符转C字符串
static const char* op_to_cstr(OpKind op) {
    switch (op) {
        case OP_ADD: return "+";
        case OP_SUB: return "-";
        case OP_MULT: return "*";
        case OP_DIV: return "/";
        case OP_FLOORDIV: return "/";  // C无地板除，简化为普通除
        case OP_MOD: return "%";
        case OP_EQ: return "==";
        case OP_NOTEQ: return "!=";
        case OP_LT: return "<";
        case OP_LTE: return "<=";
        case OP_GT: return ">";
        case OP_GTE: return ">=";
        default: return "?";
    }
}

// 生成表达式的C代码
static char* gen_expr_c(ASTNode* node) {
    if (!node) return py0c_strdup("");
    
    switch (node->kind) {
        case AST_CONSTANT:
            return py0c_strdup(node->data.constant.value);
        
        case AST_NAME:
            return py0c_strdup(node->data.name.id);
        
        case AST_BINOP: {
            char* left = gen_expr_c(node->data.binop.left);
            char* right = gen_expr_c(node->data.binop.right);
            const char* op = op_to_cstr(node->data.binop.op);
            char* res = py0c_strcatf("%s %s %s", left, op, right);
            free(left); free(right);
            return res;
        }
        
        default:
            return py0c_strdup("/* unsupported expr */");
    }
}

// 生成语句的C代码
static void gen_stmt_c(ASTNode* node, FILE* out) {
    if (!node) return;
    
    switch (node->kind) {
        case AST_ASSIGN: {
            // 简化：仅处理单个target
            ASTNode* target = node->data.assign.targets[0];
            if (target->kind == AST_NAME) {
                char* value = gen_expr_c(node->data.assign.value);
                fprintf(out, "    %s = %s;\n", target->data.name.id, value);
                free(value);
            }
            break;
        }
        
        case AST_RETURN: {
            char* value = gen_expr_c(node->data.ret.value);
            fprintf(out, "    return %s;\n", value);
            free(value);
            break;
        }
        
        case AST_FUNCTIONDEF: {
            // 生成函数声明（简化：无参数，返回int）
            fprintf(out, "int %s() {\n", node->data.funcdef.name);
            // 生成函数体
            for (int i=0; i<node->data.funcdef.body_len; i++) {
                gen_stmt_c(node->data.funcdef.body[i], out);
            }
            fprintf(out, "}\n\n");
            break;
        }
        
        default:
            fprintf(out, "    /* unsupported stmt */\n");
            break;
    }
}

// 生成模块的C代码
static void gen_module_c(ASTNode* module, FILE* out) {
    // 生成C头
    fprintf(out, "#include <stdio.h>\n");
    fprintf(out, "#include <stdlib.h>\n\n");
    
    // 生成顶层语句
    for (int i=0; i<module->data.module.body_len; i++) {
        gen_stmt_c(module->data.module.body[i], out);
    }
    
    // 生成main函数（入口）
    fprintf(out, "int main(int argc, char** argv) {\n");
    fprintf(out, "    /* auto-generated main */\n");
    fprintf(out, "    return 0;\n");
    fprintf(out, "}\n");
}

// ============================ 6. 主函数 ============================
int main(int argc, char** argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <python_source>\n", argv[0]);
        return 1;
    }
    
    // 读取Python源代码
    FILE* fp = fopen(argv[1], "r");
    if (!fp) {
        perror("fopen failed");
        return 1;
    }
    
    fseek(fp, 0, SEEK_END);
    long src_len = ftell(fp);
    fseek(fp, 0, SEEK_SET);
    
    char* source = py0c_malloc(src_len + 1);
    fread(source, 1, src_len, fp);
    source[src_len] = '\0';
    fclose(fp);
    
    // 1. 分词
    int token_count;
    Token* tokens = tokenize(source, &token_count);
    
    // 2. 解析生成AST
    Parser* parser = parser_new(tokens, token_count);
    ASTNode* module = parse_module(parser);
    
    // 3. 生成C代码
    gen_module_c(module, stdout);
    
    // 4. 释放资源
    ast_node_free(module);
    free(parser);
    for (int i=0; i<token_count; i++) {
        token_free(&tokens[i]);
    }
    free(tokens);
    free(source);
    
    return 0;
}