#ifndef LL0_H
#define LL0_H

#include <stdio.h>
#include <stdint.h>

#define MAX_FUNCTIONS   64
#define MAX_BLOCKS      128
#define MAX_INSTRS      512
#define MAX_ARGS        16
#define MAX_LINE        1024
#define MAX_NAME        128

typedef enum {
    OP_ALLOCA, OP_STORE, OP_LOAD, OP_ICMP,
    OP_BR, OP_JMP, OP_ADD, OP_SUB, OP_MUL,
    OP_CALL, OP_RET,
} Opcode;

typedef enum { PRED_EQ, PRED_NE, PRED_SLT, PRED_SLE, PRED_SGT, PRED_SGE } Pred;
typedef enum { VK_IMM, VK_REG } VKind;

typedef struct {
    VKind kind;
    int32_t imm;
    char name[MAX_NAME];
} Value;

typedef struct {
    Opcode op;
    char   dst[MAX_NAME];
    Value  src[3];
    Pred   pred;
    char   true_label[MAX_NAME];
    char   false_label[MAX_NAME];
    char   jmp_label[MAX_NAME];
    char   callee[MAX_NAME];
    Value  call_args[MAX_ARGS];
    int    call_argc;
} Instr;

typedef struct {
    char  name[MAX_NAME];
    Instr instrs[MAX_INSTRS];
    int   n_instrs;
} Block;

typedef struct {
    char  name[MAX_NAME];
    char  arg_names[MAX_ARGS][MAX_NAME];
    int   n_args;
    Block blocks[MAX_BLOCKS];
    int   n_blocks;
} Function;

extern Function functions[MAX_FUNCTIONS];
extern int      n_functions;

void parse_ll(FILE *fp);

#endif // LL0_H
