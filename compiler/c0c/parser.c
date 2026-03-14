#include "parser.h"
#include "lexer.h"
#include <string.h>

static ASTNode* parse_expr();
static ASTNode* parse_stmt();
static ASTNode* parse_block();
static ASTNode* parse_if_stmt();
static ASTNode* parse_while_stmt();
static ASTNode* parse_for_stmt();
static ASTNode* parse_break_stmt();
static ASTNode* parse_continue_stmt();
static ASTNode* parse_unary();

static ASTNode* parse_primary() {
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
            ASTNode *n = new_node(AST_VAR);
            strcpy(n->name, name);
            if (cur_tok.type == TK_PLUSPLUS || cur_tok.type == TK_MINUSMINUS) {
                ASTNode *inc = new_node(AST_INCDEC);
                inc->op = cur_tok.type;
                inc->is_prefix = 0;
                strcpy(inc->name, name);
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
    }
    return n;
}

static ASTNode* parse_add() {
    ASTNode *n = parse_mul();
    while (cur_tok.type == TK_PLUS || cur_tok.type == TK_MINUS) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_mul(); n = p;
    }
    return n;
}

static ASTNode* parse_rel() {
    ASTNode *n = parse_add();
    while (cur_tok.type == TK_LT || cur_tok.type == TK_GT ||
           cur_tok.type == TK_LE || cur_tok.type == TK_GE) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_add(); n = p;
    }
    return n;
}

static ASTNode* parse_eq() {
    ASTNode *n = parse_rel();
    while (cur_tok.type == TK_EQ || cur_tok.type == TK_NE) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_rel(); n = p;
    }
    return n;
}

static ASTNode* parse_and() {
    ASTNode *n = parse_eq();
    while (cur_tok.type == TK_ANDAND) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_eq(); n = p;
    }
    return n;
}

static ASTNode* parse_or() {
    ASTNode *n = parse_and();
    while (cur_tok.type == TK_OROR) {
        ASTNode *p = new_node(AST_BINOP); p->op = cur_tok.type; p->left = n;
        next_token(); p->right = parse_and(); n = p;
    }
    return n;
}

static ASTNode* parse_expr() { return parse_or(); }

static ASTNode* parse_unary() {
    if (cur_tok.type == TK_MINUS || cur_tok.type == TK_NOT ||
        cur_tok.type == TK_PLUSPLUS || cur_tok.type == TK_MINUSMINUS) {
        TokenType op = cur_tok.type;
        next_token();
        ASTNode *operand = parse_unary();
        if (op == TK_PLUSPLUS || op == TK_MINUSMINUS) {
            if (!operand || operand->type != AST_VAR) error("++/-- 只能用在變數上");
            ASTNode *inc = new_node(AST_INCDEC);
            inc->op = op;
            inc->is_prefix = 1;
            strcpy(inc->name, operand->name);
            return inc;
        }
        ASTNode *n = new_node(AST_UNARY);
        n->op = op;
        n->left = operand;
        return n;
    }
    return parse_primary();
}

static ASTNode* parse_block() {
    expect(TK_LBRACE, "預期 '{'");
    ASTNode *head = NULL, *tail = NULL;
    while (cur_tok.type != TK_RBRACE && cur_tok.type != TK_EOF) {
        ASTNode *stmt = parse_stmt();
        if (!head) head = tail = stmt; else { tail->next = stmt; tail = stmt; }
    }
    expect(TK_RBRACE, "預期 '}'");
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
            int is_assign = (cur_tok.type == TK_ASSIGN || cur_tok.type == TK_PLUSEQ);
            p = saved_p; cur_tok = saved_tok;
            if (is_assign) {
                ASTNode *assign = new_node(AST_ASSIGN);
                strcpy(assign->name, cur_tok.name);
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
                strcpy(assign->name, cur_tok.name);
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
        char *saved_p = p; Token saved_tok = cur_tok;
        next_token();
        int is_assign = (cur_tok.type == TK_ASSIGN || cur_tok.type == TK_PLUSEQ);
        p = saved_p; cur_tok = saved_tok;

        if (is_assign) {
            ASTNode *n = new_node(AST_ASSIGN);
            strcpy(n->name, cur_tok.name);
            next_token();
            if (cur_tok.type == TK_ASSIGN || cur_tok.type == TK_PLUSEQ) {
                n->op = cur_tok.type;
                next_token();
            } else {
                error("預期 '=' 或 '+='");
            }
            n->right = parse_expr();
            expect(TK_SEMI, "預期 ';'");
            return n;
        } else {
            ASTNode *n = new_node(AST_EXPR_STMT);
            n->left = parse_expr();
            expect(TK_SEMI, "預期 ';'");
            return n;
        }
    }
    error("未知的陳述式 (Statement)");
    return NULL;
}

static ASTNode* parse_func() {
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
    func->left = param_head;
    func->right = body;
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
