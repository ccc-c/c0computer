#include "codegen.h"
#include "lexer.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum {
    VT_I1,
    VT_I8,
    VT_I32,
    VT_PTR
} ValueType;

typedef struct {
    char *reg;
    ValueType vt;
} Value;

typedef struct {
    char name[64];
    CType ret;
    CType params[16];
    int param_cnt;
} FuncSig;

static int reg_cnt = 0;
static int label_cnt = 0;
static char string_table[100][256];
static int string_cnt = 0;
static ASTNode *current_params = NULL;
static CType current_ret_ty = TY_INT;
static int break_label_stack[128];
static int continue_label_stack[128];
static int loop_depth = 0;
static int switch_break_stack[128];
static int switch_depth = 0;
static FILE *out_fp = NULL;
static FuncSig func_sigs[128];
static int func_sig_cnt = 0;
static int var_id = 0;

typedef struct {
    char name[64];
    char ir[64];
    CType ty;
    int array_len;
    int struct_id;
} VarSlot;

static VarSlot var_slots[512];
static int var_cnt = 0;
static int scope_marks[128];
static int scope_depth = 0;

static int is_ptr(CType ty) { return ty == TY_INT_PTR || ty == TY_CHAR_PTR || ty == TY_STRUCT_PTR; }
static CType base_of(CType ty) {
    if (ty == TY_CHAR_PTR) return TY_CHAR;
    if (ty == TY_INT_PTR) return TY_INT;
    if (ty == TY_STRUCT_PTR) return TY_STRUCT;
    return TY_INT;
}
static const char* llvm_type(CType ty) {
    if (ty == TY_CHAR) return "i8";
    if (ty == TY_INT) return "i32";
    if (ty == TY_VOID) return "void";
    return "ptr";
}
static const char* llvm_elem_type(CType ty) {
    CType base = is_ptr(ty) ? base_of(ty) : ty;
    if (base == TY_CHAR) return "i8";
    if (base == TY_INT) return "i32";
    return "i8";
}

static int stmt_ends_with_return(ASTNode *node);
static int stmt_list_ends_with_return(ASTNode *node);
static int stmt_may_fallthrough(ASTNode *node);
static int stmt_list_may_fallthrough(ASTNode *node);
static Value gen_cond(ASTNode *node);
static Value gen_expr(ASTNode *node);
static Value gen_lvalue_addr(ASTNode *node);

static int is_param(ASTNode *params, const char *name) {
    ASTNode *pnode = params;
    while (pnode) {
        if (strcmp(pnode->name, name) == 0) return 1;
        pnode = pnode->next;
    }
    return 0;
}

static FuncSig* find_func_sig(const char *name) {
    for (int i = 0; i < func_sig_cnt; i++) {
        if (strcmp(func_sigs[i].name, name) == 0) return &func_sigs[i];
    }
    return NULL;
}

static void var_push_scope(void) {
    scope_marks[scope_depth++] = var_cnt;
}

static void var_pop_scope(void) {
    if (scope_depth == 0) return;
    var_cnt = scope_marks[--scope_depth];
}

static void var_add(const char *name, const char *ir, CType ty, int array_len, int struct_id) {
    if (var_cnt >= 512) error("變數表已滿");
    strcpy(var_slots[var_cnt].name, name);
    strcpy(var_slots[var_cnt].ir, ir);
    var_slots[var_cnt].ty = ty;
    var_slots[var_cnt].array_len = array_len;
    var_slots[var_cnt].struct_id = struct_id;
    var_cnt++;
}

static VarSlot* var_find(const char *name) {
    for (int i = var_cnt - 1; i >= 0; i--) {
        if (strcmp(var_slots[i].name, name) == 0) return &var_slots[i];
    }
    error("找不到變數宣告");
    return NULL;
}

static int struct_size(int struct_id) {
    if (struct_id < 0 || struct_id >= g_struct_def_cnt) error("struct id 錯誤");
    return g_struct_defs[struct_id].size;
}

static int type_size(CType ty, int struct_id) {
    if (ty == TY_CHAR) return 1;
    if (ty == TY_INT) return 4;
    if (ty == TY_INT_PTR || ty == TY_CHAR_PTR || ty == TY_STRUCT_PTR) return 8;
    if (ty == TY_STRUCT) return struct_size(struct_id);
    return 0;
}

static int elem_size(CType ptr_ty, int struct_id) {
    if (!is_ptr(ptr_ty)) return 0;
    return type_size(base_of(ptr_ty), struct_id);
}

static void build_func_sigs(ASTNode *funcs) {
    func_sig_cnt = 0;
    ASTNode *f = funcs;
    while (f) {
        if (func_sig_cnt >= 128) error("函式表已滿");
        FuncSig *sig = &func_sigs[func_sig_cnt++];
        strcpy(sig->name, f->name);
        sig->ret = f->ty;
        sig->param_cnt = 0;
        ASTNode *p = f->left;
        while (p && sig->param_cnt < 16) {
            sig->params[sig->param_cnt++] = p->ty;
            p = p->next;
        }
        f = f->next;
    }
}

static int func_has_def(ASTNode *funcs, const char *name) {
    ASTNode *f = funcs;
    while (f) {
        if (!f->is_decl && strcmp(f->name, name) == 0) return 1;
        f = f->next;
    }
    return 0;
}

static int stmt_ends_with_return(ASTNode *node) {
    if (!node) return 0;
    if (node->type == AST_RETURN) return 1;
    if (node->type == AST_BREAK || node->type == AST_CONTINUE) return 1;
    if (node->type == AST_CASE) return stmt_list_ends_with_return(node->left);
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
    if (node->type == AST_CASE) return stmt_list_may_fallthrough(node->left);
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

static Value value_from_reg(char *reg, ValueType vt) {
    Value v = {reg, vt};
    return v;
}

static Value to_i1(Value v) {
    if (v.vt == VT_I1) return v;
    if (v.reg == NULL) error("使用了 void 表達式");
    int r = reg_cnt++;
    if (v.vt == VT_I8) {
        fprintf(out_fp, "  %%%d = icmp ne i8 %s, 0\n", r, v.reg);
    } else if (v.vt == VT_PTR) {
        fprintf(out_fp, "  %%%d = icmp ne ptr %s, null\n", r, v.reg);
    } else {
        fprintf(out_fp, "  %%%d = icmp ne i32 %s, 0\n", r, v.reg);
    }
    free(v.reg);
    char *res = malloc(64);
    sprintf(res, "%%%d", r);
    return value_from_reg(res, VT_I1);
}

static Value to_i32(Value v) {
    if (v.vt == VT_I32) return v;
    if (v.reg == NULL) error("使用了 void 表達式");
    int r = reg_cnt++;
    if (v.vt == VT_I8) {
        fprintf(out_fp, "  %%%d = sext i8 %s to i32\n", r, v.reg);
    } else if (v.vt == VT_I1) {
        fprintf(out_fp, "  %%%d = zext i1 %s to i32\n", r, v.reg);
    } else {
        error("不支援的型別轉換");
    }
    free(v.reg);
    char *res = malloc(64);
    sprintf(res, "%%%d", r);
    return value_from_reg(res, VT_I32);
}

static Value to_i8(Value v) {
    if (v.vt == VT_I8) return v;
    if (v.reg == NULL) error("使用了 void 表達式");
    int r = reg_cnt++;
    if (v.vt == VT_I32) {
        fprintf(out_fp, "  %%%d = trunc i32 %s to i8\n", r, v.reg);
    } else if (v.vt == VT_I1) {
        fprintf(out_fp, "  %%%d = zext i1 %s to i8\n", r, v.reg);
    } else {
        error("不支援的型別轉換");
    }
    free(v.reg);
    char *res = malloc(64);
    sprintf(res, "%%%d", r);
    return value_from_reg(res, VT_I8);
}

static Value gen_lvalue_addr(ASTNode *node) {
    if (node->type == AST_VAR) {
        VarSlot *slot = var_find(node->name);
        if (slot->array_len > 0) {
            int r = reg_cnt++;
            if (base_of(slot->ty) == TY_STRUCT) {
                int total = slot->array_len * struct_size(slot->struct_id);
                fprintf(out_fp, "  %%%d = getelementptr [%d x i8], ptr %%%s, i32 0, i32 0\n",
                        r, total, slot->ir);
            } else {
                fprintf(out_fp, "  %%%d = getelementptr [%d x %s], ptr %%%s, i32 0, i32 0\n",
                        r, slot->array_len, llvm_elem_type(slot->ty), slot->ir);
            }
            char *res = malloc(64);
            sprintf(res, "%%%d", r);
            return value_from_reg(res, VT_PTR);
        }
        char *res = malloc(64);
        sprintf(res, "%%%s", slot->ir);
        return value_from_reg(res, VT_PTR);
    }
    if (node->type == AST_DEREF) {
        return gen_expr(node->left);
    }
    if (node->type == AST_INDEX) {
        ASTNode *base = node->left;
        Value base_ptr;
        if (base->type == AST_VAR) {
            VarSlot *slot = var_find(base->name);
            if (slot->array_len > 0) {
                int r = reg_cnt++;
                if (base_of(slot->ty) == TY_STRUCT) {
                    int total = slot->array_len * struct_size(slot->struct_id);
                    fprintf(out_fp, "  %%%d = getelementptr [%d x i8], ptr %%%s, i32 0, i32 0\n",
                            r, total, slot->ir);
                } else {
                    fprintf(out_fp, "  %%%d = getelementptr [%d x %s], ptr %%%s, i32 0, i32 0\n",
                            r, slot->array_len, llvm_elem_type(slot->ty), slot->ir);
                }
                char *res = malloc(64);
                sprintf(res, "%%%d", r);
                base_ptr = value_from_reg(res, VT_PTR);
            } else {
                base_ptr = gen_expr(base);
            }
        } else {
            base_ptr = gen_expr(base);
        }
        Value idx = to_i32(gen_expr(node->right));
        int esz = elem_size(base->ty, base->struct_id);
        if (esz <= 0) esz = 1;
        if (esz != 1) {
            int r_mul = reg_cnt++;
            fprintf(out_fp, "  %%%d = mul i32 %s, %d\n", r_mul, idx.reg, esz);
            free(idx.reg);
            char *mul_reg = malloc(64);
            sprintf(mul_reg, "%%%d", r_mul);
            idx = value_from_reg(mul_reg, VT_I32);
        }
        int r = reg_cnt++;
        fprintf(out_fp, "  %%%d = getelementptr i8, ptr %s, i32 %s\n", r, base_ptr.reg, idx.reg);
        free(base_ptr.reg);
        free(idx.reg);
        char *res = malloc(64);
        sprintf(res, "%%%d", r);
        return value_from_reg(res, VT_PTR);
    }
    if (node->type == AST_MEMBER) {
        Value base_ptr;
        if (node->op) {
            base_ptr = gen_expr(node->left);
        } else {
            base_ptr = gen_lvalue_addr(node->left);
        }
        int r = reg_cnt++;
        fprintf(out_fp, "  %%%d = getelementptr i8, ptr %s, i32 %d\n", r, base_ptr.reg, node->val);
        free(base_ptr.reg);
        char *res = malloc(64);
        sprintf(res, "%%%d", r);
        return value_from_reg(res, VT_PTR);
    }
    error("不支援的取址");
    return value_from_reg(NULL, VT_PTR);
}

static Value gen_expr(ASTNode *node) {
    if (node->type == AST_NUM) {
        char *res = malloc(64);
        sprintf(res, "%d", node->val);
        return value_from_reg(res, VT_I32);
    } else if (node->type == AST_STR) {
        int id = string_cnt++;
        strcpy(string_table[id], node->str_val);
        int len = (int)strlen(node->str_val) + 1;
        int r = reg_cnt++;
        fprintf(out_fp, "  %%%d = getelementptr [%d x i8], ptr @.str.%d, i32 0, i32 0\n",
                r, len, id);
        char *res = malloc(64);
        sprintf(res, "%%%d", r);
        return value_from_reg(res, VT_PTR);
    } else if (node->type == AST_VAR) {
        VarSlot *slot = var_find(node->name);
        if (slot->array_len > 0) {
            int r = reg_cnt++;
            if (base_of(slot->ty) == TY_STRUCT) {
                int total = slot->array_len * struct_size(slot->struct_id);
                fprintf(out_fp, "  %%%d = getelementptr [%d x i8], ptr %%%s, i32 0, i32 0\n",
                        r, total, slot->ir);
            } else {
                fprintf(out_fp, "  %%%d = getelementptr [%d x %s], ptr %%%s, i32 0, i32 0\n",
                        r, slot->array_len, llvm_elem_type(slot->ty), slot->ir);
            }
            char *res = malloc(64);
            sprintf(res, "%%%d", r);
            return value_from_reg(res, VT_PTR);
        }
        if (slot->ty == TY_STRUCT) {
            char *res = malloc(64);
            sprintf(res, "%%%s", slot->ir);
            return value_from_reg(res, VT_PTR);
        }
        int r = reg_cnt++;
        const char *ty = llvm_type(slot->ty);
        fprintf(out_fp, "  %%%d = load %s, ptr %%%s\n", r, ty, slot->ir);
        char *res = malloc(64);
        sprintf(res, "%%%d", r);
        if (is_ptr(slot->ty)) return value_from_reg(res, VT_PTR);
        return value_from_reg(res, (slot->ty == TY_CHAR) ? VT_I8 : VT_I32);
    } else if (node->type == AST_CALL) {
        Value raw_vals[10];
        Value final_vals[10];
        ValueType arg_types[10];
        int arg_count = 0;
        ASTNode *arg = node->left;
        while (arg) {
            raw_vals[arg_count] = gen_expr(arg);
            if (arg->type == AST_STR || is_ptr(arg->ty)) arg_types[arg_count] = VT_PTR;
            else arg_types[arg_count] = VT_I32;
            arg = arg->next;
            arg_count++;
        }
        int is_printf = (strcmp(node->name, "printf") == 0);
        FuncSig *sig = find_func_sig(node->name);
        const char *ret_ty = (sig && sig->ret == TY_VOID) ? "void" :
                             (sig && is_ptr(sig->ret)) ? "ptr" :
                             (sig && sig->ret == TY_CHAR) ? "i8" : "i32";
        for (int i = 0; i < arg_count; i++) {
            if (arg_types[i] == VT_PTR) {
                final_vals[i] = raw_vals[i];
            } else if (sig && i < sig->param_cnt && is_ptr(sig->params[i])) {
                error("指標參數需要 ptr");
            } else if (sig && i < sig->param_cnt && sig->params[i] == TY_CHAR) {
                final_vals[i] = to_i8(raw_vals[i]);
            } else {
                final_vals[i] = to_i32(raw_vals[i]);
            }
        }

        int r = -1;
        if (is_printf) {
            r = reg_cnt++;
            fprintf(out_fp, "  %%%d = call i32 (ptr, ...) @%s(", r, node->name);
        } else if (sig && sig->ret == TY_VOID) {
            fprintf(out_fp, "  call void @%s(", node->name);
        } else {
            r = reg_cnt++;
            fprintf(out_fp, "  %%%d = call %s @%s(", r, ret_ty, node->name);
        }
        for (int i = 0; i < arg_count; i++) {
            if (i > 0) fprintf(out_fp, ", ");
            if (arg_types[i] == VT_PTR) {
                fprintf(out_fp, "ptr %s", final_vals[i].reg);
                free(final_vals[i].reg);
            } else {
                if (sig && i < sig->param_cnt && sig->params[i] == TY_CHAR) {
                    fprintf(out_fp, "i8 %s", final_vals[i].reg);
                    free(final_vals[i].reg);
                } else {
                    fprintf(out_fp, "i32 %s", final_vals[i].reg);
                    free(final_vals[i].reg);
                }
            }
        }
        fprintf(out_fp, ")\n");
        if (!is_printf && sig && sig->ret == TY_VOID) {
            return value_from_reg(NULL, VT_I32);
        }
        char *res = malloc(64);
        sprintf(res, "%%%d", r);
        if (!is_printf && sig && is_ptr(sig->ret)) return value_from_reg(res, VT_PTR);
        if (!is_printf && sig && sig->ret == TY_CHAR) return value_from_reg(res, VT_I8);
        return value_from_reg(res, VT_I32);
    } else if (node->type == AST_ADDR) {
        return gen_lvalue_addr(node->left);
    } else if (node->type == AST_DEREF) {
        Value ptr = gen_expr(node->left);
        if (node->ty == TY_STRUCT) {
            return ptr;
        }
        int r = reg_cnt++;
        fprintf(out_fp, "  %%%d = load %s, ptr %s\n", r, llvm_elem_type(node->ty), ptr.reg);
        free(ptr.reg);
        char *res = malloc(64);
        sprintf(res, "%%%d", r);
        return value_from_reg(res, (node->ty == TY_CHAR) ? VT_I8 : VT_I32);
    } else if (node->type == AST_INDEX) {
        Value addr = gen_lvalue_addr(node);
        if (node->ty == TY_STRUCT) {
            return addr;
        }
        int r = reg_cnt++;
        fprintf(out_fp, "  %%%d = load %s, ptr %s\n", r, llvm_elem_type(node->ty), addr.reg);
        free(addr.reg);
        char *res = malloc(64);
        sprintf(res, "%%%d", r);
        return value_from_reg(res, (node->ty == TY_CHAR) ? VT_I8 : VT_I32);
    } else if (node->type == AST_MEMBER) {
        Value addr = gen_lvalue_addr(node);
        if (node->ty == TY_STRUCT) {
            return addr;
        }
        int r = reg_cnt++;
        fprintf(out_fp, "  %%%d = load %s, ptr %s\n", r, llvm_elem_type(node->ty), addr.reg);
        free(addr.reg);
        char *res = malloc(64);
        sprintf(res, "%%%d", r);
        return value_from_reg(res, (node->ty == TY_CHAR) ? VT_I8 : VT_I32);
    } else if (node->type == AST_BINOP) {
        if (node->op == TK_ANDAND || node->op == TK_OROR) {
            int tmp = reg_cnt++;
            int rhs_label = label_cnt++;
            int short_label = label_cnt++;
            int end_label = label_cnt++;
            fprintf(out_fp, "  %%%d = alloca i1\n", tmp);
            Value left_cond = gen_cond(node->left);
            if (node->op == TK_ANDAND) {
                fprintf(out_fp, "  br i1 %s, label %%L%d, label %%L%d\n", left_cond.reg, rhs_label, short_label);
            } else {
                fprintf(out_fp, "  br i1 %s, label %%L%d, label %%L%d\n", left_cond.reg, short_label, rhs_label);
            }
            free(left_cond.reg);

            fprintf(out_fp, "L%d:\n", rhs_label);
            Value right_cond = gen_cond(node->right);
            fprintf(out_fp, "  store i1 %s, ptr %%%d\n", right_cond.reg, tmp);
            free(right_cond.reg);
            fprintf(out_fp, "  br label %%L%d\n", end_label);

            fprintf(out_fp, "L%d:\n", short_label);
            fprintf(out_fp, "  store i1 %s, ptr %%%d\n", (node->op == TK_ANDAND) ? "0" : "1", tmp);
            fprintf(out_fp, "  br label %%L%d\n", end_label);

            fprintf(out_fp, "L%d:\n", end_label);
            int r = reg_cnt++;
            fprintf(out_fp, "  %%%d = load i1, ptr %%%d\n", r, tmp);
            char *res = malloc(64);
            sprintf(res, "%%%d", r);
            return value_from_reg(res, VT_I1);
        }

        if ((node->op == TK_EQ || node->op == TK_NE) &&
            (is_ptr(node->left->ty) || is_ptr(node->right->ty))) {
            Value l = gen_expr(node->left);
            Value r;
            if (is_ptr(node->left->ty) && is_ptr(node->right->ty)) {
                if (node->left->ty != node->right->ty ||
                    (node->left->ty == TY_STRUCT_PTR && node->left->struct_id != node->right->struct_id)) {
                    error("指標比較型別不相容");
                }
                r = gen_expr(node->right);
            } else {
                ASTNode *other = is_ptr(node->left->ty) ? node->right : node->left;
                if (other->type == AST_NUM && other->val == 0) {
                    char *res = malloc(16);
                    strcpy(res, "null");
                    r = value_from_reg(res, VT_PTR);
                } else {
                    error("指標只能與 0 或指標比較");
                }
            }
            int rcmp = reg_cnt++;
            fprintf(out_fp, "  %%%d = icmp %s ptr %s, %s\n", rcmp,
                    (node->op == TK_EQ) ? "eq" : "ne", l.reg, r.reg);
            free(l.reg);
            free(r.reg);
            char *res = malloc(64);
            sprintf(res, "%%%d", rcmp);
            return value_from_reg(res, VT_I1);
        }

        if ((node->op == TK_LT || node->op == TK_GT || node->op == TK_LE || node->op == TK_GE) &&
            (is_ptr(node->left->ty) || is_ptr(node->right->ty))) {
            if (!is_ptr(node->left->ty) || !is_ptr(node->right->ty)) {
                error("指標只能與指標比較");
            }
            if (node->left->ty != node->right->ty ||
                (node->left->ty == TY_STRUCT_PTR && node->left->struct_id != node->right->struct_id)) {
                error("指標比較型別不相容");
            }
            Value l = gen_expr(node->left);
            Value r = gen_expr(node->right);
            int rl = reg_cnt++;
            int rr = reg_cnt++;
            fprintf(out_fp, "  %%%d = ptrtoint ptr %s to i64\n", rl, l.reg);
            fprintf(out_fp, "  %%%d = ptrtoint ptr %s to i64\n", rr, r.reg);
            int rcmp = reg_cnt++;
            const char *op = (node->op == TK_LT) ? "slt" :
                             (node->op == TK_LE) ? "sle" :
                             (node->op == TK_GT) ? "sgt" : "sge";
            fprintf(out_fp, "  %%%d = icmp %s i64 %%%d, %%%d\n", rcmp, op, rl, rr);
            free(l.reg);
            free(r.reg);
            char *res = malloc(64);
            sprintf(res, "%%%d", rcmp);
            return value_from_reg(res, VT_I1);
        }

        if ((node->op == TK_PLUS || node->op == TK_MINUS) &&
            (is_ptr(node->left->ty) || is_ptr(node->right->ty))) {
            if (is_ptr(node->left->ty) && is_ptr(node->right->ty)) {
                if (node->op != TK_MINUS) error("不支援指標相加");
                if (node->left->ty != node->right->ty ||
                    (node->left->ty == TY_STRUCT_PTR && node->left->struct_id != node->right->struct_id)) {
                    error("指標相減型別不相容");
                }
                Value l = gen_expr(node->left);
                Value r = gen_expr(node->right);
                int rl = reg_cnt++;
                int rr = reg_cnt++;
                fprintf(out_fp, "  %%%d = ptrtoint ptr %s to i64\n", rl, l.reg);
                fprintf(out_fp, "  %%%d = ptrtoint ptr %s to i64\n", rr, r.reg);
                int rdiff = reg_cnt++;
                fprintf(out_fp, "  %%%d = sub i64 %%%d, %%%d\n", rdiff, rl, rr);
                int esz = elem_size(node->left->ty, node->left->struct_id);
                int rdiv = rdiff;
                if (esz > 1) {
                    rdiv = reg_cnt++;
                    fprintf(out_fp, "  %%%d = sdiv i64 %%%d, %d\n", rdiv, rdiff, esz);
                }
                int rtr = reg_cnt++;
                fprintf(out_fp, "  %%%d = trunc i64 %%%d to i32\n", rtr, rdiv);
                free(l.reg);
                free(r.reg);
                char *res = malloc(64);
                sprintf(res, "%%%d", rtr);
                return value_from_reg(res, VT_I32);
            } else {
                ASTNode *ptr_node = is_ptr(node->left->ty) ? node->left : node->right;
                ASTNode *int_node = is_ptr(node->left->ty) ? node->right : node->left;
                Value base = gen_expr(ptr_node);
                Value idx = to_i32(gen_expr(int_node));
                if (node->op == TK_MINUS && is_ptr(node->left->ty)) {
                    int rneg = reg_cnt++;
                    fprintf(out_fp, "  %%%d = sub i32 0, %s\n", rneg, idx.reg);
                    free(idx.reg);
                    char *neg = malloc(64);
                    sprintf(neg, "%%%d", rneg);
                    idx = value_from_reg(neg, VT_I32);
                }
                int esz = elem_size(ptr_node->ty, ptr_node->struct_id);
                if (esz > 1) {
                    int r_mul = reg_cnt++;
                    fprintf(out_fp, "  %%%d = mul i32 %s, %d\n", r_mul, idx.reg, esz);
                    free(idx.reg);
                    char *mul = malloc(64);
                    sprintf(mul, "%%%d", r_mul);
                    idx = value_from_reg(mul, VT_I32);
                }
                int r = reg_cnt++;
                fprintf(out_fp, "  %%%d = getelementptr i8, ptr %s, i32 %s\n",
                        r, base.reg, idx.reg);
                free(base.reg);
                free(idx.reg);
                char *res = malloc(64);
                sprintf(res, "%%%d", r);
                return value_from_reg(res, VT_PTR);
            }
        }

        Value left = to_i32(gen_expr(node->left));
        Value right = to_i32(gen_expr(node->right));
        int r = reg_cnt++;
        if (node->op == '+') fprintf(out_fp, "  %%%d = add i32 %s, %s\n", r, left.reg, right.reg);
        if (node->op == '-') fprintf(out_fp, "  %%%d = sub i32 %s, %s\n", r, left.reg, right.reg);
        if (node->op == '*') fprintf(out_fp, "  %%%d = mul i32 %s, %s\n", r, left.reg, right.reg);
        if (node->op == '/') fprintf(out_fp, "  %%%d = sdiv i32 %s, %s\n", r, left.reg, right.reg);
        if (node->op == TK_MOD) fprintf(out_fp, "  %%%d = srem i32 %s, %s\n", r, left.reg, right.reg);
        if (node->op == TK_LT) fprintf(out_fp, "  %%%d = icmp slt i32 %s, %s\n", r, left.reg, right.reg);
        if (node->op == TK_GT) fprintf(out_fp, "  %%%d = icmp sgt i32 %s, %s\n", r, left.reg, right.reg);
        if (node->op == TK_LE) fprintf(out_fp, "  %%%d = icmp sle i32 %s, %s\n", r, left.reg, right.reg);
        if (node->op == TK_GE) fprintf(out_fp, "  %%%d = icmp sge i32 %s, %s\n", r, left.reg, right.reg);
        if (node->op == TK_EQ) fprintf(out_fp, "  %%%d = icmp eq i32 %s, %s\n", r, left.reg, right.reg);
        if (node->op == TK_NE) fprintf(out_fp, "  %%%d = icmp ne i32 %s, %s\n", r, left.reg, right.reg);
        free(left.reg);
        free(right.reg);
        char *res = malloc(64);
        sprintf(res, "%%%d", r);
        if (node->op == TK_LT || node->op == TK_GT || node->op == TK_LE || node->op == TK_GE ||
            node->op == TK_EQ || node->op == TK_NE) {
            return value_from_reg(res, VT_I1);
        }
        return value_from_reg(res, VT_I32);
    } else if (node->type == AST_UNARY) {
        if (node->op == TK_NOT) {
            Value val = gen_cond(node->left);
            int r = reg_cnt++;
            fprintf(out_fp, "  %%%d = xor i1 %s, 1\n", r, val.reg);
            free(val.reg);
            char *res = malloc(64);
            sprintf(res, "%%%d", r);
            return value_from_reg(res, VT_I1);
        } else if (node->op == TK_MINUS) {
            Value val = to_i32(gen_expr(node->left));
            int r = reg_cnt++;
            fprintf(out_fp, "  %%%d = sub i32 0, %s\n", r, val.reg);
            free(val.reg);
            char *res = malloc(64);
            sprintf(res, "%%%d", r);
            return value_from_reg(res, VT_I32);
        }
    } else if (node->type == AST_SIZEOF) {
        char *res = malloc(64);
        sprintf(res, "%d", node->val);
        return value_from_reg(res, VT_I32);
    } else if (node->type == AST_INCDEC) {
        int is_inc = (node->op == TK_PLUSPLUS);
        VarSlot *slot = var_find(node->name);
        int r_old = reg_cnt++;
        const char *ty = llvm_type(slot->ty);
        fprintf(out_fp, "  %%%d = load %s, ptr %%%s\n", r_old, ty, slot->ir);
        char *old_reg = malloc(64);
        sprintf(old_reg, "%%%d", r_old);
        Value old_val = value_from_reg(old_reg, (slot->ty == TY_CHAR) ? VT_I8 : VT_I32);
        Value old_i32 = to_i32(value_from_reg(strdup(old_reg), old_val.vt));
        int r_new = reg_cnt++;
        if (is_inc) fprintf(out_fp, "  %%%d = add i32 %s, 1\n", r_new, old_i32.reg);
        else fprintf(out_fp, "  %%%d = sub i32 %s, 1\n", r_new, old_i32.reg);
        free(old_i32.reg);
        char *new_reg = malloc(64);
        sprintf(new_reg, "%%%d", r_new);
        Value new_val = value_from_reg(new_reg, VT_I32);
        Value store_val = (slot->ty == TY_CHAR) ? to_i8(new_val) : new_val;
        fprintf(out_fp, "  store %s %s, ptr %%%s\n", llvm_type(slot->ty), store_val.reg, slot->ir);
        if (node->is_prefix) {
            return value_from_reg(store_val.reg, (slot->ty == TY_CHAR) ? VT_I8 : VT_I32);
        }
        free(store_val.reg);
        return value_from_reg(old_val.reg, old_val.vt);
    }
    error("未知的表達式");
    return value_from_reg(NULL, VT_I32);
}

static Value gen_cond(ASTNode *node) {
    Value val = gen_expr(node);
    if (val.vt == VT_I1) return val;
    return to_i1(val);
}

static void gen_stmt(ASTNode *node) {
    while (node) {
        if (node->type == AST_DECL) {
            const char *llvm_ty = llvm_type(node->ty);
            char ir_name[64];
            snprintf(ir_name, sizeof(ir_name), "v%d", var_id++);
            var_add(node->name, ir_name, node->ty, node->array_len, node->struct_id);
            if (node->array_len > 0) {
                if (base_of(node->ty) == TY_STRUCT) {
                    int total = node->array_len * struct_size(node->struct_id);
                    fprintf(out_fp, "  %%%s = alloca [%d x i8]\n", ir_name, total);
                    if (node->init_kind != 0) error("不支援 struct 陣列初始化");
                } else {
                    fprintf(out_fp, "  %%%s = alloca [%d x %s]\n", ir_name, node->array_len, llvm_elem_type(node->ty));
                    if (node->init_kind == 2) {
                        int idx = 0;
                        ASTNode *cur = node->left;
                        while (cur && idx < node->array_len) {
                            Value val = gen_expr(cur);
                            Value store_val = (base_of(node->ty) == TY_CHAR) ? to_i8(val) : to_i32(val);
                            int r = reg_cnt++;
                            fprintf(out_fp, "  %%%d = getelementptr [%d x %s], ptr %%%s, i32 0, i32 %d\n",
                                    r, node->array_len, llvm_elem_type(node->ty), ir_name, idx);
                            fprintf(out_fp, "  store %s %s, ptr %%%d\n",
                                    (base_of(node->ty) == TY_CHAR) ? "i8" : "i32", store_val.reg, r);
                            free(store_val.reg);
                            cur = cur->next;
                            idx++;
                        }
                        for (int i = idx; i < node->array_len; i++) {
                            int r = reg_cnt++;
                            fprintf(out_fp, "  %%%d = getelementptr [%d x %s], ptr %%%s, i32 0, i32 %d\n",
                                    r, node->array_len, llvm_elem_type(node->ty), ir_name, i);
                            fprintf(out_fp, "  store %s 0, ptr %%%d\n",
                                    (base_of(node->ty) == TY_CHAR) ? "i8" : "i32", r);
                        }
                    } else if (node->init_kind == 3) {
                        int len = (int)strlen(node->str_val);
                        int limit = node->array_len;
                        for (int i = 0; i < limit; i++) {
                            int ch = (i < len) ? (unsigned char)node->str_val[i] : 0;
                            if (i == len) ch = 0;
                            int r = reg_cnt++;
                            fprintf(out_fp, "  %%%d = getelementptr [%d x i8], ptr %%%s, i32 0, i32 %d\n",
                                    r, node->array_len, ir_name, i);
                            fprintf(out_fp, "  store i8 %d, ptr %%%d\n", ch, r);
                        }
                    }
                }
            } else if (node->ty == TY_STRUCT) {
                int sz = struct_size(node->struct_id);
                fprintf(out_fp, "  %%%s = alloca [%d x i8]\n", ir_name, sz);
            } else if (is_param(current_params, node->name)) {
                if (node->ty == TY_STRUCT) error("不支援 struct 參數");
                fprintf(out_fp, "  %%%s = alloca %s\n", ir_name, llvm_ty);
                fprintf(out_fp, "  store %s %%%s, ptr %%%s\n", llvm_ty, node->name, ir_name);
            } else {
                fprintf(out_fp, "  %%%s = alloca %s\n", ir_name, llvm_ty);
                if (node->left) {
                    Value val = gen_expr(node->left);
                    Value store_val;
                    if (is_ptr(node->ty)) store_val = val;
                    else if (node->ty == TY_CHAR) store_val = to_i8(val);
                    else store_val = to_i32(val);
                    fprintf(out_fp, "  store %s %s, ptr %%%s\n", llvm_ty, store_val.reg, ir_name);
                    free(store_val.reg);
                }
            }
        } else if (node->type == AST_ASSIGN) {
            const char *llvm_ty = llvm_type(node->ty);
            if (node->ty == TY_STRUCT) error("不支援 struct 賦值");
            Value addr = gen_lvalue_addr(node->left);
            if (node->op == TK_PLUSEQ) {
                if (is_ptr(node->ty)) error("指標不支援 +=");
                int r_old = reg_cnt++;
                fprintf(out_fp, "  %%%d = load %s, ptr %s\n", r_old, llvm_ty, addr.reg);
                char *old_reg = malloc(64);
                sprintf(old_reg, "%%%d", r_old);
                Value old_val = value_from_reg(old_reg, (node->ty == TY_CHAR) ? VT_I8 : VT_I32);
                Value rhs = gen_expr(node->right);
                Value old_i32 = to_i32(old_val);
                Value rhs_i32 = to_i32(rhs);
                int r_new = reg_cnt++;
                fprintf(out_fp, "  %%%d = add i32 %s, %s\n", r_new, old_i32.reg, rhs_i32.reg);
                free(old_i32.reg);
                free(rhs_i32.reg);
                char *new_reg = malloc(64);
                sprintf(new_reg, "%%%d", r_new);
                Value new_val = value_from_reg(new_reg, VT_I32);
                Value store_val = (node->ty == TY_CHAR) ? to_i8(new_val) : new_val;
                fprintf(out_fp, "  store %s %s, ptr %s\n", llvm_ty, store_val.reg, addr.reg);
                free(store_val.reg);
            } else {
                Value val = gen_expr(node->right);
                Value store_val;
                if (is_ptr(node->ty)) store_val = val;
                else if (node->ty == TY_CHAR) store_val = to_i8(val);
                else store_val = to_i32(val);
                fprintf(out_fp, "  store %s %s, ptr %s\n", llvm_ty, store_val.reg, addr.reg);
                free(store_val.reg);
            }
            free(addr.reg);
        } else if (node->type == AST_EXPR_STMT) {
            if (node->left) {
                Value val = gen_expr(node->left);
                if (val.reg) free(val.reg);
            }
        } else if (node->type == AST_BLOCK) {
            var_push_scope();
            gen_stmt(node->left);
            var_pop_scope();
        } else if (node->type == AST_IF) {
            Value cond_val = gen_cond(node->cond);
            int then_fall = stmt_list_may_fallthrough(node->then_body);
            int else_fall = node->else_body ? stmt_list_may_fallthrough(node->else_body) : 1;
            int need_end = then_fall || else_fall;
            int then_label = label_cnt++;
            int else_label = node->else_body ? label_cnt++ : (need_end ? label_cnt++ : label_cnt++);
            int end_label = need_end ? label_cnt++ : -1;
            if (!node->else_body) else_label = end_label;

            fprintf(out_fp, "  br i1 %s, label %%L%d, label %%L%d\n", cond_val.reg, then_label, else_label);
            free(cond_val.reg);

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
            Value cond_val = gen_cond(node->cond);
            fprintf(out_fp, "  br i1 %s, label %%L%d, label %%L%d\n", cond_val.reg, body_label, end_label);
            free(cond_val.reg);

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
                    Value val = gen_expr(node->init->left);
                    if (val.reg) free(val.reg);
                }
            }

            int cond_label = label_cnt++;
            int body_label = label_cnt++;
            int update_label = label_cnt++;
            int end_label = label_cnt++;

            fprintf(out_fp, "  br label %%L%d\n", cond_label);

            fprintf(out_fp, "L%d:\n", cond_label);
            if (node->cond) {
                Value cond_val = gen_cond(node->cond);
                fprintf(out_fp, "  br i1 %s, label %%L%d, label %%L%d\n", cond_val.reg, body_label, end_label);
                free(cond_val.reg);
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
                    Value val = gen_expr(node->update);
                    if (val.reg) free(val.reg);
                }
            }
            fprintf(out_fp, "  br label %%L%d\n", cond_label);

            fprintf(out_fp, "L%d:\n", end_label);
        } else if (node->type == AST_DO) {
            int body_label = label_cnt++;
            int cond_label = label_cnt++;
            int end_label = label_cnt++;

            fprintf(out_fp, "  br label %%L%d\n", body_label);
            fprintf(out_fp, "L%d:\n", body_label);
            break_label_stack[loop_depth] = end_label;
            continue_label_stack[loop_depth] = cond_label;
            loop_depth++;
            gen_stmt(node->body);
            if (stmt_list_may_fallthrough(node->body)) {
                fprintf(out_fp, "  br label %%L%d\n", cond_label);
            }
            loop_depth--;

            fprintf(out_fp, "L%d:\n", cond_label);
            Value cond_val = gen_cond(node->cond);
            fprintf(out_fp, "  br i1 %s, label %%L%d, label %%L%d\n", cond_val.reg, body_label, end_label);
            free(cond_val.reg);
            fprintf(out_fp, "L%d:\n", end_label);
        } else if (node->type == AST_SWITCH) {
            Value cond_val = to_i32(gen_expr(node->cond));
            int end_label = label_cnt++;
            int case_count = 0;
            for (ASTNode *c = node->left; c; c = c->next) case_count++;
            int *case_labels = malloc(sizeof(int) * case_count);
            int *case_is_default = malloc(sizeof(int) * case_count);
            ASTNode **case_nodes = malloc(sizeof(ASTNode*) * case_count);
            int default_label = -1;
            int idx = 0;
            for (ASTNode *c = node->left; c; c = c->next) {
                case_labels[idx] = label_cnt++;
                case_is_default[idx] = c->is_default;
                if (c->is_default) default_label = case_labels[idx];
                case_nodes[idx] = c;
                idx++;
            }

            int first_check = label_cnt++;
            fprintf(out_fp, "  br label %%L%d\n", first_check);

            int check_label = first_check;
            for (int i = 0; i < case_count; i++) {
                if (case_is_default[i]) continue;
                fprintf(out_fp, "L%d:\n", check_label);
                int cmp = reg_cnt++;
                fprintf(out_fp, "  %%%d = icmp eq i32 %s, %d\n", cmp, cond_val.reg, case_nodes[i]->val);
                int next = label_cnt++;
                fprintf(out_fp, "  br i1 %%%d, label %%L%d, label %%L%d\n", cmp, case_labels[i], next);
                check_label = next;
            }
            fprintf(out_fp, "L%d:\n", check_label);
            if (default_label >= 0) fprintf(out_fp, "  br label %%L%d\n", default_label);
            else fprintf(out_fp, "  br label %%L%d\n", end_label);

            switch_break_stack[switch_depth++] = end_label;
            for (int i = 0; i < case_count; i++) {
                fprintf(out_fp, "L%d:\n", case_labels[i]);
                gen_stmt(case_nodes[i]->left);
                if (stmt_list_may_fallthrough(case_nodes[i]->left)) {
                    int next_label = (i + 1 < case_count) ? case_labels[i + 1] : end_label;
                    fprintf(out_fp, "  br label %%L%d\n", next_label);
                }
            }
            switch_depth--;
            fprintf(out_fp, "L%d:\n", end_label);
            free(cond_val.reg);
            free(case_labels);
            free(case_is_default);
            free(case_nodes);
        } else if (node->type == AST_BREAK) {
            if (loop_depth > 0) {
                fprintf(out_fp, "  br label %%L%d\n", break_label_stack[loop_depth - 1]);
            } else if (switch_depth > 0) {
                fprintf(out_fp, "  br label %%L%d\n", switch_break_stack[switch_depth - 1]);
            } else {
                error("break 不在迴圈或 switch 內");
            }
        } else if (node->type == AST_CONTINUE) {
            if (loop_depth == 0) error("continue 不在迴圈內");
            fprintf(out_fp, "  br label %%L%d\n", continue_label_stack[loop_depth - 1]);
        } else if (node->type == AST_RETURN) {
            if (node->left == NULL) {
                fprintf(out_fp, "  ret void\n");
            } else {
                Value val = gen_expr(node->left);
                Value ret_val;
                if (is_ptr(current_ret_ty)) {
                    ret_val = val;
                } else if (current_ret_ty == TY_CHAR) {
                    ret_val = to_i8(val);
                } else {
                    ret_val = to_i32(val);
                }
                fprintf(out_fp, "  ret %s %s\n", llvm_type(current_ret_ty), ret_val.reg);
                free(ret_val.reg);
            }
        }
        node = node->next;
    }
}

void gen_llvm_ir(ASTNode *funcs, FILE *out) {
    out_fp = out;
    fprintf(out_fp, "; ModuleID = 'c0c'\n");
    build_func_sigs(funcs);
    ASTNode *func = funcs;
    while (func) {
        const char *ret_ty = llvm_type(func->ty);
        if (func->is_decl) {
            if (func_has_def(funcs, func->name)) {
                func = func->next;
                continue;
            }
            fprintf(out_fp, "declare %s @%s(", ret_ty, func->name);
        }
        else fprintf(out_fp, "define %s @%s(", ret_ty, func->name);
        ASTNode *param = func->left;
        int first = 1;
        while (param) {
            if (!first) fprintf(out_fp, ", ");
            fprintf(out_fp, "%s %%%s", llvm_type(param->ty), param->name);
            first = 0;
            param = param->next;
        }
        if (func->is_decl) {
            fprintf(out_fp, ");\n\n");
            func = func->next;
            continue;
        }
        fprintf(out_fp, ") {\n");
        fprintf(out_fp, "entry:\n");
        reg_cnt = 0;
        var_id = 0;
        var_cnt = 0;
        scope_depth = 0;
        var_push_scope();
        current_params = func->left;
        current_ret_ty = func->ty;
        ASTNode *pnode = current_params;
        while (pnode) {
            gen_stmt(pnode);
            pnode = pnode->next;
        }
        gen_stmt(func->right);
        if (current_ret_ty == TY_VOID && !stmt_list_ends_with_return(func->right)) {
            fprintf(out_fp, "  ret void\n");
        }
        fprintf(out_fp, "}\n\n");
        func = func->next;
    }

    for (int i = 0; i < string_cnt; i++) {
        char llvm_str[512] = {0};
        int len = 0;
        int out = 0;
        unsigned char *p = (unsigned char*)string_table[i];
        while (*p) {
            unsigned char c = *p++;
            if (c == '\n') {
                out += sprintf(llvm_str + out, "\\0A");
            } else if (c == '\t') {
                out += sprintf(llvm_str + out, "\\09");
            } else if (c == '\r') {
                out += sprintf(llvm_str + out, "\\0D");
            } else if (c == '\\') {
                out += sprintf(llvm_str + out, "\\5C");
            } else if (c == '\"') {
                out += sprintf(llvm_str + out, "\\22");
            } else if (c < 32 || c >= 127) {
                out += sprintf(llvm_str + out, "\\%02X", c);
            } else {
                llvm_str[out++] = (char)c;
                llvm_str[out] = '\0';
            }
            len++;
        }
        strcat(llvm_str, "\\00"); len++;
        fprintf(out_fp, "@.str.%d = private unnamed_addr constant [%d x i8] c\"%s\", align 1\n", i, len, llvm_str);
    }

    fprintf(out_fp, "declare i32 @printf(ptr, ...)\n");
}
