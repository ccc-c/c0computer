#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

// ============================================================================
// 1. 詞法分析 (Lexer)
// ============================================================================
typedef enum {
    TK_EOF, TK_INT, TK_RETURN, TK_IF, TK_ELSE, TK_WHILE, TK_FOR, TK_BREAK, TK_CONTINUE,
    TK_IDENT, TK_NUM, TK_STR,
    TK_ASSIGN = '=', TK_PLUS = '+', TK_MINUS = '-', TK_MUL = '*', TK_DIV = '/',
    TK_LT = '<', TK_GT = '>', TK_NOT = '!', TK_LPAREN = '(', TK_RPAREN = ')',
    TK_LBRACE = '{', TK_RBRACE = '}', TK_SEMI = ';', TK_COMMA = ','
} TokenType;

typedef struct {
    TokenType type;
    int val;
    char name[64];
    char str_val[256]; // 專門用來存放字串內容
} Token;

char *src, *p;
Token cur_tok;

void error(const char *msg) {
    fprintf(stderr, "編譯錯誤: %s\n", msg);
    exit(1);
}

void next_token() {
    // 忽略 UTF-8 BOM
    if (p == src && strncmp(p, "\xEF\xBB\xBF", 3) == 0) p += 3;

    while (1) {
        while (isspace((unsigned char)*p)) p++; // 跳過空白
        if (strncmp(p, "//", 2) == 0) { while (*p != '\0' && *p != '\n') p++; continue; }
        if (strncmp(p, "/*", 2) == 0) {
            p += 2; while (*p != '\0' && strncmp(p, "*/", 2) != 0) p++;
            if (*p != '\0') p += 2; continue;
        }
        if (*p == '#') { while (*p != '\0' && *p != '\n') p++; continue; }
        break;
    }

    if (*p == '\0') { cur_tok.type = TK_EOF; return; }

    // 處理字串 ("...")
    if (*p == '"') {
        p++; // 跳過開頭的 "
        char *s = cur_tok.str_val;
        while (*p != '\0' && *p != '"') *s++ = *p++;
        *s = '\0';
        if (*p == '"') p++; // 跳過結尾的 "
        cur_tok.type = TK_STR;
        return;
    }

    if (isalpha((unsigned char)*p) || *p == '_') {
        char *start = p;
        while (isalnum((unsigned char)*p) || *p == '_') p++;
        int len = p - start;
        strncpy(cur_tok.name, start, len);
        cur_tok.name[len] = '\0';
        
        if (strcmp(cur_tok.name, "int") == 0) cur_tok.type = TK_INT;
        else if (strcmp(cur_tok.name, "return") == 0) cur_tok.type = TK_RETURN;
        else if (strcmp(cur_tok.name, "if") == 0) cur_tok.type = TK_IF;
        else if (strcmp(cur_tok.name, "else") == 0) cur_tok.type = TK_ELSE;
        else if (strcmp(cur_tok.name, "while") == 0) cur_tok.type = TK_WHILE;
        else if (strcmp(cur_tok.name, "for") == 0) cur_tok.type = TK_FOR;
        else if (strcmp(cur_tok.name, "break") == 0) cur_tok.type = TK_BREAK;
        else if (strcmp(cur_tok.name, "continue") == 0) cur_tok.type = TK_CONTINUE;
        else cur_tok.type = TK_IDENT;
        return;
    }

    if (isdigit((unsigned char)*p)) {
        cur_tok.val = strtol(p, &p, 10);
        cur_tok.type = TK_NUM;
        return;
    }

    // 處理雙字元運算子: == != <= >=
    if (p[0] == '=' && p[1] == '=') { cur_tok.type = (TokenType)257; p += 2; return; }
    if (p[0] == '!' && p[1] == '=') { cur_tok.type = (TokenType)258; p += 2; return; }
    if (p[0] == '<' && p[1] == '=') { cur_tok.type = (TokenType)259; p += 2; return; }
    if (p[0] == '>' && p[1] == '=') { cur_tok.type = (TokenType)260; p += 2; return; }

    cur_tok.type = (TokenType)(*p++); // 處理 + - * / ( ) { } ; , < > ! =
}

void expect(TokenType type, const char *msg) {
    if (cur_tok.type == type) next_token();
    else error(msg);
}

// ============================================================================
// 2. 抽象語法樹 (AST) 與 語法分析 (Parser) 
// ============================================================================
typedef enum {
    AST_FUNC, AST_DECL, AST_ASSIGN, AST_BINOP, AST_VAR, AST_NUM, AST_RETURN,
    AST_STR, AST_CALL, AST_EXPR_STMT, AST_IF, AST_WHILE, AST_FOR, AST_BREAK, AST_CONTINUE
} ASTNodeType;

typedef struct ASTNode {
    ASTNodeType type;
    int val;             
    char name[64];       
    char str_val[256];   
    int op;
    struct ASTNode *left, *right;
    struct ASTNode *cond, *then_body, *else_body;
    struct ASTNode *init, *update, *body;
    struct ASTNode *next; 
} ASTNode;

ASTNode* new_node(ASTNodeType type) {
    ASTNode *n = calloc(1, sizeof(ASTNode));
    n->type = type;
    return n;
}

ASTNode* parse_expr();
ASTNode* parse_stmt();
ASTNode* parse_block();
ASTNode* parse_if_stmt();
ASTNode* parse_while_stmt();
ASTNode* parse_for_stmt();
ASTNode* parse_break_stmt();
ASTNode* parse_continue_stmt();

ASTNode* parse_primary() {
    if (cur_tok.type == TK_NUM) {
        ASTNode *n = new_node(AST_NUM);
        n->val = cur_tok.val;
        next_token();
        return n;
    } else if (cur_tok.type == TK_STR) {
        ASTNode *n = new_node(AST_STR);
        strcpy(n->str_val, cur_tok.str_val);
        next_token();
        return n;
    } else if (cur_tok.type == TK_IDENT) {
        char name[64];
        strcpy(name, cur_tok.name);
        next_token();
        
        // 如果緊接著是 '('，代表是函數呼叫 (例如 printf)
        if (cur_tok.type == TK_LPAREN) {
            next_token();
            ASTNode *n = new_node(AST_CALL);
            strcpy(n->name, name);
            ASTNode *head = NULL, *tail = NULL;
            if (cur_tok.type != TK_RPAREN) {
                head = tail = parse_expr();
                while (cur_tok.type == TK_COMMA) {
                    next_token();
                    tail->next = parse_expr();
                    tail = tail->next;
                }
            }
            expect(TK_RPAREN, "預期 ')'");
            n->left = head;
            return n;
        } else {
            // 否則只是一般變數
            ASTNode *n = new_node(AST_VAR);
            strcpy(n->name, name);
            return n;
        }
    } else if (cur_tok.type == TK_LPAREN) {
        next_token();
        ASTNode *n = parse_expr();
        expect(TK_RPAREN, "預期 ')'");
        return n;
    }
    error("預期 表達式 (Expression)");
    return NULL;
}

ASTNode* parse_mul() {
    ASTNode *n = parse_primary();
    while (cur_tok.type == TK_MUL || cur_tok.type == TK_DIV) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_primary(); n = p;
    }
    return n;
}

ASTNode* parse_add() {
    ASTNode *n = parse_mul();
    while (cur_tok.type == TK_PLUS || cur_tok.type == TK_MINUS) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_mul(); n = p;
    }
    return n;
}

ASTNode* parse_rel() {
    ASTNode *n = parse_add();
    while (cur_tok.type == TK_LT || cur_tok.type == TK_GT ||
           cur_tok.type == (TokenType)259 || cur_tok.type == (TokenType)260) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_add(); n = p;
    }
    return n;
}

ASTNode* parse_eq() {
    ASTNode *n = parse_rel();
    while (cur_tok.type == (TokenType)257 || cur_tok.type == (TokenType)258) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_rel(); n = p;
    }
    return n;
}

ASTNode* parse_expr() { return parse_eq(); }

ASTNode* parse_block() {
    expect(TK_LBRACE, "預期 '{'");
    ASTNode *head = NULL, *tail = NULL;
    while (cur_tok.type != TK_RBRACE && cur_tok.type != TK_EOF) {
        ASTNode *stmt = parse_stmt();
        if (!head) head = tail = stmt; else { tail->next = stmt; tail = stmt; }
    }
    expect(TK_RBRACE, "預期 '}'");
    return head;
}

ASTNode* parse_if_stmt() {
    expect(TK_IF, "預期 'if'");
    expect(TK_LPAREN, "預期 '('");
    ASTNode *cond = parse_expr();
    expect(TK_RPAREN, "預期 ')'");

    ASTNode *then_body = NULL;
    if (cur_tok.type == TK_LBRACE) then_body = parse_block();
    else then_body = parse_stmt();

    ASTNode *else_body = NULL;
    if (cur_tok.type == TK_ELSE) {
        next_token();
        if (cur_tok.type == TK_LBRACE) else_body = parse_block();
        else else_body = parse_stmt();
    }

    ASTNode *n = new_node(AST_IF);
    n->cond = cond;
    n->then_body = then_body;
    n->else_body = else_body;
    return n;
}

ASTNode* parse_while_stmt() {
    expect(TK_WHILE, "預期 'while'");
    expect(TK_LPAREN, "預期 '('");
    ASTNode *cond = parse_expr();
    expect(TK_RPAREN, "預期 ')'");
    ASTNode *body = NULL;
    if (cur_tok.type == TK_LBRACE) body = parse_block();
    else body = parse_stmt();
    ASTNode *n = new_node(AST_WHILE);
    n->cond = cond;
    n->body = body;
    return n;
}

ASTNode* parse_for_stmt() {
    expect(TK_FOR, "預期 'for'");
    expect(TK_LPAREN, "預期 '('");
    ASTNode *init = NULL;
    ASTNode *cond = NULL;
    ASTNode *update = NULL;

    if (cur_tok.type != TK_SEMI) {
        if (cur_tok.type == TK_INT) {
            next_token();
            ASTNode *decl = new_node(AST_DECL);
            strcpy(decl->name, cur_tok.name);
            expect(TK_IDENT, "預期變數名稱");
            if (cur_tok.type == TK_ASSIGN) {
                next_token();
                decl->left = parse_expr();
            }
            init = decl;
        } else if (cur_tok.type == TK_IDENT) {
            char *saved_p = p; Token saved_tok = cur_tok;
            next_token();
            int is_assign = (cur_tok.type == TK_ASSIGN);
            p = saved_p; cur_tok = saved_tok;
            if (is_assign) {
                ASTNode *assign = new_node(AST_ASSIGN);
                strcpy(assign->name, cur_tok.name);
                next_token(); expect(TK_ASSIGN, "預期 '='");
                assign->right = parse_expr();
                init = assign;
            } else {
                ASTNode *expr = parse_expr();
                init = new_node(AST_EXPR_STMT);
                init->left = expr;
            }
        } else {
            ASTNode *expr = parse_expr();
            init = new_node(AST_EXPR_STMT);
            init->left = expr;
        }
    }
    expect(TK_SEMI, "預期 ';'");

    if (cur_tok.type != TK_SEMI) {
        cond = parse_expr();
    }
    expect(TK_SEMI, "預期 ';'");

    if (cur_tok.type != TK_RPAREN) {
        if (cur_tok.type == TK_IDENT) {
            char *saved_p = p; Token saved_tok = cur_tok;
            next_token();
            int is_assign = (cur_tok.type == TK_ASSIGN);
            p = saved_p; cur_tok = saved_tok;
            if (is_assign) {
                ASTNode *assign = new_node(AST_ASSIGN);
                strcpy(assign->name, cur_tok.name);
                next_token(); expect(TK_ASSIGN, "預期 '='");
                assign->right = parse_expr();
                update = assign;
            } else {
                update = parse_expr();
            }
        } else {
            update = parse_expr();
        }
    }
    expect(TK_RPAREN, "預期 ')'");

    ASTNode *body = NULL;
    if (cur_tok.type == TK_LBRACE) body = parse_block();
    else body = parse_stmt();

    ASTNode *n = new_node(AST_FOR);
    n->init = init;
    n->cond = cond;
    n->update = update;
    n->body = body;
    return n;
}

ASTNode* parse_break_stmt() {
    expect(TK_BREAK, "預期 'break'");
    ASTNode *n = new_node(AST_BREAK);
    expect(TK_SEMI, "預期 ';'");
    return n;
}

ASTNode* parse_continue_stmt() {
    expect(TK_CONTINUE, "預期 'continue'");
    ASTNode *n = new_node(AST_CONTINUE);
    expect(TK_SEMI, "預期 ';'");
    return n;
}

ASTNode* parse_stmt() {
    if (cur_tok.type == TK_INT) {
        next_token();
        ASTNode *n = new_node(AST_DECL);
        strcpy(n->name, cur_tok.name);
        expect(TK_IDENT, "預期變數名稱");
        if (cur_tok.type == TK_ASSIGN) {
            next_token();
            n->left = parse_expr();
        }
        expect(TK_SEMI, "預期 ';'");
        return n;
    } else if (cur_tok.type == TK_IF) {
        return parse_if_stmt();
    } else if (cur_tok.type == TK_WHILE) {
        return parse_while_stmt();
    } else if (cur_tok.type == TK_FOR) {
        return parse_for_stmt();
    } else if (cur_tok.type == TK_BREAK) {
        return parse_break_stmt();
    } else if (cur_tok.type == TK_CONTINUE) {
        return parse_continue_stmt();
    } else if (cur_tok.type == TK_RETURN) {
        next_token();
        ASTNode *n = new_node(AST_RETURN);
        n->left = parse_expr();
        expect(TK_SEMI, "預期 ';'");
        return n;
    } else if (cur_tok.type == TK_IDENT) {
        // 利用 Lookahead 偷看下一個字元，區分賦值 (a = 1) 還是函數呼叫 (printf(...))
        char *saved_p = p; Token saved_tok = cur_tok;
        next_token();
        int is_assign = (cur_tok.type == TK_ASSIGN);
        p = saved_p; cur_tok = saved_tok; // 恢復狀態

        if (is_assign) {
            ASTNode *n = new_node(AST_ASSIGN);
            strcpy(n->name, cur_tok.name);
            next_token(); expect(TK_ASSIGN, "預期 '='");
            n->right = parse_expr();
            expect(TK_SEMI, "預期 ';'");
            return n;
        } else {
            // 解析獨立的表達式 (例如 printf("..."); )
            ASTNode *n = new_node(AST_EXPR_STMT);
            n->left = parse_expr();
            expect(TK_SEMI, "預期 ';'");
            return n;
        }
    }
    error("未知的陳述式 (Statement)");
    return NULL;
}

ASTNode* parse_func() {
    expect(TK_INT, "函數必須回傳 int");
    ASTNode *func = new_node(AST_FUNC);
    strcpy(func->name, cur_tok.name);
    expect(TK_IDENT, "預期函數名稱");
    expect(TK_LPAREN, "預期 '('");

    ASTNode *param_head = NULL, *param_tail = NULL;
    if (cur_tok.type != TK_RPAREN) {
        while (1) {
            expect(TK_INT, "參數必須是 int");
            ASTNode *param = new_node(AST_DECL);
            strcpy(param->name, cur_tok.name);
            expect(TK_IDENT, "預期參數名稱");
            if (!param_head) param_head = param_tail = param;
            else { param_tail->next = param; param_tail = param; }
            if (cur_tok.type == TK_COMMA) { next_token(); continue; }
            break;
        }
    }
    expect(TK_RPAREN, "預期 ')'");

    ASTNode *body = parse_block();
    func->left = param_head;   // 參數串列
    func->right = body;        // 函數主體
    return func;
}

ASTNode* parse_program() {
    ASTNode *head = NULL, *tail = NULL;
    while (cur_tok.type != TK_EOF) {
        ASTNode *func = parse_func();
        if (!head) head = tail = func; else { tail->next = func; tail = func; }
    }
    return head;
}

// ============================================================================
// 3. LLVM IR 程式碼生成 (Code Generator)
// ============================================================================
FILE *out;
int reg_cnt = 0;
int label_cnt = 0;
char string_table[100][256]; // 收集所有全域字串
int string_cnt = 0;
ASTNode *current_params = NULL;
int stmt_list_ends_with_return(ASTNode *node);
int stmt_ends_with_return(ASTNode *node);
int stmt_list_ends_with_break(ASTNode *node);
int stmt_ends_with_break(ASTNode *node);
int stmt_list_may_fallthrough(ASTNode *node);
int stmt_may_fallthrough(ASTNode *node);
int break_label_stack[128];
int continue_label_stack[128];
int loop_depth = 0;

int is_param(ASTNode *params, const char *name) {
    ASTNode *pnode = params;
    while (pnode) {
        if (strcmp(pnode->name, name) == 0) return 1;
        pnode = pnode->next;
    }
    return 0;
}

int stmt_ends_with_return(ASTNode *node) {
    if (!node) return 0;
    if (node->type == AST_RETURN) return 1;
    if (node->type == AST_BREAK || node->type == AST_CONTINUE) return 1;
    if (node->type == AST_IF) {
        int then_ret = stmt_list_ends_with_return(node->then_body);
        int else_ret = stmt_list_ends_with_return(node->else_body);
        return then_ret && else_ret;
    }
    return 0;
}

int stmt_list_ends_with_return(ASTNode *node) {
    if (!node) return 0;
    ASTNode *cur = node;
    while (cur->next) cur = cur->next;
    return stmt_ends_with_return(cur);
}

int stmt_ends_with_break(ASTNode *node) {
    if (!node) return 0;
    if (node->type == AST_WHILE || node->type == AST_FOR) return 0;
    if (node->type == AST_IF) {
        int then_br = stmt_list_ends_with_break(node->then_body);
        int else_br = stmt_list_ends_with_break(node->else_body);
        return then_br && else_br;
    }
    return 0;
}

int stmt_list_ends_with_break(ASTNode *node) {
    if (!node) return 0;
    ASTNode *cur = node;
    while (cur->next) cur = cur->next;
    return stmt_ends_with_break(cur);
}

int stmt_may_fallthrough(ASTNode *node) {
    if (!node) return 1;
    if (node->type == AST_RETURN || node->type == AST_BREAK || node->type == AST_CONTINUE) return 0;
    if (node->type == AST_IF) {
        int then_ft = stmt_list_may_fallthrough(node->then_body);
        int else_ft = node->else_body ? stmt_list_may_fallthrough(node->else_body) : 1;
        return then_ft || else_ft;
    }
    return 1;
}

int stmt_list_may_fallthrough(ASTNode *node) {
    if (!node) return 1;
    ASTNode *cur = node;
    while (cur->next) cur = cur->next;
    return stmt_may_fallthrough(cur);
}

char* gen_expr(ASTNode *node) {
    char *res = malloc(64);
    if (node->type == AST_NUM) {
        sprintf(res, "%d", node->val);
        return res;
    } else if (node->type == AST_STR) {
        int id = string_cnt++;
        strcpy(string_table[id], node->str_val);
        sprintf(res, "@.str.%d", id);
        return res;
    } else if (node->type == AST_VAR) {
        int r = reg_cnt++;
        if (is_param(current_params, node->name)) {
            fprintf(out, "  %%%d = load i32, ptr %%%s.addr\n", r, node->name);
        } else {
            fprintf(out, "  %%%d = load i32, ptr %%%s\n", r, node->name);
        }
        sprintf(res, "%%%d", r);
        return res;
    } else if (node->type == AST_CALL) {
        char *arg_res[10];
        char arg_types[10][16];
        int arg_count = 0;
        ASTNode *arg = node->left;
        while (arg) {
            arg_res[arg_count] = gen_expr(arg);
            // 判斷參數型別 (字串傳指標 ptr，其他傳 i32)
            if (arg->type == AST_STR) strcpy(arg_types[arg_count], "ptr");
            else strcpy(arg_types[arg_count], "i32");
            arg = arg->next;
            arg_count++;
        }
        int r = reg_cnt++;
        int is_printf = (strcmp(node->name, "printf") == 0);
        if (is_printf) fprintf(out, "  %%%d = call i32 (ptr, ...) @%s(", r, node->name);
        else fprintf(out, "  %%%d = call i32 @%s(", r, node->name);
        for (int i = 0; i < arg_count; i++) {
            if (i > 0) fprintf(out, ", ");
            if (arg_types[i][0] == 'p') fprintf(out, "ptr %s", arg_res[i]); // ptr @.str.0
            else fprintf(out, "i32 %s", arg_res[i]);                       // i32 %1
            free(arg_res[i]);
        }
        fprintf(out, ")\n");
        sprintf(res, "%%%d", r);
        return res;
    } else if (node->type == AST_BINOP) {
        char *left = gen_expr(node->left);
        char *right = gen_expr(node->right);
        int r = reg_cnt++;
        if (node->op == '+') fprintf(out, "  %%%d = add i32 %s, %s\n", r, left, right);
        if (node->op == '-') fprintf(out, "  %%%d = sub i32 %s, %s\n", r, left, right);
        if (node->op == '*') fprintf(out, "  %%%d = mul i32 %s, %s\n", r, left, right);
        if (node->op == '/') fprintf(out, "  %%%d = sdiv i32 %s, %s\n", r, left, right);
        if (node->op == TK_LT) fprintf(out, "  %%%d = icmp slt i32 %s, %s\n", r, left, right);
        if (node->op == TK_GT) fprintf(out, "  %%%d = icmp sgt i32 %s, %s\n", r, left, right);
        if (node->op == (TokenType)259) fprintf(out, "  %%%d = icmp sle i32 %s, %s\n", r, left, right);
        if (node->op == (TokenType)260) fprintf(out, "  %%%d = icmp sge i32 %s, %s\n", r, left, right);
        if (node->op == (TokenType)257) fprintf(out, "  %%%d = icmp eq i32 %s, %s\n", r, left, right);
        if (node->op == (TokenType)258) fprintf(out, "  %%%d = icmp ne i32 %s, %s\n", r, left, right);
        free(left); free(right);
        sprintf(res, "%%%d", r);
        return res;
    }
    return NULL;
}

void gen_stmt(ASTNode *node) {
    while (node) {
        if (node->type == AST_DECL) {
            if (is_param(current_params, node->name)) {
                fprintf(out, "  %%%s.addr = alloca i32\n", node->name);
                fprintf(out, "  store i32 %%%s, ptr %%%s.addr\n", node->name, node->name);
            } else {
                fprintf(out, "  %%%s = alloca i32\n", node->name);
                if (node->left) {
                    char *val = gen_expr(node->left);
                    fprintf(out, "  store i32 %s, ptr %%%s\n", val, node->name);
                    free(val);
                }
            }
        } else if (node->type == AST_ASSIGN) {
            char *val = gen_expr(node->right);
            if (is_param(current_params, node->name)) {
                fprintf(out, "  store i32 %s, ptr %%%s.addr\n", val, node->name);
            } else {
                fprintf(out, "  store i32 %s, ptr %%%s\n", val, node->name);
            }
            free(val);
        } else if (node->type == AST_EXPR_STMT) {
            char *val = gen_expr(node->left); // 執行 printf 呼叫
            if (val) free(val);
        } else if (node->type == AST_IF) {
            char *cond_val = gen_expr(node->cond);
            int then_fall = stmt_list_may_fallthrough(node->then_body);
            int else_fall = node->else_body ? stmt_list_may_fallthrough(node->else_body) : 1;
            int need_end = then_fall || else_fall;
            int then_label = label_cnt++;
            int else_label = node->else_body ? label_cnt++ : (need_end ? label_cnt++ : label_cnt++);
            int end_label = need_end ? label_cnt++ : -1;
            if (!node->else_body) else_label = end_label;

            fprintf(out, "  br i1 %s, label %%L%d, label %%L%d\n", cond_val, then_label, else_label);
            free(cond_val);

            fprintf(out, "L%d:\n", then_label);
            gen_stmt(node->then_body);
            if (then_fall && need_end) {
                fprintf(out, "  br label %%L%d\n", end_label);
            }

            if (node->else_body) {
                fprintf(out, "L%d:\n", else_label);
                gen_stmt(node->else_body);
                if (else_fall && need_end) {
                    fprintf(out, "  br label %%L%d\n", end_label);
                }
            }

            if (need_end) {
                fprintf(out, "L%d:\n", end_label);
            }
        } else if (node->type == AST_WHILE) {
            int cond_label = label_cnt++;
            int body_label = label_cnt++;
            int end_label = label_cnt++;
            fprintf(out, "  br label %%L%d\n", cond_label);

            fprintf(out, "L%d:\n", cond_label);
            char *cond_val = gen_expr(node->cond);
            fprintf(out, "  br i1 %s, label %%L%d, label %%L%d\n", cond_val, body_label, end_label);
            free(cond_val);

            fprintf(out, "L%d:\n", body_label);
            break_label_stack[loop_depth] = end_label;
            continue_label_stack[loop_depth] = cond_label;
            loop_depth++;
            gen_stmt(node->body);
            if (stmt_list_may_fallthrough(node->body)) {
                fprintf(out, "  br label %%L%d\n", cond_label);
            }
            loop_depth--;

            fprintf(out, "L%d:\n", end_label);
        } else if (node->type == AST_FOR) {
            if (node->init) {
                if (node->init->type == AST_DECL) gen_stmt(node->init);
                else if (node->init->type == AST_ASSIGN) {
                    char *val = gen_expr(node->init->right);
                    if (is_param(current_params, node->init->name)) {
                        fprintf(out, "  store i32 %s, ptr %%%s.addr\n", val, node->init->name);
                    } else {
                        fprintf(out, "  store i32 %s, ptr %%%s\n", val, node->init->name);
                    }
                    free(val);
                }
                else if (node->init->type == AST_EXPR_STMT) {
                    char *val = gen_expr(node->init->left);
                    if (val) free(val);
                }
            }

            int cond_label = label_cnt++;
            int body_label = label_cnt++;
            int update_label = label_cnt++;
            int end_label = label_cnt++;

            fprintf(out, "  br label %%L%d\n", cond_label);

            fprintf(out, "L%d:\n", cond_label);
            if (node->cond) {
                char *cond_val = gen_expr(node->cond);
                fprintf(out, "  br i1 %s, label %%L%d, label %%L%d\n", cond_val, body_label, end_label);
                free(cond_val);
            } else {
                fprintf(out, "  br label %%L%d\n", body_label);
            }

            fprintf(out, "L%d:\n", body_label);
            break_label_stack[loop_depth] = end_label;
            continue_label_stack[loop_depth] = update_label;
            loop_depth++;
            gen_stmt(node->body);
            if (stmt_list_may_fallthrough(node->body)) {
                fprintf(out, "  br label %%L%d\n", update_label);
            }
            loop_depth--;

            fprintf(out, "L%d:\n", update_label);
            if (node->update) {
                if (node->update->type == AST_ASSIGN) {
                    char *val = gen_expr(node->update->right);
                    if (is_param(current_params, node->update->name)) {
                        fprintf(out, "  store i32 %s, ptr %%%s.addr\n", val, node->update->name);
                    } else {
                        fprintf(out, "  store i32 %s, ptr %%%s\n", val, node->update->name);
                    }
                    free(val);
                } else {
                    char *val = gen_expr(node->update);
                    if (val) free(val);
                }
            }
            fprintf(out, "  br label %%L%d\n", cond_label);

            fprintf(out, "L%d:\n", end_label);
        } else if (node->type == AST_BREAK) {
            if (loop_depth == 0) error("break 不在迴圈內");
            fprintf(out, "  br label %%L%d\n", break_label_stack[loop_depth - 1]);
        } else if (node->type == AST_CONTINUE) {
            if (loop_depth == 0) error("continue 不在迴圈內");
            fprintf(out, "  br label %%L%d\n", continue_label_stack[loop_depth - 1]);
        } else if (node->type == AST_RETURN) {
            char *val = gen_expr(node->left);
            fprintf(out, "  ret i32 %s\n", val);
            free(val);
        }
        node = node->next;
    }
}

void gen_llvm_ir(ASTNode *funcs) {
    fprintf(out, "; ModuleID = 'c0c'\n");
    // fprintf(out, "target triple = \"arm64-apple-macosx15.0.0\"\n\n");
    ASTNode *func = funcs;
    while (func) {
        // 印出函數簽名 (參數一律 i32)
        fprintf(out, "define i32 @%s(", func->name);
        ASTNode *param = func->left;
        int first = 1;
        while (param) {
            if (!first) fprintf(out, ", ");
            fprintf(out, "i32 %%%s", param->name);
            first = 0;
            param = param->next;
        }
        fprintf(out, ") {\n");
        fprintf(out, "entry:\n");
        reg_cnt = 0;
        current_params = func->left;
        // 先配置參數地址
        ASTNode *pnode = current_params;
        while (pnode) {
            gen_stmt(pnode);
            pnode = pnode->next;
        }
        gen_stmt(func->right);
        fprintf(out, "}\n\n");
        func = func->next;
    }

    // 輸出收集到的所有全域字串常數
    for (int i = 0; i < string_cnt; i++) {
        char llvm_str[512] = {0};
        int len = 0;
        char *p = string_table[i];
        while (*p) {
            if (*p == '\\' && *(p+1) == 'n') {
                strcat(llvm_str, "\\0A"); // LLVM IR 中的換行符號
                len++; p += 2;
            } else {
                int l = strlen(llvm_str);
                llvm_str[l] = *p; llvm_str[l+1] = '\0';
                len++; p++;
            }
        }
        strcat(llvm_str, "\\00"); len++; // C字串結尾 \0
        fprintf(out, "@.str.%d = private unnamed_addr constant [%d x i8] c\"%s\", align 1\n", i, len, llvm_str);
    }
    
    // 宣告 printf (這是 C 標準函式庫提供的)
    fprintf(out, "declare i32 @printf(ptr, ...)\n");
}

// ============================================================================
// 4. 主程式 (Main)
// ============================================================================
int main(int argc, char **argv) {
    if (argc != 4 || strcmp(argv[2], "-o") != 0) {
        fprintf(stderr, "用法: ./c0c <input.c> -o <output.ll>\n"); return 1;
    }

    FILE *f = fopen(argv[1], "rb");
    if (!f) error("無法開啟輸入檔案");
    fseek(f, 0, SEEK_END); long fsize = ftell(f); fseek(f, 0, SEEK_SET);
    src = malloc(fsize + 1); fread(src, 1, fsize, f); src[fsize] = 0; fclose(f);

    out = fopen(argv[3], "w");
    if (!out) error("無法開啟輸出檔案");

    p = src;
    next_token();
    ASTNode *ast = parse_program();
    gen_llvm_ir(ast);

    printf("[成功] 已將 %s 編譯至 %s\n", argv[1], argv[3]);
    fclose(out); free(src); return 0;
}
