#include "../ll0.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define PROLOGUE_SIZE 256

typedef struct {
    char name[MAX_NAME];
    int offset;
} VarMap;

static VarMap varmap[128];
static int n_vars = 0;
static int curr_offset = -24;

static void reset_varmap() {
    n_vars = 0;
    curr_offset = -24;
}

static int get_offset(const char *name) {
    for (int i = 0; i < n_vars; i++) {
        if (!strcmp(varmap[i].name, name)) return varmap[i].offset;
    }
    if (n_vars >= 128) {
        fprintf(stderr, "Too many variables\n");
        exit(1);
    }
    int off = curr_offset;
    strcpy(varmap[n_vars].name, name);
    varmap[n_vars].offset = off;
    n_vars++;
    curr_offset -= 8;
    return off;
}

static void load_value(FILE *out, Value *v, const char *reg) {
    if (v->kind == VK_IMM) {
        fprintf(out, "    li %s, %d\n", reg, v->imm);
    } else {
        int off = get_offset(v->name);
        fprintf(out, "    ld %s, %d(s0)\n", reg, off);
    }
}

static void compile_function(FILE *out, Function *fn) {
    reset_varmap();

    fprintf(out, "\n.global %s\n", fn->name);
    fprintf(out, "%s:\n", fn->name);
    fprintf(out, "    addi sp, sp, -%d\n", PROLOGUE_SIZE);
    fprintf(out, "    sd ra, %d(sp)\n", PROLOGUE_SIZE - 8);
    fprintf(out, "    sd s0, %d(sp)\n", PROLOGUE_SIZE - 16);
    fprintf(out, "    addi s0, sp, %d\n", PROLOGUE_SIZE);

    for (int i = 0; i < fn->n_args; i++) {
        int off = get_offset(fn->arg_names[i]);
        fprintf(out, "    sd a%d, %d(s0)\n", i, off);
    }

    for (int b = 0; b < fn->n_blocks; b++) {
        Block *blk = &fn->blocks[b];
        fprintf(out, ".L_%s_%s:\n", fn->name, blk->name);

        for (int i = 0; i < blk->n_instrs; i++) {
            Instr *ins = &blk->instrs[i];
            
            switch (ins->op) {
                case OP_ALLOCA: {
                    int ptr_off = get_offset(ins->dst);
                    int mem_off = curr_offset;
                    curr_offset -= 8;
                    fprintf(out, "    addi t0, s0, %d\n", mem_off);
                    fprintf(out, "    sd t0, %d(s0)\n", ptr_off);
                    break;
                }
                case OP_STORE: {
                    load_value(out, &ins->src[0], "t0");
                    load_value(out, &ins->src[1], "t1");
                    fprintf(out, "    sd t0, 0(t1)\n");
                    break;
                }
                case OP_LOAD: {
                    load_value(out, &ins->src[0], "t1");
                    fprintf(out, "    ld t0, 0(t1)\n");
                    int dst_off = get_offset(ins->dst);
                    fprintf(out, "    sd t0, %d(s0)\n", dst_off);
                    break;
                }
                case OP_ICMP: {
                    load_value(out, &ins->src[0], "t0");
                    load_value(out, &ins->src[1], "t1");
                    switch (ins->pred) {
                        case PRED_EQ:  fprintf(out, "    sub t0, t0, t1\n    seqz t0, t0\n"); break;
                        case PRED_NE:  fprintf(out, "    sub t0, t0, t1\n    snez t0, t0\n"); break;
                        case PRED_SLT: fprintf(out, "    slt t0, t0, t1\n"); break;
                        case PRED_SGT: fprintf(out, "    slt t0, t1, t0\n"); break;
                        case PRED_SLE: fprintf(out, "    slt t0, t1, t0\n    xori t0, t0, 1\n"); break;
                        case PRED_SGE: fprintf(out, "    slt t0, t0, t1\n    xori t0, t0, 1\n"); break;
                    }
                    int dst_off = get_offset(ins->dst);
                    fprintf(out, "    sd t0, %d(s0)\n", dst_off);
                    break;
                }
                case OP_ADD:
                case OP_SUB:
                case OP_MUL: {
                    load_value(out, &ins->src[0], "t0");
                    load_value(out, &ins->src[1], "t1");
                    if (ins->op == OP_ADD) fprintf(out, "    add t0, t0, t1\n");
                    else if (ins->op == OP_SUB) fprintf(out, "    sub t0, t0, t1\n");
                    else if (ins->op == OP_MUL) fprintf(out, "    mul t0, t0, t1\n");
                    int dst_off = get_offset(ins->dst);
                    fprintf(out, "    sd t0, %d(s0)\n", dst_off);
                    break;
                }
                case OP_BR: {
                    load_value(out, &ins->src[0], "t0");
                    fprintf(out, "    bnez t0, .L_%s_%s\n", fn->name, ins->true_label);
                    fprintf(out, "    j .L_%s_%s\n", fn->name, ins->false_label);
                    break;
                }
                case OP_JMP: {
                    fprintf(out, "    j .L_%s_%s\n", fn->name, ins->jmp_label);
                    break;
                }
                case OP_CALL: {
                    for (int a = 0; a < ins->call_argc; a++) {
                        load_value(out, &ins->call_args[a], "t0");
                        fprintf(out, "    mv a%d, t0\n", a);
                    }
                    fprintf(out, "    call %s\n", ins->callee);
                    if (ins->dst[0]) {
                        int dst_off = get_offset(ins->dst);
                        fprintf(out, "    sd a0, %d(s0)\n", dst_off);
                    }
                    break;
                }
                case OP_RET: {
                    if (ins->src[0].kind == VK_IMM || ins->src[0].name[0]) {
                        load_value(out, &ins->src[0], "a0");
                    }
                    fprintf(out, "    j %s_epilogue\n", fn->name);
                    break;
                }
            }
        }
    }

    fprintf(out, "%s_epilogue:\n", fn->name);
    fprintf(out, "    ld ra, %d(sp)\n", PROLOGUE_SIZE - 8);
    fprintf(out, "    ld s0, %d(sp)\n", PROLOGUE_SIZE - 16);
    fprintf(out, "    addi sp, sp, %d\n", PROLOGUE_SIZE);
    fprintf(out, "    ret\n");
}

int main(int argc, char **argv) {
    char *in_filename = NULL;
    char *out_filename = NULL;

    // 解析命令列參數
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-o") == 0) {
            if (i + 1 < argc) {
                out_filename = argv[++i];
            } else {
                fprintf(stderr, "Error: Missing output file after -o\n");
                return 1;
            }
        } else {
            in_filename = argv[i];
        }
    }

    if (!in_filename || !out_filename) {
        fprintf(stderr, "Usage: %s <file.ll> -o <file.s>\n", argv[0]);
        return 1;
    }

    FILE *in_fp = fopen(in_filename, "r");
    if (!in_fp) {
        perror(in_filename);
        return 1;
    }
    parse_ll(in_fp);
    fclose(in_fp);

    FILE *out_fp = fopen(out_filename, "w");
    if (!out_fp) {
        perror(out_filename);
        return 1;
    }

    fprintf(out_fp, ".text\n");
    for (int i = 0; i < n_functions; i++) {
        compile_function(out_fp, &functions[i]);
    }
    
    fclose(out_fp);
    return 0;
}