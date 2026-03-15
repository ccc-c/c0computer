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
void parse_program();
void parse_statement();
void emit(const char* op, const char* a, const char* b, const char* r);

#define TLEN 16
// 產生新的暫存器與標籤
// 修正後：使用 snprintf 並指定 buffer 大小
void get_t(char* buf) { 
    snprintf(buf, TLEN, "t%d", t_idx++); 
}

void get_l(char* buf) { 
    snprintf(buf, TLEN, "L_%d", l_idx++); 
}

void emit(const char* op, const char* a, const char* b, const char* r) {
    fprintf(out_fp, "%-15s %-10s %-3s %s\n", op, a, b, r);
}

// 簡單的詞法分析
void next_token() {
    int i = 0;
    int c = fgetc(in_fp);
    while (isspace(c)) c = fgetc(in_fp);
    if (c == EOF) { strcpy(token, "EOF"); return; }
    if (isalpha(c) || c == '_') {
        while (isalnum(c) || c == '_') { token[i++] = c; c = fgetc(in_fp); }
        ungetc(c, in_fp);
    } else if (isdigit(c)) {
        while (isdigit(c)) { token[i++] = c; c = fgetc(in_fp); }
        ungetc(c, in_fp);
    } else if (c == '"') {
        token[i++] = c; c = fgetc(in_fp);
        while (c != '"') { token[i++] = c; c = fgetc(in_fp); }
        token[i++] = '"';
    } else {
        token[i++] = c;
    }
    token[i] = '\0';
}

// 遞迴下降解析實作
void parse_statement() {
    if (strcmp(token, "print") == 0) {
        next_token(); // '('
        next_token(); // var/val
        char val[64], t[TLEN], t_arg[TLEN], t_name[TLEN];
        strcpy(val, token);
        get_t(t_name); get_t(t); get_t(t_arg);
        emit("LOAD_NAME", "print", "_", t_name);
        emit("LOAD_FAST", val, "_", t);
        emit("ARG_PUSH", t, "0", "_");
        emit("CALL", t_name, "1", "_");
        next_token(); // ')'
        next_token();
    } else if (strcmp(token, "while") == 0) {
        char loop[TLEN], end[TLEN], t1[TLEN], t2[TLEN], t3[TLEN], var[TLEN], val[TLEN];
        get_l(loop); get_l(end);
        next_token(); next_token(); strcpy(var, token); // i
        next_token(); // <
        next_token(); strcpy(val, token); // 5
        fprintf(out_fp, "LABEL %s\n", loop);
        get_t(t1); get_t(t2); get_t(t3);
        emit("LOAD_FAST", var, "_", t1);
        emit("LOAD_CONST", val, "_", t2);
        emit("CMP_GE", t1, t2, t3);
        emit("BRANCH_IF_TRUE", t3, "_", end);
        // 迴圈內容 (簡化處理)
        next_token(); next_token(); // : i
        // ... 此處省略複雜的 statement 遞迴邏輯以保持簡潔 ...
        fprintf(out_fp, "LABEL %s\n", end);
    } else {
        // 簡單賦值處理: x = 10
        char var[64]; strcpy(var, token);
        next_token(); // =
        next_token(); char val[64]; strcpy(val, token);
        char t[TLEN]; get_t(t);
        emit("LOAD_CONST", val, "_", t);
        emit("STORE", t, "_", var);
        next_token();
    }
}

int main(int argc, char *argv[]) {
    in_fp = fopen(argv[1], "r");
    out_fp = fopen(argv[3], "w");
    next_token();
    while (strcmp(token, "EOF") != 0) {
        parse_statement();
    }
    fclose(in_fp); fclose(out_fp);
    return 0;
}