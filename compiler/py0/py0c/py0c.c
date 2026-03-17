#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_TOKEN_LEN 256
char token[MAX_TOKEN_LEN];
FILE *in_fp, *out_fp;
int t_idx = 0;
int l_idx = 0;

void next_token();
void parse_statement();
void parse_expression(char *res_t);

// --- 工具與 IR 輸出函式 ---
void get_t(char* buf, size_t size) { snprintf(buf, size, "t%d", t_idx++); }
void get_l(char* buf, size_t size) { snprintf(buf, size, "L_%d", l_idx++); }

// 依照 DynIR 規格輸出純文字對齊的四元組格式： OP ARG1 ARG2 RESULT
void emit(const char* op, const char* a, const char* b, const char* r) {
    fprintf(out_fp, "%-15s %-10s %-4s %s\n", op, a, b, r);
}

// 檢查並消耗指定的 token
int accept(const char* s) {
    if (strcmp(token, s) == 0) { next_token(); return 1; }
    return 0;
}

// 強制消耗指定的 token，否則報錯
void expect(const char* s) {
    if (strcmp(token, s) != 0) {
        fprintf(stderr, "語法錯誤：預期 '%s'，但得到 '%s'\n", s, token);
        exit(1);
    }
    next_token();
}

// --- 增強版詞法分析器 (Lexer) ---
void next_token() {
    int c = fgetc(in_fp);
    while (c != EOF && isspace(c)) c = fgetc(in_fp);
    if (c == EOF) { strcpy(token, "EOF"); return; }

    if (isalpha(c) || c == '_') {
        int i = 0;
        while (isalnum(c) || c == '_') { token[i++] = c; c = fgetc(in_fp); }
        ungetc(c, in_fp); token[i] = '\0';
    } else if (isdigit(c)) {
        int i = 0;
        while (isdigit(c)) { token[i++] = c; c = fgetc(in_fp); }
        ungetc(c, in_fp); token[i] = '\0';
    } else if (c == '"') {
        int i = 0; token[i++] = c;
        while ((c = fgetc(in_fp)) != '"' && c != EOF) token[i++] = c;
        token[i++] = '"'; token[i] = '\0';
    } else if (c == '=') {
        int next_c = fgetc(in_fp);
        if (next_c == '=') { strcpy(token, "=="); } 
        else { ungetc(next_c, in_fp); strcpy(token, "="); }
    } else {
        token[0] = c; token[1] = '\0';
    }
}

// --- 遞迴下降表達式解析器 (Expression Parser) ---

// 處理最基本的單元 (常數、變數、函數呼叫、括號)
void parse_primary(char *res_t) {
    if (isdigit(token[0]) || token[0] == '"') {
        get_t(res_t, 16);
        emit("LOAD_CONST", token, "_", res_t);
        next_token();
    } else if (isalpha(token[0]) || token[0] == '_') {
        char name[MAX_TOKEN_LEN]; strcpy(name, token); next_token();
        if (accept("(")) { // 函數呼叫： factorial(n - 1)
            int argc = 0;
            while (strcmp(token, ")") != 0) {
                char arg_t[16]; parse_expression(arg_t);
                char idx_str[16]; snprintf(idx_str, sizeof(idx_str), "%d", argc++);
                emit("ARG_PUSH", arg_t, idx_str, "_");
                if (accept(",")) continue;
            }
            expect(")");
            char func_t[16]; get_t(func_t, 16);
            emit("LOAD_NAME", name, "_", func_t);
            get_t(res_t, 16);
            char argc_str[16]; snprintf(argc_str, sizeof(argc_str), "%d", argc);
            emit("CALL", func_t, argc_str, res_t);
        } else { // 單純變數： n
            get_t(res_t, 16);
            emit("LOAD_NAME", name, "_", res_t);
        }
    } else if (accept("(")) { // 處理括號 (n - 1)
        parse_expression(res_t);
        expect(")");
    }
}

// 乘除法 (*)
void parse_mult(char *res_t) {
    parse_primary(res_t);
    while (strcmp(token, "*") == 0) {
        next_token();
        char rhs_t[16]; parse_primary(rhs_t);
        char new_res[16]; get_t(new_res, 16);
        emit("MUL", res_t, rhs_t, new_res);
        strcpy(res_t, new_res);
    }
}

// 加減法 (+, -)
void parse_add(char *res_t) {
    parse_mult(res_t);
    while (strcmp(token, "+") == 0 || strcmp(token, "-") == 0) {
        char op[16]; strcpy(op, token); next_token();
        char rhs_t[16]; parse_mult(rhs_t);
        char new_res[16]; get_t(new_res, 16);
        if (strcmp(op, "+") == 0) emit("ADD", res_t, rhs_t, new_res);
        else emit("SUB", res_t, rhs_t, new_res);
        strcpy(res_t, new_res);
    }
}

// 比較運算 (==)
void parse_cmp(char *res_t) {
    parse_add(res_t);
    while (strcmp(token, "==") == 0) {
        next_token();
        char rhs_t[16]; parse_add(rhs_t);
        char new_res[16]; get_t(new_res, 16);
        emit("CMP_EQ", res_t, rhs_t, new_res);
        strcpy(res_t, new_res);
    }
}

// 邏輯 OR 運算 (or) -> 對應 DynIR 的 BITOR (或可視作動態語言的邏輯操作)
void parse_or(char *res_t) {
    parse_cmp(res_t);
    while (accept("or")) {
        char rhs_t[16]; parse_cmp(rhs_t);
        char new_res[16]; get_t(new_res, 16);
        emit("BITOR", res_t, rhs_t, new_res);
        strcpy(res_t, new_res);
    }
}

// 總表達式入口
void parse_expression(char *res_t) {
    parse_or(res_t);
}

// --- 語句解析器 (Statement Parser) ---
void parse_statement() {
    if (accept("def")) {
        char func_name[64]; strcpy(func_name, token); next_token();
        expect("("); 
        char param[64]; strcpy(param, token); next_token(); // 簡化：只讀取一個參數 n
        expect(")"); expect(":");
        
        emit("LABEL", func_name, "_", "_");
        // 進入函數本體解析 (以 factorial 為例，主體為一個 if 語句)
        parse_statement(); 
    } 
    else if (accept("if")) {
        char cond_t[16]; parse_expression(cond_t);
        expect(":");
        
        char l_else[16], l_end[16]; 
        get_l(l_else, 16); get_l(l_end, 16);
        emit("BRANCH_IF_FALSE", cond_t, "_", l_else);
        
        parse_statement(); // if 的內容 (return 1)
        
        emit("JUMP", l_end, "_", "_");
        emit("LABEL", l_else, "_", "_");
        
        if (accept("else")) {
            expect(":");
            parse_statement(); // else 的內容 (return n * factorial(n - 1))
        }
        emit("LABEL", l_end, "_", "_");
    } 
    else if (accept("return")) {
        char res_t[16]; parse_expression(res_t);
        emit("RETURN", res_t, "_", "_");
    } 
    else {
        // 賦值 (result = ...) 或是 獨立函數呼叫 (print(...))
        char id[MAX_TOKEN_LEN]; strcpy(id, token); next_token();
        
        if (accept("=")) {
            char expr_t[16]; parse_expression(expr_t);
            emit("STORE", expr_t, "_", id);
        } 
        else if (accept("(")) { // 如 print("...", result)
            int argc = 0;
            while (strcmp(token, ")") != 0) {
                char arg_t[16]; parse_expression(arg_t);
                char idx_str[16]; snprintf(idx_str, sizeof(idx_str), "%d", argc++);
                emit("ARG_PUSH", arg_t, idx_str, "_");
                if (accept(",")) continue;
            }
            expect(")");
            char func_t[16]; get_t(func_t, 16);
            emit("LOAD_NAME", id, "_", func_t);
            char res_t[16]; get_t(res_t, 16);
            char argc_str[16]; snprintf(argc_str, sizeof(argc_str), "%d", argc);
            emit("CALL", func_t, argc_str, res_t);
        }
    }
}

int main(int argc, char *argv[]) {
    if (argc < 4) {
        printf("用法: ./py0c input.py -o output.qd\n");
        return 1;
    }
    
    in_fp = fopen(argv[1], "r");
    out_fp = fopen(argv[3], "w");
    if (!in_fp || !out_fp) { perror("檔案開啟失敗"); return 1; }

    next_token();
    while (strcmp(token, "EOF") != 0) {
        parse_statement();
    }
    
    fclose(in_fp); fclose(out_fp);
    return 0;
}