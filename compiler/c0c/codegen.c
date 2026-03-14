#include "codegen.h"
#include "lexer.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int reg_cnt = 0;
static int label_cnt = 0;
static char string_table[100][256];
static int string_cnt = 0;
static ASTNode *current_params = NULL;
static int break_label_stack[128];
static int continue_label_stack[128];
static int loop_depth = 0;
static FILE *out_fp = NULL;

static int stmt_ends_with_return(ASTNode *node);
static int stmt_list_ends_with_return(ASTNode *node);
static int stmt_may_fallthrough(ASTNode *node);
static int stmt_list_may_fallthrough(ASTNode *node);
static char* gen_cond(ASTNode *node);

static int is_param(ASTNode *params, const char *name) {
    ASTNode *pnode = params;
    while (pnode) {
        if (strcmp(pnode->name, name) == 0) return 1;
        pnode = pnode->next;
    }
    return 0;
}

static int is_bool_op(int op) {
    return op == TK_EQ || op == TK_NE || op == TK_LE || op == TK_GE ||
           op == TK_LT || op == TK_GT || op == TK_ANDAND || op == TK_OROR;
}

static int is_bool_expr(ASTNode *node) {
    if (!node) return 0;
    if (node->type == AST_BINOP) return is_bool_op(node->op);
    if (node->type == AST_UNARY && node->op == TK_NOT) return 1;
    return 0;
}

static int stmt_ends_with_return(ASTNode *node) {
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

static int stmt_list_ends_with_return(ASTNode *node) {
    if (!node) return 0;
    ASTNode *cur = node;
    while (cur->next) cur = cur->next;
    return stmt_ends_with_return(cur);
}

static int stmt_may_fallthrough(ASTNode *node) {
    if (!node) return 1;
    if (node->type == AST_RETURN || node->type == AST_BREAK || node->type == AST_CONTINUE) return 0;
    if (node->type == AST_IF) {
        int then_ft = stmt_list_may_fallthrough(node->then_body);
        int else_ft = node->else_body ? stmt_list_may_fallthrough(node->else_body) : 1;
        return then_ft || else_ft;
    }
    return 1;
}

static int stmt_list_may_fallthrough(ASTNode *node) {
    if (!node) return 1;
    ASTNode *cur = node;
    while (cur->next) cur = cur->next;
    return stmt_may_fallthrough(cur);
}

static char* gen_expr(ASTNode *node) {
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
            fprintf(out_fp, "  %%%d = load i32, ptr %%%s.addr\n", r, node->name);
        } else {
            fprintf(out_fp, "  %%%d = load i32, ptr %%%s\n", r, node->name);
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
            if (arg->type == AST_STR) strcpy(arg_types[arg_count], "ptr");
            else strcpy(arg_types[arg_count], "i32");
            arg = arg->next;
            arg_count++;
        }
        int r = reg_cnt++;
        int is_printf = (strcmp(node->name, "printf") == 0);
        if (is_printf) fprintf(out_fp, "  %%%d = call i32 (ptr, ...) @%s(", r, node->name);
        else fprintf(out_fp, "  %%%d = call i32 @%s(", r, node->name);
        for (int i = 0; i < arg_count; i++) {
            if (i > 0) fprintf(out_fp, ", ");
            if (arg_types[i][0] == 'p') fprintf(out_fp, "ptr %s", arg_res[i]);
            else fprintf(out_fp, "i32 %s", arg_res[i]);
            free(arg_res[i]);
        }
        fprintf(out_fp, ")\n");
        sprintf(res, "%%%d", r);
        return res;
    } else if (node->type == AST_BINOP) {
        if (node->op == TK_ANDAND || node->op == TK_OROR) {
            int tmp = reg_cnt++;
            int rhs_label = label_cnt++;
            int short_label = label_cnt++;
            int end_label = label_cnt++;
            fprintf(out_fp, "  %%%d = alloca i1\n", tmp);
            char *left_cond = gen_cond(node->left);
            if (node->op == TK_ANDAND) {
                fprintf(out_fp, "  br i1 %s, label %%L%d, label %%L%d\n", left_cond, rhs_label, short_label);
            } else {
                fprintf(out_fp, "  br i1 %s, label %%L%d, label %%L%d\n", left_cond, short_label, rhs_label);
            }
            free(left_cond);

            fprintf(out_fp, "L%d:\n", rhs_label);
            char *right_cond = gen_cond(node->right);
            fprintf(out_fp, "  store i1 %s, ptr %%%d\n", right_cond, tmp);
            free(right_cond);
            fprintf(out_fp, "  br label %%L%d\n", end_label);

            fprintf(out_fp, "L%d:\n", short_label);
            fprintf(out_fp, "  store i1 %s, ptr %%%d\n", (node->op == TK_ANDAND) ? "0" : "1", tmp);
            fprintf(out_fp, "  br label %%L%d\n", end_label);

            fprintf(out_fp, "L%d:\n", end_label);
            int r = reg_cnt++;
            fprintf(out_fp, "  %%%d = load i1, ptr %%%d\n", r, tmp);
            sprintf(res, "%%%d", r);
            return res;
        }

        char *left = gen_expr(node->left);
        char *right = gen_expr(node->right);
        int r = reg_cnt++;
        if (node->op == '+') fprintf(out_fp, "  %%%d = add i32 %s, %s\n", r, left, right);
        if (node->op == '-') fprintf(out_fp, "  %%%d = sub i32 %s, %s\n", r, left, right);
        if (node->op == '*') fprintf(out_fp, "  %%%d = mul i32 %s, %s\n", r, left, right);
        if (node->op == '/') fprintf(out_fp, "  %%%d = sdiv i32 %s, %s\n", r, left, right);
        if (node->op == TK_MOD) fprintf(out_fp, "  %%%d = srem i32 %s, %s\n", r, left, right);
        if (node->op == TK_LT) fprintf(out_fp, "  %%%d = icmp slt i32 %s, %s\n", r, left, right);
        if (node->op == TK_GT) fprintf(out_fp, "  %%%d = icmp sgt i32 %s, %s\n", r, left, right);
        if (node->op == TK_LE) fprintf(out_fp, "  %%%d = icmp sle i32 %s, %s\n", r, left, right);
        if (node->op == TK_GE) fprintf(out_fp, "  %%%d = icmp sge i32 %s, %s\n", r, left, right);
        if (node->op == TK_EQ) fprintf(out_fp, "  %%%d = icmp eq i32 %s, %s\n", r, left, right);
        if (node->op == TK_NE) fprintf(out_fp, "  %%%d = icmp ne i32 %s, %s\n", r, left, right);
        free(left); free(right);
        sprintf(res, "%%%d", r);
        return res;
    } else if (node->type == AST_UNARY) {
        if (node->op == TK_NOT) {
            char *val = gen_cond(node->left);
            int r = reg_cnt++;
            fprintf(out_fp, "  %%%d = xor i1 %s, 1\n", r, val);
            free(val);
            sprintf(res, "%%%d", r);
            return res;
        } else if (node->op == TK_MINUS) {
            char *val = gen_expr(node->left);
            int r = reg_cnt++;
            fprintf(out_fp, "  %%%d = sub i32 0, %s\n", r, val);
            free(val);
            sprintf(res, "%%%d", r);
            return res;
        }
    } else if (node->type == AST_INCDEC) {
        int is_inc = (node->op == TK_PLUSPLUS);
        int r_old = reg_cnt++;
        if (is_param(current_params, node->name)) {
            fprintf(out_fp, "  %%%d = load i32, ptr %%%s.addr\n", r_old, node->name);
        } else {
            fprintf(out_fp, "  %%%d = load i32, ptr %%%s\n", r_old, node->name);
        }
        int r_new = reg_cnt++;
        if (is_inc) fprintf(out_fp, "  %%%d = add i32 %%%d, 1\n", r_new, r_old);
        else fprintf(out_fp, "  %%%d = sub i32 %%%d, 1\n", r_new, r_old);
        if (is_param(current_params, node->name)) {
            fprintf(out_fp, "  store i32 %%%d, ptr %%%s.addr\n", r_new, node->name);
        } else {
            fprintf(out_fp, "  store i32 %%%d, ptr %%%s\n", r_new, node->name);
        }
        sprintf(res, "%%%d", node->is_prefix ? r_new : r_old);
        return res;
    }
    return NULL;
}

static char* gen_cond(ASTNode *node) {
    char *val = gen_expr(node);
    if (is_bool_expr(node)) return val;
    int r = reg_cnt++;
    fprintf(out_fp, "  %%%d = icmp ne i32 %s, 0\n", r, val);
    free(val);
    char *res = malloc(64);
    sprintf(res, "%%%d", r);
    return res;
}

static void gen_stmt(ASTNode *node) {
    while (node) {
        if (node->type == AST_DECL) {
            if (is_param(current_params, node->name)) {
                fprintf(out_fp, "  %%%s.addr = alloca i32\n", node->name);
                fprintf(out_fp, "  store i32 %%%s, ptr %%%s.addr\n", node->name, node->name);
            } else {
                fprintf(out_fp, "  %%%s = alloca i32\n", node->name);
                if (node->left) {
                    char *val = gen_expr(node->left);
                    fprintf(out_fp, "  store i32 %s, ptr %%%s\n", val, node->name);
                    free(val);
                }
            }
        } else if (node->type == AST_ASSIGN) {
            if (node->op == TK_PLUSEQ) {
                char *rhs = gen_expr(node->right);
                int r_old = reg_cnt++;
                if (is_param(current_params, node->name)) {
                    fprintf(out_fp, "  %%%d = load i32, ptr %%%s.addr\n", r_old, node->name);
                } else {
                    fprintf(out_fp, "  %%%d = load i32, ptr %%%s\n", r_old, node->name);
                }
                int r_new = reg_cnt++;
                fprintf(out_fp, "  %%%d = add i32 %%%d, %s\n", r_new, r_old, rhs);
                if (is_param(current_params, node->name)) {
                    fprintf(out_fp, "  store i32 %%%d, ptr %%%s.addr\n", r_new, node->name);
                } else {
                    fprintf(out_fp, "  store i32 %%%d, ptr %%%s\n", r_new, node->name);
                }
                free(rhs);
            } else {
                char *val = gen_expr(node->right);
                if (is_param(current_params, node->name)) {
                    fprintf(out_fp, "  store i32 %s, ptr %%%s.addr\n", val, node->name);
                } else {
                    fprintf(out_fp, "  store i32 %s, ptr %%%s\n", val, node->name);
                }
                free(val);
            }
        } else if (node->type == AST_EXPR_STMT) {
            char *val = gen_expr(node->left);
            if (val) free(val);
        } else if (node->type == AST_IF) {
            char *cond_val = gen_cond(node->cond);
            int then_fall = stmt_list_may_fallthrough(node->then_body);
            int else_fall = node->else_body ? stmt_list_may_fallthrough(node->else_body) : 1;
            int need_end = then_fall || else_fall;
            int then_label = label_cnt++;
            int else_label = node->else_body ? label_cnt++ : (need_end ? label_cnt++ : label_cnt++);
            int end_label = need_end ? label_cnt++ : -1;
            if (!node->else_body) else_label = end_label;

            fprintf(out_fp, "  br i1 %s, label %%L%d, label %%L%d\n", cond_val, then_label, else_label);
            free(cond_val);

            fprintf(out_fp, "L%d:\n", then_label);
            gen_stmt(node->then_body);
            if (then_fall && need_end) {
                fprintf(out_fp, "  br label %%L%d\n", end_label);
            }

            if (node->else_body) {
                fprintf(out_fp, "L%d:\n", else_label);
                gen_stmt(node->else_body);
                if (else_fall && need_end) {
                    fprintf(out_fp, "  br label %%L%d\n", end_label);
                }
            }

            if (need_end) {
                fprintf(out_fp, "L%d:\n", end_label);
            }
        } else if (node->type == AST_WHILE) {
            int cond_label = label_cnt++;
            int body_label = label_cnt++;
            int end_label = label_cnt++;
            fprintf(out_fp, "  br label %%L%d\n", cond_label);

            fprintf(out_fp, "L%d:\n", cond_label);
            char *cond_val = gen_cond(node->cond);
            fprintf(out_fp, "  br i1 %s, label %%L%d, label %%L%d\n", cond_val, body_label, end_label);
            free(cond_val);

            fprintf(out_fp, "L%d:\n", body_label);
            break_label_stack[loop_depth] = end_label;
            continue_label_stack[loop_depth] = cond_label;
            loop_depth++;
            gen_stmt(node->body);
            if (stmt_list_may_fallthrough(node->body)) {
                fprintf(out_fp, "  br label %%L%d\n", cond_label);
            }
            loop_depth--;

            fprintf(out_fp, "L%d:\n", end_label);
        } else if (node->type == AST_FOR) {
            if (node->init) {
                if (node->init->type == AST_DECL) gen_stmt(node->init);
                else if (node->init->type == AST_ASSIGN) gen_stmt(node->init);
                else if (node->init->type == AST_EXPR_STMT) {
                    char *val = gen_expr(node->init->left);
                    if (val) free(val);
                }
            }

            int cond_label = label_cnt++;
            int body_label = label_cnt++;
            int update_label = label_cnt++;
            int end_label = label_cnt++;

            fprintf(out_fp, "  br label %%L%d\n", cond_label);

            fprintf(out_fp, "L%d:\n", cond_label);
            if (node->cond) {
                char *cond_val = gen_cond(node->cond);
                fprintf(out_fp, "  br i1 %s, label %%L%d, label %%L%d\n", cond_val, body_label, end_label);
                free(cond_val);
            } else {
                fprintf(out_fp, "  br label %%L%d\n", body_label);
            }

            fprintf(out_fp, "L%d:\n", body_label);
            break_label_stack[loop_depth] = end_label;
            continue_label_stack[loop_depth] = update_label;
            loop_depth++;
            gen_stmt(node->body);
            if (stmt_list_may_fallthrough(node->body)) {
                fprintf(out_fp, "  br label %%L%d\n", update_label);
            }
            loop_depth--;

            fprintf(out_fp, "L%d:\n", update_label);
            if (node->update) {
                if (node->update->type == AST_ASSIGN) gen_stmt(node->update);
                else {
                    char *val = gen_expr(node->update);
                    if (val) free(val);
                }
            }
            fprintf(out_fp, "  br label %%L%d\n", cond_label);

            fprintf(out_fp, "L%d:\n", end_label);
        } else if (node->type == AST_BREAK) {
            if (loop_depth == 0) error("break 不在迴圈內");
            fprintf(out_fp, "  br label %%L%d\n", break_label_stack[loop_depth - 1]);
        } else if (node->type == AST_CONTINUE) {
            if (loop_depth == 0) error("continue 不在迴圈內");
            fprintf(out_fp, "  br label %%L%d\n", continue_label_stack[loop_depth - 1]);
        } else if (node->type == AST_RETURN) {
            char *val = gen_expr(node->left);
            fprintf(out_fp, "  ret i32 %s\n", val);
            free(val);
        }
        node = node->next;
    }
}

void gen_llvm_ir(ASTNode *funcs, FILE *out) {
    out_fp = out;
    fprintf(out_fp, "; ModuleID = 'c0c'\n");
    ASTNode *func = funcs;
    while (func) {
        fprintf(out_fp, "define i32 @%s(", func->name);
        ASTNode *param = func->left;
        int first = 1;
        while (param) {
            if (!first) fprintf(out_fp, ", ");
            fprintf(out_fp, "i32 %%%s", param->name);
            first = 0;
            param = param->next;
        }
        fprintf(out_fp, ") {\n");
        fprintf(out_fp, "entry:\n");
        reg_cnt = 0;
        current_params = func->left;
        ASTNode *pnode = current_params;
        while (pnode) {
            gen_stmt(pnode);
            pnode = pnode->next;
        }
        gen_stmt(func->right);
        fprintf(out_fp, "}\n\n");
        func = func->next;
    }

    for (int i = 0; i < string_cnt; i++) {
        char llvm_str[512] = {0};
        int len = 0;
        char *p = string_table[i];
        while (*p) {
            if (*p == '\\' && *(p+1) == 'n') {
                strcat(llvm_str, "\\0A");
                len++; p += 2;
            } else {
                int l = strlen(llvm_str);
                llvm_str[l] = *p; llvm_str[l+1] = '\0';
                len++; p++;
            }
        }
        strcat(llvm_str, "\\00"); len++;
        fprintf(out_fp, "@.str.%d = private unnamed_addr constant [%d x i8] c\"%s\", align 1\n", i, len, llvm_str);
    }

    fprintf(out_fp, "declare i32 @printf(ptr, ...)\n");
}
