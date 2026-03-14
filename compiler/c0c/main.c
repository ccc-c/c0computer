#include "codegen.h"
#include "lexer.h"
#include "parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
    if (argc != 4 || strcmp(argv[2], "-o") != 0) {
        fprintf(stderr, "用法: ./c0c <input.c> -o <output.ll>\n");
        return 1;
    }

    FILE *f = fopen(argv[1], "rb");
    if (!f) error("無法開啟輸入檔案");
    fseek(f, 0, SEEK_END);
    long fsize = ftell(f);
    fseek(f, 0, SEEK_SET);
    src = malloc(fsize + 1);
    fread(src, 1, fsize, f);
    src[fsize] = 0;
    fclose(f);

    FILE *out = fopen(argv[3], "w");
    if (!out) error("無法開啟輸出檔案");

    p = src;
    next_token();
    ASTNode *ast = parse_program();
    gen_llvm_ir(ast, out);

    printf("[成功] 已將 %s 編譯至 %s\n", argv[1], argv[3]);
    fclose(out);
    free(src);
    return 0;
}
