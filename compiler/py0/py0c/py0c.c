#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_TOKEN_LEN 1024
#define MAX_PARAMS 64

char token[MAX_TOKEN_LEN];
FILE *in_fp, *out_fp;
int t_idx = 0;
int l_idx = 0;
int line_num = 1;

int in_function = 0;
char func_params[MAX_PARAMS][MAX_TOKEN_LEN];
int param_count = 0;

int loop_depth = 0;

const char* keywords[] = {
    "and", "as", "assert", "async", "await", "break", "class", "continue",
    "def", "del", "elif", "else", "except", "finally", "for", "from",
    "global", "if", "import", "in", "is", "lambda", "nonlocal", "not",
    "or", "pass", "raise", "return", "try", "while", "with", "yield", NULL
};

int is_keyword(const char* s) {
    for (int i = 0; keywords[i]; i++)
        if (strcmp(s, keywords[i]) == 0) return 1;
    return 0;
}

void next_token();
void parse_expression(char *res_t);
void parse_statement();

void get_t(char* buf, size_t size) { snprintf(buf, size, "t%d", t_idx++); }
void get_l(char* buf, size_t size) { snprintf(buf, size, "L_%d", l_idx++); }

void emit(const char* op, const char* a, const char* b, const char* r) {
    fprintf(out_fp, "%-15s %-10s %-4s %s\n", op, a, b, r);
}

int accept(const char* s) {
    if (strcmp(token, s) == 0) { next_token(); return 1; }
    return 0;
}

void expect(const char* s) {
    if (strcmp(token, s) != 0) {
        fprintf(stderr, "Syntax error: expected '%s', got '%s' at line %d\n", s, token, line_num);
        exit(1);
    }
    next_token();
}

void skip_comment() {
    int c;
    while ((c = fgetc(in_fp)) != EOF && c != '\n') {}
    if (c == '\n') { ungetc(c, in_fp); line_num++; }
}

void skip_newlines() {
    while (strcmp(token, "\n") == 0) {
        next_token();
    }
}

void next_token() {
    int c = fgetc(in_fp);
    
    while (c != EOF && (c == ' ' || c == '\t')) c = fgetc(in_fp);
    
    if (c == EOF) { strcpy(token, "EOF"); return; }
    
    if (c == '\n') {
        line_num++;
        c = fgetc(in_fp);
        while (c == ' ' || c == '\t') c = fgetc(in_fp);
        if (c == '#') { ungetc(c, in_fp); skip_comment(); next_token(); return; }
        if (c == EOF) { strcpy(token, "EOF"); return; }
        if (c == '\n') { ungetc(c, in_fp); next_token(); return; }
        ungetc(c, in_fp);
        strcpy(token, "\n");
        return;
    }
    
    if (c == '#') {
        skip_comment();
        next_token();
        return;
    }
    
    if (isdigit(c)) {
        int i = 0;
        while (isdigit(c) || c == '.') { token[i++] = c; c = fgetc(in_fp); }
        ungetc(c, in_fp);
        token[i] = '\0';
        return;
    }
    
    if (c == '"' || c == '\'') {
        int quote_char = c;
        int i = 0;
        token[i++] = c;
        while ((c = fgetc(in_fp)) != quote_char && c != EOF && c != '\n') {
            if (c == '\\') { token[i++] = c; token[i++] = fgetc(in_fp); }
            else token[i++] = c;
        }
        if (c == quote_char) token[i++] = c;
        token[i] = '\0';
        return;
    }
    
    if (isalpha(c) || c == '_') {
        int i = 0;
        while (isalnum(c) || c == '_') { token[i++] = c; c = fgetc(in_fp); }
        ungetc(c, in_fp);
        token[i] = '\0';
        return;
    }
    
    switch (c) {
        case '+': strcpy(token, "+"); break;
        case '-': strcpy(token, "-"); break;
        case '*': strcpy(token, "*"); break;
        case '/': strcpy(token, "/"); break;
        case '%': strcpy(token, "%"); break;
        case '(': strcpy(token, "("); break;
        case ')': strcpy(token, ")"); break;
        case '[': strcpy(token, "["); break;
        case ']': strcpy(token, "]"); break;
        case '{': strcpy(token, "{"); break;
        case '}': strcpy(token, "}"); break;
        case ',': strcpy(token, ","); break;
        case ':': strcpy(token, ":"); break;
        case ';': strcpy(token, ";"); break;
        case '.': strcpy(token, "."); break;
        case '=': {
            int next = fgetc(in_fp);
            if (next == '=') strcpy(token, "==");
            else { ungetc(next, in_fp); strcpy(token, "="); }
            break;
        }
        case '!': {
            int next = fgetc(in_fp);
            if (next == '=') strcpy(token, "!=");
            else { ungetc(next, in_fp); strcpy(token, "!"); }
            break;
        }
        case '<': {
            int next = fgetc(in_fp);
            if (next == '=') strcpy(token, "<=");
            else if (next == '<') strcpy(token, "<<");
            else { ungetc(next, in_fp); strcpy(token, "<"); }
            break;
        }
        case '>': {
            int next = fgetc(in_fp);
            if (next == '=') strcpy(token, ">=");
            else if (next == '>') strcpy(token, ">>");
            else { ungetc(next, in_fp); strcpy(token, ">"); }
            break;
        }
        case '&': strcpy(token, "&"); break;
        case '|': strcpy(token, "|"); break;
        case '^': strcpy(token, "^"); break;
        case '~': strcpy(token, "~"); break;
        default: token[0] = c; token[1] = '\0'; break;
    }
}

void parse_expression(char *res_t);
void parse_or(char *res_t);
void parse_and(char *res_t);
void parse_not(char *res_t);
void parse_compare(char *res_t);
void parse_add(char *res_t);
void parse_mul(char *res_t);
void parse_unary(char *res_t);
void parse_primary(char *res_t);
void parse_atom(char *res_t);

void parse_atom(char *res_t) {
    if (isdigit(token[0])) {
        get_t(res_t, 32);
        emit("LOAD_CONST", token, "_", res_t);
        next_token();
    } else if (token[0] == '"' || token[0] == '\'') {
        get_t(res_t, 32);
        emit("LOAD_CONST", token, "_", res_t);
        next_token();
    } else if (strcmp(token, "True") == 0) {
        get_t(res_t, 32);
        emit("LOAD_CONST", "True", "_", res_t);
        next_token();
    } else if (strcmp(token, "False") == 0) {
        get_t(res_t, 32);
        emit("LOAD_CONST", "False", "_", res_t);
        next_token();
    } else if (strcmp(token, "None") == 0) {
        get_t(res_t, 32);
        emit("LOAD_CONST", "None", "_", res_t);
        next_token();
    } else if (accept("(")) {
        if (accept(")")) {
            get_t(res_t, 32);
            emit("BUILD_TUPLE", "0", "_", res_t);
        } else {
            parse_expression(res_t);
            expect(")");
        }
    } else if (accept("[")) {
        if (accept("]")) {
            get_t(res_t, 32);
            emit("BUILD_LIST", "0", "_", res_t);
        } else {
            char elem_t[32];
            int count = 0;
            parse_expression(elem_t);
            count++;
            while (accept(",")) {
                if (accept("]")) break;
                char next_t[32];
                parse_expression(next_t);
                char tmp[32];
                get_t(tmp, 32);
                emit("LIST_APPEND", elem_t, next_t, tmp);
                strcpy(elem_t, tmp);
                count++;
            }
            expect("]");
            get_t(res_t, 32);
            char cnt[16];
            snprintf(cnt, sizeof(cnt), "%d", count);
            emit("BUILD_LIST", cnt, "_", res_t);
        }
    } else if (accept("{")) {
        if (accept("}")) {
            get_t(res_t, 32);
            emit("BUILD_MAP", "0", "_", res_t);
        } else {
            char first_t[32];
            parse_expression(first_t);
            if (accept(":")) {
                char val_t[32];
                parse_expression(val_t);
                char dict_t[32];
                get_t(dict_t, 32);
                emit("BUILD_MAP", "0", "_", dict_t);
                char kv_t[32];
                get_t(kv_t, 32);
                emit("DICT_ADD", first_t, val_t, kv_t);
                char merged[32];
                get_t(merged, 32);
                emit("DICT_MERGE", dict_t, kv_t, merged);
                strcpy(first_t, merged);
                
                while (accept(",")) {
                    if (accept("}")) {
                        get_t(res_t, 32);
                        emit("BUILD_MAP", "0", "_", res_t);
                        char map_t[32];
                        get_t(map_t, 32);
                        emit("DICT_MERGE", first_t, "_", map_t);
                        strcpy(res_t, map_t);
                        return;
                    }
                    char k_t[32], v_t[32];
                    parse_expression(k_t);
                    expect(":");
                    parse_expression(v_t);
                    char new_kv[32];
                    get_t(new_kv, 32);
                    emit("DICT_ADD", k_t, v_t, new_kv);
                    char new_merged[32];
                    get_t(new_merged, 32);
                    emit("DICT_MERGE", first_t, new_kv, new_merged);
                    strcpy(first_t, new_merged);
                }
                expect("}");
                get_t(res_t, 32);
                emit("BUILD_MAP", "0", "_", res_t);
                char map_t[32];
                get_t(map_t, 32);
                emit("DICT_MERGE", first_t, "_", map_t);
                strcpy(res_t, map_t);
            } else {
                expect("}");
                get_t(res_t, 32);
                emit("BUILD_SET", "0", "_", res_t);
            }
        }
    } else if (token[0] == '_' || isalpha(token[0])) {
        char name[MAX_TOKEN_LEN];
        strcpy(name, token);
        next_token();
        
        int is_param = 0;
        if (in_function) {
            for (int i = 0; i < param_count; i++) {
                if (strcmp(func_params[i], name) == 0) { is_param = 1; break; }
            }
        }
        
        if (accept("(")) {
            int argc = 0;
            while (strcmp(token, ")") != 0 && strcmp(token, "EOF") != 0 && strcmp(token, "\n") != 0) {
                if (strcmp(token, ",") == 0) { next_token(); continue; }
                char arg_t[32];
                parse_expression(arg_t);
                char idx[16];
                snprintf(idx, sizeof(idx), "%d", argc++);
                emit("ARG_PUSH", arg_t, idx, "_");
                if (strcmp(token, ")") == 0) break;
                if (!accept(",")) break;
            }
            if (strcmp(token, ")") == 0) next_token();
            char func_t[32];
            get_t(func_t, 32);
            emit("LOAD_NAME", name, "_", func_t);
            get_t(res_t, 32);
            char argc_s[16];
            snprintf(argc_s, sizeof(argc_s), "%d", argc);
            emit("CALL", func_t, argc_s, res_t);
        } else if (accept("[")) {
            char idx_t[32];
            parse_expression(idx_t);
            expect("]");
            char obj_t[32];
            get_t(obj_t, 32);
            emit("LOAD_NAME", name, "_", obj_t);
            get_t(res_t, 32);
            emit("BINARY_SUBSCR", obj_t, idx_t, res_t);
        } else if (accept(".")) {
            char attr[MAX_TOKEN_LEN];
            strcpy(attr, token);
            next_token();
            char obj_t[32];
            get_t(obj_t, 32);
            emit("LOAD_NAME", name, "_", obj_t);
            get_t(res_t, 32);
            emit("LOAD_ATTR", obj_t, attr, res_t);
        } else {
            get_t(res_t, 32);
            if (is_param) emit("LOAD_FAST", name, "_", res_t);
            else emit("LOAD_NAME", name, "_", res_t);
        }
    } else {
        fprintf(stderr, "Syntax error: unexpected token '%s' at line %d\n", token, line_num);
        exit(1);
    }
}

void parse_primary(char *res_t) {
    parse_atom(res_t);
}

void parse_unary(char *res_t) {
    if (accept("+")) {
        parse_unary(res_t);
    } else if (accept("-")) {
        char rhs_t[32];
        parse_unary(rhs_t);
        char zero[32];
        get_t(zero, 32);
        emit("LOAD_CONST", "0", "_", zero);
        get_t(res_t, 32);
        emit("SUB", zero, rhs_t, res_t);
    } else if (accept("~")) {
        char rhs_t[32];
        parse_unary(rhs_t);
        get_t(res_t, 32);
        emit("BITWISE_NOT", rhs_t, "_", res_t);
    } else if (accept("not")) {
        parse_not(res_t);
    } else {
        parse_primary(res_t);
    }
}

void parse_mul(char *res_t) {
    parse_unary(res_t);
    while (1) {
        char op[32] = {0};
        if (accept("*")) strcpy(op, "MUL");
        else if (accept("/")) strcpy(op, "BINARY_TRUE_DIVIDE");
        else if (accept("%")) strcpy(op, "BINARY_MODULO");
        else break;
        char rhs_t[32];
        parse_unary(rhs_t);
        char new_res[32];
        get_t(new_res, 32);
        emit(op, res_t, rhs_t, new_res);
        strcpy(res_t, new_res);
    }
}

void parse_add(char *res_t) {
    parse_mul(res_t);
    while (1) {
        char op[16] = {0};
        if (accept("+")) strcpy(op, "ADD");
        else if (accept("-")) strcpy(op, "SUB");
        else break;
        char rhs_t[32];
        parse_mul(rhs_t);
        char new_res[32];
        get_t(new_res, 32);
        emit(op, res_t, rhs_t, new_res);
        strcpy(res_t, new_res);
    }
}

void parse_compare(char *res_t) {
    parse_add(res_t);
    while (1) {
        char op[16] = {0};
        if (accept("<")) strcpy(op, "CMP_LT");
        else if (accept(">")) strcpy(op, "CMP_GT");
        else if (accept("<=")) strcpy(op, "CMP_LE");
        else if (accept(">=")) strcpy(op, "CMP_GE");
        else if (accept("==")) strcpy(op, "CMP_EQ");
        else if (accept("!=")) strcpy(op, "CMP_NE");
        else if (accept("in")) strcpy(op, "CONTAINS_OP");
        else if (accept("is")) strcpy(op, "CMP_IS");
        else break;
        char rhs_t[32];
        parse_add(rhs_t);
        char new_res[32];
        get_t(new_res, 32);
        emit(op, res_t, rhs_t, new_res);
        strcpy(res_t, new_res);
    }
}

void parse_not(char *res_t) {
    if (accept("not")) {
        parse_not(res_t);
        char new_res[32];
        get_t(new_res, 32);
        emit("UNARY_NOT", res_t, "_", new_res);
        strcpy(res_t, new_res);
    } else {
        parse_compare(res_t);
    }
}

void parse_and(char *res_t) {
    parse_not(res_t);
    while (accept("and")) {
        char rhs_t[32];
        parse_not(rhs_t);
        char new_res[32];
        get_t(new_res, 32);
        emit("BINARY_AND", res_t, rhs_t, new_res);
        strcpy(res_t, new_res);
    }
}

void parse_or(char *res_t) {
    parse_and(res_t);
    while (accept("or")) {
        char rhs_t[32];
        parse_and(rhs_t);
        char new_res[32];
        get_t(new_res, 32);
        emit("BINARY_OR", res_t, rhs_t, new_res);
        strcpy(res_t, new_res);
    }
}

void parse_expression(char *res_t) {
    parse_or(res_t);
}

void parse_statement() {
    skip_newlines();
    
    if (accept("def")) {
        char func_name[MAX_TOKEN_LEN];
        strcpy(func_name, token);
        next_token();
        
        int saved_in_func = in_function;
        char saved_params[MAX_PARAMS][MAX_TOKEN_LEN];
        int saved_param_count = param_count;
        memcpy(saved_params, func_params, sizeof(func_params));
        
        in_function = 1;
        param_count = 0;
        
        expect("(");
        if (!accept(")")) {
            if (token[0] == '_' || isalpha(token[0])) {
                strcpy(func_params[param_count++], token);
                next_token();
                while (accept(",")) {
                    if (accept(")")) break;
                    if (token[0] == '_' || isalpha(token[0])) {
                        strcpy(func_params[param_count++], token);
                        next_token();
                    }
                }
            }
            expect(")");
        }
        expect(":");
        skip_newlines();
        
        emit("LABEL", func_name, "_", "_");
        
        while (!accept("def") && strcmp(token, "EOF") != 0) {
            skip_newlines();
            if (accept("return")) {
                if (strcmp(token, "\n") == 0 || strcmp(token, "def") == 0 || strcmp(token, "EOF") == 0) {
                    emit("RETURN", "_", "_", "_");
                } else {
                    char res_t[32];
                    parse_expression(res_t);
                    emit("RETURN", res_t, "_", "_");
                }
            } else {
                parse_statement();
            }
        }
        
        emit("RETURN", "_", "_", "_");
        
        in_function = saved_in_func;
        param_count = saved_param_count;
        memcpy(func_params, saved_params, sizeof(saved_params));
    }
    else if (accept("if")) {
        char cond_t[32];
        parse_expression(cond_t);
        expect(":");
        skip_newlines();
        
        char l_else[32], l_end[32];
        get_l(l_else, 32);
        get_l(l_end, 32);
        
        emit("BRANCH_IF_FALSE", cond_t, "_", l_else);
        
        int saw_else = 0;
        int saw_elif = 0;
        while (!saw_else && !saw_elif && strcmp(token, "def") != 0 && strcmp(token, "EOF") != 0) {
            if (strcmp(token, "elif") == 0) { saw_elif = 1; break; }
            if (strcmp(token, "else") == 0) { saw_else = 1; break; }
            skip_newlines();
            if (strcmp(token, "elif") == 0) { saw_elif = 1; break; }
            if (strcmp(token, "else") == 0) { saw_else = 1; break; }
            if (strcmp(token, "def") == 0 || strcmp(token, "EOF") == 0) break;
            if (accept("return")) {
                if (strcmp(token, "\n") != 0) {
                    char res_t[32];
                    parse_expression(res_t);
                    emit("RETURN", res_t, "_", "_");
                } else {
                    emit("RETURN", "_", "_", "_");
                }
            } else {
                parse_statement();
            }
        }
        
        emit("JUMP", l_end, "_", "_");
        emit("LABEL", l_else, "_", "_");
        
        if (saw_elif) {
            next_token();
            parse_expression(cond_t);
            expect(":");
            skip_newlines();
            
            char l_next[32];
            get_l(l_next, 32);
            emit("BRANCH_IF_FALSE", cond_t, "_", l_next);
            
            while (!saw_else && strcmp(token, "def") != 0 && strcmp(token, "EOF") != 0) {
                if (strcmp(token, "elif") == 0) { saw_elif = 1; break; }
                if (strcmp(token, "else") == 0) { saw_else = 1; break; }
                skip_newlines();
                if (strcmp(token, "elif") == 0) { saw_elif = 1; break; }
                if (strcmp(token, "else") == 0) { saw_else = 1; break; }
                if (strcmp(token, "def") == 0 || strcmp(token, "EOF") == 0) break;
                if (accept("return")) {
                    if (strcmp(token, "\n") != 0) {
                        char res_t[32];
                        parse_expression(res_t);
                        emit("RETURN", res_t, "_", "_");
                    } else {
                        emit("RETURN", "_", "_", "_");
                    }
                } else {
                    parse_statement();
                }
            }
            
            emit("JUMP", l_end, "_", "_");
            emit("LABEL", l_next, "_", "_");
        }
        
        if (saw_else) {
            next_token();
            expect(":");
            skip_newlines();
            
            while (strcmp(token, "def") != 0 && strcmp(token, "EOF") != 0) {
                skip_newlines();
                if (strcmp(token, "def") == 0 || strcmp(token, "EOF") == 0) break;
                if (accept("return")) {
                    if (strcmp(token, "\n") != 0) {
                        char res_t[32];
                        parse_expression(res_t);
                        emit("RETURN", res_t, "_", "_");
                    } else {
                        emit("RETURN", "_", "_", "_");
                    }
                } else {
                    parse_statement();
                }
            }
        }
        
        emit("LABEL", l_end, "_", "_");
    }
    else if (accept("while")) {
        char l_start[32], l_end[32];
        get_l(l_start, 32);
        get_l(l_end, 32);
        
        emit("LABEL", l_start, "_", "_");
        
        char cond_t[32];
        parse_expression(cond_t);
        expect(":");
        skip_newlines();
        
        emit("BRANCH_IF_FALSE", cond_t, "_", l_end);
        
        loop_depth++;
        
        while (!accept("def") && strcmp(token, "EOF") != 0) {
            skip_newlines();
            if (accept("break")) {
                emit("JUMP", l_end, "_", "_");
            } else if (accept("continue")) {
                emit("JUMP", l_start, "_", "_");
            } else if (accept("return")) {
                if (strcmp(token, "\n") != 0) {
                    char res_t[32];
                    parse_expression(res_t);
                    emit("RETURN", res_t, "_", "_");
                } else {
                    emit("RETURN", "_", "_", "_");
                }
            } else {
                parse_statement();
            }
        }
        
        loop_depth--;
        
        emit("JUMP", l_start, "_", "_");
        emit("LABEL", l_end, "_", "_");
    }
    else if (accept("for")) {
        char var_name[MAX_TOKEN_LEN];
        strcpy(var_name, token);
        next_token();
        expect("in");
        
        char iter_t[32];
        parse_expression(iter_t);
        expect(":");
        skip_newlines();
        
        char l_start[32], l_end[32];
        get_l(l_start, 32);
        get_l(l_end, 32);
        
        emit("GET_ITER", iter_t, "_", "_");
        emit("LABEL", l_start, "_", "_");
        
        char item_t[32];
        get_t(item_t, 32);
        emit("FOR_ITER", "_", "_", item_t);
        emit("BRANCH_IF_FALSE", item_t, "_", l_end);
        emit("STORE", item_t, "_", var_name);
        
        loop_depth++;
        
        while (!accept("def") && strcmp(token, "EOF") != 0) {
            skip_newlines();
            if (accept("break")) {
                emit("JUMP", l_end, "_", "_");
            } else if (accept("continue")) {
                emit("JUMP", l_start, "_", "_");
            } else if (accept("return")) {
                if (strcmp(token, "\n") != 0) {
                    char res_t[32];
                    parse_expression(res_t);
                    emit("RETURN", res_t, "_", "_");
                } else {
                    emit("RETURN", "_", "_", "_");
                }
            } else {
                parse_statement();
            }
        }
        
        loop_depth--;
        
        emit("JUMP", l_start, "_", "_");
        emit("LABEL", l_end, "_", "_");
    }
    else if (accept("class")) {
        char class_name[MAX_TOKEN_LEN];
        strcpy(class_name, token);
        next_token();
        
        if (accept("(")) {
            if (!accept(")")) {
                parse_expression(token);
                expect(")");
            }
        }
        expect(":");
        skip_newlines();
        
        emit("CLASS", class_name, "_", "_");
        
        while (!accept("def") && strcmp(token, "EOF") != 0) {
            skip_newlines();
            if (accept("def")) {
                char method_name[MAX_TOKEN_LEN];
                strcpy(method_name, token);
                next_token();
                
                int saved_in_func = in_function;
                char saved_params[MAX_PARAMS][MAX_TOKEN_LEN];
                int saved_param_count = param_count;
                memcpy(saved_params, func_params, sizeof(func_params));
                
                in_function = 1;
                param_count = 0;
                
                expect("(");
                if (!accept(")")) {
                    if (token[0] == '_' || isalpha(token[0])) {
                        strcpy(func_params[param_count++], token);
                        next_token();
                        while (accept(",")) {
                            if (accept(")")) break;
                            if (token[0] == '_' || isalpha(token[0])) {
                                strcpy(func_params[param_count++], token);
                                next_token();
                            }
                        }
                    }
                    expect(")");
                }
                expect(":");
                skip_newlines();
                
                char full_name[MAX_TOKEN_LEN];
                snprintf(full_name, sizeof(full_name), "%s.%s", class_name, method_name);
                emit("LABEL", full_name, "_", "_");
                
                while (!accept("def") && !accept("class") && strcmp(token, "EOF") != 0) {
                    skip_newlines();
                    if (accept("return")) {
                        if (strcmp(token, "\n") != 0) {
                            char res_t[32];
                            parse_expression(res_t);
                            emit("RETURN", res_t, "_", "_");
                        } else {
                            emit("RETURN", "_", "_", "_");
                        }
                    } else {
                        parse_statement();
                    }
                }
                
                emit("RETURN", "_", "_", "_");
                
                in_function = saved_in_func;
                param_count = saved_param_count;
                memcpy(func_params, saved_params, sizeof(saved_params));
            } else {
                parse_statement();
            }
        }
    }
    else if (accept("return")) {
        if (strcmp(token, "\n") == 0 || strcmp(token, "def") == 0 || strcmp(token, "EOF") == 0) {
            emit("RETURN", "_", "_", "_");
        } else {
            char res_t[32];
            parse_expression(res_t);
            emit("RETURN", res_t, "_", "_");
        }
    }
    else if (accept("pass")) {
        emit("POP_TOP", "_", "_", "_");
    }
    else if (accept("break")) {
        if (loop_depth == 0) {
            fprintf(stderr, "Syntax error: break outside loop at line %d\n", line_num);
            exit(1);
        }
        emit("JUMP", "_", "_", "_");
    }
    else if (accept("continue")) {
        if (loop_depth == 0) {
            fprintf(stderr, "Syntax error: continue outside loop at line %d\n", line_num);
            exit(1);
        }
        emit("JUMP", "_", "_", "_");
    }
    else if (accept("assert")) {
        char cond_t[32];
        parse_expression(cond_t);
        emit("ASSERT", cond_t, "_", "_");
        if (accept(",")) {
            char msg_t[32];
            parse_expression(msg_t);
            emit("ASSERT_MSG", cond_t, msg_t, "_");
        }
    }
    else if (token[0] == '_' || isalpha(token[0])) {
        if (is_keyword(token) && strcmp(token, "True") != 0 && strcmp(token, "False") != 0 && strcmp(token, "None") != 0) {
            fprintf(stderr, "Syntax error: unexpected keyword '%s' at line %d\n", token, line_num);
            exit(1);
        }
        char name[MAX_TOKEN_LEN];
        strcpy(name, token);
        next_token();
        
        if (accept("=")) {
            char expr_t[32];
            parse_expression(expr_t);
            emit("STORE", expr_t, "_", name);
            
            while (accept(",")) {
                if (token[0] == '_' || isalpha(token[0])) {
                    strcpy(name, token);
                    next_token();
                    if (accept("=")) {
                        parse_expression(expr_t);
                        emit("STORE", expr_t, "_", name);
                    }
                }
            }
        }
        else if (accept("(")) {
            int argc = 0;
            while (!accept(")")) {
                char arg_t[32];
                parse_expression(arg_t);
                char idx[16];
                snprintf(idx, sizeof(idx), "%d", argc++);
                emit("ARG_PUSH", arg_t, idx, "_");
                if (!accept(",") && !accept(")")) break;
            }
            char func_t[32];
            get_t(func_t, 32);
            emit("LOAD_NAME", name, "_", func_t);
            get_t(name, 32);
            char argc_s[16];
            snprintf(argc_s, sizeof(argc_s), "%d", argc);
            emit("CALL", func_t, argc_s, name);
            emit("POP_TOP", name, "_", "_");
        }
        else if (accept("[")) {
            char idx_t[32];
            parse_expression(idx_t);
            expect("]");
            expect("=");
            char val_t[32];
            parse_expression(val_t);
            char obj_t[32];
            get_t(obj_t, 32);
            emit("LOAD_NAME", name, "_", obj_t);
            emit("STORE_SUBSCR", obj_t, val_t, "_");
        }
        else if (accept(".")) {
            char attr[MAX_TOKEN_LEN];
            strcpy(attr, token);
            next_token();
            expect("=");
            char val_t[32];
            parse_expression(val_t);
            char obj_t[32];
            get_t(obj_t, 32);
            emit("LOAD_NAME", name, "_", obj_t);
            emit("STORE_ATTR", obj_t, val_t, "_");
        }
        else {
            char val_t[32];
            get_t(val_t, 32);
            emit("LOAD_NAME", name, "_", val_t);
            emit("POP_TOP", val_t, "_", "_");
        }
    }
    else if (accept("import")) {
        if (token[0] == '_' || isalpha(token[0])) {
            char module[MAX_TOKEN_LEN];
            strcpy(module, token);
            next_token();
            emit("IMPORT", module, "_", "_");
            if (accept("as")) {
                char alias[MAX_TOKEN_LEN];
                strcpy(alias, token);
                next_token();
                emit("IMPORT_AS", module, alias, "_");
            }
            while (accept(",")) {
                if (token[0] == '_' || isalpha(token[0])) {
                    strcpy(module, token);
                    next_token();
                    emit("IMPORT", module, "_", "_");
                    if (accept("as")) {
                        char alias[MAX_TOKEN_LEN];
                        strcpy(alias, token);
                        next_token();
                        emit("IMPORT_AS", module, alias, "_");
                    }
                }
            }
        }
    }
    else if (accept("from")) {
        int dots = 0;
        while (accept(".")) dots++;
        char module[MAX_TOKEN_LEN] = {0};
        if (token[0] == '_' || isalpha(token[0])) {
            strcpy(module, token);
            next_token();
            while (accept(".")) {
                strcat(module, ".");
                strcat(module, token);
                next_token();
            }
        }
        expect("import");
        if (accept("*")) {
            emit("IMPORT_STAR", module, "_", "_");
        } else if (accept("(")) {
            while (!accept(")")) {
                if (token[0] == '_' || isalpha(token[0])) {
                    char name[MAX_TOKEN_LEN];
                    strcpy(name, token);
                    next_token();
                    if (accept("as")) {
                        char alias[MAX_TOKEN_LEN];
                        strcpy(alias, token);
                        next_token();
                        emit("FROM_IMPORT_AS", module, name, alias);
                    } else {
                        emit("FROM_IMPORT", module, name, "_");
                    }
                }
                if (!accept(",") && !accept(")")) break;
            }
        } else {
            while (token[0] == '_' || isalpha(token[0])) {
                char name[MAX_TOKEN_LEN];
                strcpy(name, token);
                next_token();
                if (accept("as")) {
                    char alias[MAX_TOKEN_LEN];
                    strcpy(alias, token);
                    next_token();
                    emit("FROM_IMPORT_AS", module, name, alias);
                } else {
                    emit("FROM_IMPORT", module, name, "_");
                }
                if (!accept(",")) break;
            }
        }
    }
}

int main(int argc, char *argv[]) {
    if (argc < 4) {
        printf("Usage: ./py0c input.py -o output.qd\n");
        return 1;
    }
    
    in_fp = fopen(argv[1], "r");
    out_fp = fopen(argv[3], "w");
    if (!in_fp || !out_fp) { perror("File open failed"); return 1; }
    
    next_token();
    while (strcmp(token, "EOF") != 0) {
        skip_newlines();
        if (strcmp(token, "EOF") == 0) break;
        parse_statement();
    }
    
    emit("HALT", "_", "_", "_");
    
    fclose(in_fp);
    fclose(out_fp);
    return 0;
}
