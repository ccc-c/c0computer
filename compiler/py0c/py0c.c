#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_TOKEN_LEN 64
char token[MAX_TOKEN_LEN];
FILE *in_fp, *out_fp;
int t_idx = 0;
int l_idx = 0;

void next_token();
void parse_statement();
void emit(const char* op, const char* a, const char* b, const char* r);

void get_t(char* buf, size_t size) { snprintf(buf, size, "t%d", t_idx++); }
void get_l(char* buf, size_t size) { snprintf(buf, size, "L_%d", l_idx++); }

void emit(const char* op, const char* a, const char* b, const char* r) {
    fprintf(out_fp, "%-15s %-10s %-3s %s\n", op, a, b, r);
}

// 增強型詞法分析：正確處理符號與關鍵字
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
        while ((c = fgetc(in_fp)) != '"') token[i++] = c;
        token[i++] = '"'; token[i] = '\0';
    } else {
        token[0] = c; token[1] = '\0';
    }
}

// 輔助函式：檢查並消耗符號
void expect(const char* expected) {
    if (strcmp(token, expected) != 0) {
        fprintf(stderr, "語法錯誤：預期 '%s' 但得到 '%s'\n", expected, token);
        exit(1);
    }
    next_token();
}

void parse_statement() {
    if (strcmp(token, "EOF") == 0) return;

    if (strcmp(token, "print") == 0) {
        char t_name[16], t_arg[16];
        next_token(); expect("(");
        char val[64]; strcpy(val, token); next_token();
        expect(")");
        get_t(t_name, 16); get_t(t_arg, 16);
        emit("LOAD_NAME", "print", "_", t_name);
        emit("LOAD_FAST", val, "_", t_arg);
        emit("ARG_PUSH", t_arg, "0", "_");
        emit("CALL", t_name, "1", "_");
    } 
    else if (strcmp(token, "if") == 0) { /* 簡單處理 if */
        next_token(); // x
        char x[16]; strcpy(x, token); next_token(); // >
        next_token(); // 5
        char val[16]; strcpy(val, token); next_token(); expect(":");
        // ... 此處簡化處理 if 邏輯
    }
    else { // 變數賦值: x = 10 或 z = x + y
        char var[64]; strcpy(var, token); next_token();
        if (strcmp(token, "=") == 0) {
            next_token();
            // 處理 x = 10 或 x = y
            char val1[64]; strcpy(val1, token); next_token();
            if (strcmp(token, "+") == 0) { // 處理加法
                next_token(); char val2[64]; strcpy(val2, token); next_token();
                char t1[16], t2[16], t3[16];
                get_t(t1, 16); get_t(t2, 16); get_t(t3, 16);
                emit("LOAD_FAST", val1, "_", t1);
                emit("LOAD_FAST", val2, "_", t2);
                emit("ADD", t1, t2, t3);
                emit("STORE", t3, "_", var);
            } else { // 單純賦值
                char t[16]; get_t(t, 16);
                emit("LOAD_CONST", val1, "_", t);
                emit("STORE", t, "_", var);
            }
        }
    }
}

int main(int argc, char *argv[]) {
    if (argc < 4) return 1;
    in_fp = fopen(argv[1], "r");
    out_fp = fopen(argv[3], "w");
    next_token();
    while (strcmp(token, "EOF") != 0) {
        parse_statement();
    }
    fclose(in_fp); fclose(out_fp);
    return 0;
}