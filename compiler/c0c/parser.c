#include "parser.h"
#include "lexer.h"
#include <string.h>

typedef struct {
    char name[64];
    CType ty;
    int array_len;
} Sym;

static Sym symtab[256];
static int sym_cnt = 0;

typedef struct {
    char name[64];
    CType ret;
} FuncSym;

static FuncSym func_tab[128];
static int func_cnt = 0;
static CType current_func_ret = TY_INT;

static void sym_reset(void) { sym_cnt = 0; }

static void sym_add(const char *name, CType ty, int array_len) {
    if (sym_cnt >= 256) error("符號表已滿");
    strcpy(symtab[sym_cnt].name, name);
    symtab[sym_cnt].ty = ty;
    symtab[sym_cnt].array_len = array_len;
    sym_cnt++;
}

static void func_add(const char *name, CType ret) {
    for (int i = 0; i < func_cnt; i++) {
        if (strcmp(func_tab[i].name, name) == 0) return;
    }
    if (func_cnt >= 128) error("函式表已滿");
    strcpy(func_tab[func_cnt].name, name);
    func_tab[func_cnt].ret = ret;
    func_cnt++;
}

static CType func_find(const char *name) {
    for (int i = 0; i < func_cnt; i++) {
        if (strcmp(func_tab[i].name, name) == 0) return func_tab[i].ret;
    }
    return TY_INT;
}

static Sym* sym_find(const char *name) {
    for (int i = sym_cnt - 1; i >= 0; i--) {
        if (strcmp(symtab[i].name, name) == 0) return &symtab[i];
    }
    error("找不到變數宣告");
    return NULL;
}

static int is_ptr(CType ty) { return ty == TY_INT_PTR || ty == TY_CHAR_PTR; }
static CType ptr_of(CType ty) { return (ty == TY_CHAR) ? TY_CHAR_PTR : TY_INT_PTR; }
static CType base_of(CType ty) { return (ty == TY_CHAR_PTR) ? TY_CHAR : TY_INT; }

static CType parse_type_allow_void(int allow_void) {
    CType base;
    if (cur_tok.type == TK_INT) { next_token(); base = TY_INT; }
    else if (cur_tok.type == TK_CHAR) { next_token(); base = TY_CHAR; }
    else if (allow_void && cur_tok.type == TK_VOID) { next_token(); base = TY_VOID; }
    else { error("預期型別 int、char 或 void"); return TY_INT; }
    if (cur_tok.type == TK_MUL) {
        if (base == TY_VOID) error("不支援 void*");
        next_token();
        return ptr_of(base);
    }
    return base;
}

static CType parse_type(void) {
    return parse_type_allow_void(0);
}

static ASTNode* make_var_node(const char *name) {
    Sym *s = sym_find(name);
    ASTNode *n = new_node(AST_VAR);
    strcpy(n->name, name);
    n->ty = s->ty;
    n->array_len = s->array_len;
    return n;
}

static ASTNode* parse_expr();
static ASTNode* parse_stmt();
static ASTNode* parse_block();
static ASTNode* parse_if_stmt();
static ASTNode* parse_while_stmt();
static ASTNode* parse_for_stmt();
static ASTNode* parse_break_stmt();
static ASTNode* parse_continue_stmt();
static ASTNode* parse_unary();
static ASTNode* parse_lvalue();

static ASTNode* parse_primary() {
    if (cur_tok.type == TK_NUM) {
        ASTNode *n = new_node(AST_NUM);
        n->val = cur_tok.val;
        n->ty = TY_INT;
        next_token();
        return n;
    } else if (cur_tok.type == TK_CHAR_LIT) {
        ASTNode *n = new_node(AST_NUM);
        n->val = cur_tok.val;
        n->ty = TY_CHAR;
        next_token();
        return n;
    } else if (cur_tok.type == TK_STR) {
        ASTNode *n = new_node(AST_STR);
        strcpy(n->str_val, cur_tok.str_val);
        n->ty = TY_CHAR_PTR;
        next_token();
        return n;
    } else if (cur_tok.type == TK_IDENT) {
        char name[64];
        strcpy(name, cur_tok.name);
        next_token();

        if (cur_tok.type == TK_LPAREN) {
            next_token();
            ASTNode *n = new_node(AST_CALL);
            strcpy(n->name, name);
            n->ty = func_find(name);
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
            ASTNode *n = make_var_node(name);
            if (cur_tok.type == '[') {
                next_token();
                ASTNode *idx = parse_expr();
                expect(']', "預期 ']'");
                ASTNode *nidx = new_node(AST_INDEX);
                nidx->left = n;
                nidx->right = idx;
                if (!is_ptr(n->ty)) error("只有指標或陣列可以使用 []");
                nidx->ty = base_of(n->ty);
                nidx->array_len = 0;
                return nidx;
            }
            if (cur_tok.type == TK_PLUSPLUS || cur_tok.type == TK_MINUSMINUS) {
                if (is_ptr(n->ty)) error("++/-- 不支援指標");
                ASTNode *inc = new_node(AST_INCDEC);
                inc->op = cur_tok.type;
                inc->is_prefix = 0;
                strcpy(inc->name, name);
                inc->ty = n->ty;
                next_token();
                return inc;
            }
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

static ASTNode* parse_mul() {
    ASTNode *n = parse_unary();
    while (cur_tok.type == TK_MUL || cur_tok.type == TK_DIV || cur_tok.type == TK_MOD) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_unary(); n = p;
        p->ty = TY_INT;
    }
    return n;
}

static ASTNode* parse_add() {
    ASTNode *n = parse_mul();
    while (cur_tok.type == TK_PLUS || cur_tok.type == TK_MINUS) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_mul(); n = p;
        if ((is_ptr(p->left->ty) && (p->op == TK_PLUS || p->op == TK_MINUS)) ||
            (is_ptr(p->right->ty) && p->op == TK_PLUS)) {
            p->ty = is_ptr(p->left->ty) ? p->left->ty : p->right->ty;
        } else {
            p->ty = TY_INT;
        }
    }
    return n;
}

static ASTNode* parse_rel() {
    ASTNode *n = parse_add();
    while (cur_tok.type == TK_LT || cur_tok.type == TK_GT ||
           cur_tok.type == TK_LE || cur_tok.type == TK_GE) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_add(); n = p;
        p->ty = TY_INT;
    }
    return n;
}

static ASTNode* parse_eq() {
    ASTNode *n = parse_rel();
    while (cur_tok.type == TK_EQ || cur_tok.type == TK_NE) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_rel(); n = p;
        p->ty = TY_INT;
    }
    return n;
}

static ASTNode* parse_and() {
    ASTNode *n = parse_eq();
    while (cur_tok.type == TK_ANDAND) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_eq(); n = p;
        p->ty = TY_INT;
    }
    return n;
}

static ASTNode* parse_or() {
    ASTNode *n = parse_and();
    while (cur_tok.type == TK_OROR) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_and(); n = p;
        p->ty = TY_INT;
    }
    return n;
}

static ASTNode* parse_expr() { return parse_or(); }

static ASTNode* parse_unary() {
    if (cur_tok.type == TK_SIZEOF) {
        next_token();
        ASTNode *n = new_node(AST_SIZEOF);
        n->ty = TY_INT;
        if (cur_tok.type == TK_LPAREN) {
            char *saved_p = p; Token saved_tok = cur_tok;
            next_token();
            if (cur_tok.type == TK_INT || cur_tok.type == TK_CHAR) {
                p = saved_p; cur_tok = saved_tok;
                expect(TK_LPAREN, "預期 '('");
                CType ty = parse_type_allow_void(0);
                expect(TK_RPAREN, "預期 ')'");
                n->ty = TY_INT;
                n->val = (ty == TY_CHAR) ? 1 : (is_ptr(ty) ? 8 : 4);
                n->left = NULL;
                n->op = 0;
                return n;
            }
            p = saved_p; cur_tok = saved_tok;
        }
        n->left = parse_unary();
        n->val = (n->left->ty == TY_CHAR) ? 1 : (is_ptr(n->left->ty) ? 8 : 4);
        return n;
    }
    if (cur_tok.type == TK_MINUS || cur_tok.type == TK_NOT ||
        cur_tok.type == TK_PLUSPLUS || cur_tok.type == TK_MINUSMINUS ||
        cur_tok.type == TK_MUL || cur_tok.type == '&') {
        TokenType op = cur_tok.type;
        next_token();
        ASTNode *operand = parse_unary();
        if (op == '&') {
            ASTNode *n = new_node(AST_ADDR);
            n->left = operand;
            n->ty = ptr_of(operand->ty);
            return n;
        }
        if (op == TK_MUL) {
            if (!is_ptr(operand->ty)) error("解參考只能用在指標上");
            ASTNode *n = new_node(AST_DEREF);
            n->left = operand;
            n->ty = base_of(operand->ty);
            return n;
        }
        if (op == TK_PLUSPLUS || op == TK_MINUSMINUS) {
            if (!operand || operand->type != AST_VAR) error("++/-- 只能用在變數上");
            if (is_ptr(operand->ty)) error("++/-- 不支援指標");
            ASTNode *inc = new_node(AST_INCDEC);
            inc->op = op;
            inc->is_prefix = 1;
            strcpy(inc->name, operand->name);
            inc->ty = operand->ty;
            return inc;
        }
        ASTNode *n = new_node(AST_UNARY);
        n->op = op;
        n->left = operand;
        n->ty = TY_INT;
        return n;
    }
    return parse_primary();
}

static ASTNode* parse_lvalue() {
    if (cur_tok.type == TK_MUL) {
        next_token();
        ASTNode *inner = parse_unary();
        if (!is_ptr(inner->ty)) error("解參考只能用在指標上");
        ASTNode *n = new_node(AST_DEREF);
        n->left = inner;
        n->ty = base_of(inner->ty);
        return n;
    }
    if (cur_tok.type == TK_IDENT) {
        char name[64];
        strcpy(name, cur_tok.name);
        next_token();
        ASTNode *n = make_var_node(name);
        if (cur_tok.type == '[') {
            next_token();
            ASTNode *idx = parse_expr();
            expect(']', "預期 ']'");
            ASTNode *nidx = new_node(AST_INDEX);
            nidx->left = n;
            nidx->right = idx;
            if (!is_ptr(n->ty)) error("只有指標或陣列可以使用 []");
            nidx->ty = base_of(n->ty);
            nidx->array_len = 0;
            return nidx;
        }
        return n;
    }
    error("預期左值");
    return NULL;
}

static ASTNode* parse_block() {
    expect(TK_LBRACE, "預期 '{'");
    int scope_mark = sym_cnt;
    ASTNode *head = NULL, *tail = NULL;
    while (cur_tok.type != TK_RBRACE && cur_tok.type != TK_EOF) {
        ASTNode *stmt = parse_stmt();
        if (!head) head = tail = stmt; else { tail->next = stmt; tail = stmt; }
    }
    expect(TK_RBRACE, "預期 '}'");
    sym_cnt = scope_mark;
    return head;
}

static ASTNode* parse_if_stmt() {
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

static ASTNode* parse_while_stmt() {
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

static ASTNode* parse_for_stmt() {
    expect(TK_FOR, "預期 'for'");
    expect(TK_LPAREN, "預期 '('");
    ASTNode *init = NULL;
    ASTNode *cond = NULL;
    ASTNode *update = NULL;

    if (cur_tok.type != TK_SEMI) {
        if (cur_tok.type == TK_INT || cur_tok.type == TK_CHAR) {
            CType decl_ty = parse_type();
            ASTNode *decl = new_node(AST_DECL);
            strcpy(decl->name, cur_tok.name);
            expect(TK_IDENT, "預期變數名稱");
            decl->ty = decl_ty;
            decl->array_len = 0;
            decl->init_kind = 0;
            if (cur_tok.type == '[') {
                if (is_ptr(decl_ty)) error("指標型別不可再宣告為陣列");
                next_token();
                if (cur_tok.type != TK_NUM) error("陣列大小必須是數字");
                decl->array_len = cur_tok.val;
                next_token();
                expect(']', "預期 ']'");
                decl->ty = ptr_of(decl_ty);
            }
            sym_add(decl->name, decl->ty, decl->array_len);
            if (cur_tok.type == TK_ASSIGN) {
                next_token();
                if (decl->array_len > 0) {
                    if (cur_tok.type == TK_STR && base_of(decl->ty) == TY_CHAR) {
                        decl->init_kind = 3;
                        strcpy(decl->str_val, cur_tok.str_val);
                        next_token();
                    } else if (cur_tok.type == '{') {
                        decl->init_kind = 2;
                        next_token();
                        ASTNode *head = NULL, *tail = NULL;
                        if (cur_tok.type != '}') {
                            head = tail = parse_expr();
                            while (cur_tok.type == TK_COMMA) {
                                next_token();
                                tail->next = parse_expr();
                                tail = tail->next;
                            }
                        }
                        expect('}', "預期 '}'");
                        decl->left = head;
                    } else {
                        error("陣列初始化需使用 { } 或字串");
                    }
                } else {
                    decl->init_kind = 1;
                    decl->left = parse_expr();
                }
            }
            init = decl;
        } else if (cur_tok.type == TK_IDENT) {
            char *saved_p = p; Token saved_tok = cur_tok;
            next_token();
            int is_assign = (cur_tok.type == TK_ASSIGN || cur_tok.type == TK_PLUSEQ);
            p = saved_p; cur_tok = saved_tok;
            if (is_assign) {
                ASTNode *assign = new_node(AST_ASSIGN);
                assign->left = make_var_node(cur_tok.name);
                assign->ty = assign->left->ty;
                next_token();
                if (cur_tok.type == TK_ASSIGN || cur_tok.type == TK_PLUSEQ) {
                    assign->op = cur_tok.type;
                    next_token();
                } else {
                    error("預期 '=' 或 '+='");
                }
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
            int is_assign = (cur_tok.type == TK_ASSIGN || cur_tok.type == TK_PLUSEQ);
            p = saved_p; cur_tok = saved_tok;
            if (is_assign) {
                ASTNode *assign = new_node(AST_ASSIGN);
                assign->left = make_var_node(cur_tok.name);
                assign->ty = assign->left->ty;
                next_token();
                if (cur_tok.type == TK_ASSIGN || cur_tok.type == TK_PLUSEQ) {
                    assign->op = cur_tok.type;
                    next_token();
                } else {
                    error("預期 '=' 或 '+='");
                }
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

static ASTNode* parse_break_stmt() {
    expect(TK_BREAK, "預期 'break'");
    ASTNode *n = new_node(AST_BREAK);
    expect(TK_SEMI, "預期 ';'");
    return n;
}

static ASTNode* parse_continue_stmt() {
    expect(TK_CONTINUE, "預期 'continue'");
    ASTNode *n = new_node(AST_CONTINUE);
    expect(TK_SEMI, "預期 ';'");
    return n;
}

static ASTNode* parse_stmt() {
    if (cur_tok.type == TK_INT || cur_tok.type == TK_CHAR) {
        CType decl_ty = parse_type();
        ASTNode *n = new_node(AST_DECL);
        strcpy(n->name, cur_tok.name);
        expect(TK_IDENT, "預期變數名稱");
        n->ty = decl_ty;
        n->array_len = 0;
        n->init_kind = 0;
        if (cur_tok.type == '[') {
            if (is_ptr(decl_ty)) error("指標型別不可再宣告為陣列");
            next_token();
            if (cur_tok.type != TK_NUM) error("陣列大小必須是數字");
            n->array_len = cur_tok.val;
            next_token();
            expect(']', "預期 ']'");
            n->ty = ptr_of(decl_ty);
        }
        sym_add(n->name, n->ty, n->array_len);
        if (cur_tok.type == TK_ASSIGN) {
            next_token();
            if (n->array_len > 0) {
                if (cur_tok.type == TK_STR && base_of(n->ty) == TY_CHAR) {
                    n->init_kind = 3;
                    strcpy(n->str_val, cur_tok.str_val);
                    next_token();
                } else if (cur_tok.type == '{') {
                    n->init_kind = 2;
                    next_token();
                    ASTNode *head = NULL, *tail = NULL;
                    if (cur_tok.type != '}') {
                        head = tail = parse_expr();
                        while (cur_tok.type == TK_COMMA) {
                            next_token();
                            tail->next = parse_expr();
                            tail = tail->next;
                        }
                    }
                    expect('}', "預期 '}'");
                    n->left = head;
                } else {
                    error("陣列初始化需使用 { } 或字串");
                }
            } else {
                n->init_kind = 1;
                n->left = parse_expr();
            }
        }
        expect(TK_SEMI, "預期 ';'");
        return n;
    } else if (cur_tok.type == TK_LBRACE) {
        ASTNode *n = new_node(AST_BLOCK);
        n->left = parse_block();
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
        if (cur_tok.type == TK_SEMI) {
            if (current_func_ret != TY_VOID) error("非 void 函式必須回傳值");
            n->left = NULL;
            n->ty = TY_VOID;
            next_token();
        } else {
            if (current_func_ret == TY_VOID) error("void 函式不能回傳值");
            n->left = parse_expr();
            n->ty = current_func_ret;
            expect(TK_SEMI, "預期 ';'");
        }
        return n;
    } else if (cur_tok.type == TK_IDENT || cur_tok.type == TK_MUL) {
        if (cur_tok.type == TK_IDENT) {
            char *saved_p2 = p; Token saved_tok2 = cur_tok;
            next_token();
            int is_call = (cur_tok.type == TK_LPAREN);
            p = saved_p2; cur_tok = saved_tok2;
            if (is_call) {
                ASTNode *n = new_node(AST_EXPR_STMT);
                n->left = parse_expr();
                expect(TK_SEMI, "預期 ';'");
                return n;
            }
        }
        char *saved_p = p; Token saved_tok = cur_tok;
        ASTNode *lv = parse_lvalue();
        int is_assign = (cur_tok.type == TK_ASSIGN || cur_tok.type == TK_PLUSEQ);
        if (is_assign) {
            ASTNode *n = new_node(AST_ASSIGN);
            n->left = lv;
            n->ty = lv->ty;
            if (cur_tok.type == TK_ASSIGN || cur_tok.type == TK_PLUSEQ) {
                n->op = cur_tok.type;
                next_token();
            } else {
                error("預期 '=' 或 '+='");
            }
            n->right = parse_expr();
            expect(TK_SEMI, "預期 ';'");
            return n;
        }
        p = saved_p; cur_tok = saved_tok;
        ASTNode *n = new_node(AST_EXPR_STMT);
        n->left = parse_expr();
        expect(TK_SEMI, "預期 ';'");
        return n;
    }
    error("未知的陳述式 (Statement)");
    return NULL;
}

static ASTNode* parse_func() {
    CType ret_ty = parse_type_allow_void(1);
    ASTNode *func = new_node(AST_FUNC);
    func->ty = ret_ty;
    strcpy(func->name, cur_tok.name);
    expect(TK_IDENT, "預期函數名稱");
    func_add(func->name, ret_ty);
    expect(TK_LPAREN, "預期 '('");

    sym_reset();
    ASTNode *param_head = NULL, *param_tail = NULL;
    if (cur_tok.type != TK_RPAREN) {
        while (1) {
            CType pty = parse_type();
            ASTNode *param = new_node(AST_DECL);
            strcpy(param->name, cur_tok.name);
            expect(TK_IDENT, "預期參數名稱");
            param->ty = pty;
            param->array_len = 0;
            param->init_kind = 0;
            sym_add(param->name, pty, 0);
            if (!param_head) param_head = param_tail = param;
            else { param_tail->next = param; param_tail = param; }
            if (cur_tok.type == TK_COMMA) { next_token(); continue; }
            break;
        }
    }
    expect(TK_RPAREN, "預期 ')'");
    if (cur_tok.type == TK_SEMI) {
        next_token();
        func->left = param_head;
        func->right = NULL;
        func->is_decl = 1;
        return func;
    }

    current_func_ret = ret_ty;
    ASTNode *body = parse_block();
    func->left = param_head;
    func->right = body;
    func->is_decl = 0;
    return func;
}

ASTNode* parse_program(void) {
    ASTNode *head = NULL, *tail = NULL;
    while (cur_tok.type != TK_EOF) {
        ASTNode *func = parse_func();
        if (!head) head = tail = func; else { tail->next = func; tail = func; }
    }
    return head;
}
