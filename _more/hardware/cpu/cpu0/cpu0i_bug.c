#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>

#define MEM_SIZE 65536
#define MAX_CODE 4096
#define MAX_LABEL 256
#define REGN 16

uint32_t code[MAX_CODE];
int code_size=0;

int R[REGN];
int ZF=0,NF=0;

int memory[MEM_SIZE];

typedef struct{
    char name[64];
    int addr;
}Label;

Label labels[MAX_LABEL];
int label_count=0;

char *trim(char *s)
{
    while(isspace(*s)) s++;
    char *end=s+strlen(s)-1;
    while(end>s && isspace(*end)) *end--=0;
    return s;
}

void remove_comment(char *s)
{
    char *p=strchr(s,';');
    if(p) *p=0;
}

int regid(char *s)
{
    if(s[0]=='R' || s[0]=='r')
        return atoi(s+1);
    return -1;
}

int find_label(char *name)
{
    for(int i=0;i<label_count;i++)
        if(strcmp(labels[i].name,name)==0)
            return labels[i].addr;

    printf("undefined label %s\n",name);
    exit(1);
}

void add_label(char *name,int addr)
{
    strcpy(labels[label_count].name,name);
    labels[label_count].addr=addr;
    label_count++;
}

uint32_t encodeA(int op,int ra,int rb,int rc)
{
    return (op<<24)|(ra<<20)|(rb<<16)|(rc<<12);
}

uint32_t encodeL(int op,int ra,int rb,int cx)
{
    return (op<<24)|(ra<<20)|(rb<<16)|(cx & 0xFFFF);
}

uint32_t encodeJ(int op,int cx)
{
    return (op<<24)|(cx & 0xFFFFFF);
}

void emitJ(int op, int addr)
{
    int pc = code_size;
    code[code_size++] = encodeJ(op, addr - pc);
}

/* opcode */
enum{
    OP_LDI  =0x08,
    OP_CMP  =0x10,
    OP_MOV  =0x12,
    OP_ADD  =0x13,
    OP_SUB  =0x14,
    OP_MUL  =0x15,
    OP_ADDI =0x1B,

    OP_JEQ  =0x20,
    OP_JNE  =0x21,
    OP_JMP  =0x26,
    OP_CALL =0x2B,
    OP_RET  =0x2C,

    OP_PUSH =0x30,
    OP_POP  =0x31
};

/* pass1 : collect labels */
void pass1(FILE *f)
{
    char line[256];
    int pc=0;

    while(fgets(line,256,f))
    {
        remove_comment(line);
        char *s=trim(line);
        if(strlen(s)==0) continue;

        char *p=strchr(s,':');
        if(p)
        {
            *p=0;
            add_label(trim(s),pc);
        }
        else
            pc++;
    }
}

/* parse register list */
int split(char *s,char *a,char *b,char *c)
{
    return sscanf(s,"%[^,],%[^,],%s",a,b,c);
}

/* pass2 : generate machine code */
void pass2(FILE *f)
{
    char line[256];

    while(fgets(line,256,f))
    {
        remove_comment(line);
        char *s=trim(line);
        if(strlen(s)==0) continue;

        if(strchr(s,':')) continue;

        char op[32],args[128];
        sscanf(s,"%s %[^\n]",op,args);

        char a[32],b[32],c[32];

        if(strcmp(op,"LDI")==0)
        {
            split(args,a,b,c);
            code[code_size++]=encodeL(OP_LDI,regid(a),0,atoi(b));
        }
        else if(strcmp(op,"MOV")==0)
        {
            split(args,a,b,c);
            code[code_size++]=encodeA(OP_MOV,regid(a),regid(b),0);
        }
        else if(strcmp(op,"ADD")==0)
        {
            split(args,a,b,c);
            code[code_size++]=encodeA(OP_ADD,regid(a),regid(b),regid(c));
        }
        else if(strcmp(op,"SUB")==0)
        {
            split(args,a,b,c);
            code[code_size++]=encodeA(OP_SUB,regid(a),regid(b),regid(c));
        }
        else if(strcmp(op,"MUL")==0)
        {
            split(args,a,b,c);
            code[code_size++]=encodeA(OP_MUL,regid(a),regid(b),regid(c));
        }
        else if(strcmp(op,"ADDI")==0)
        {
            split(args,a,b,c);
            code[code_size++]=encodeL(OP_ADDI,regid(a),regid(b),atoi(c));
        }
        else if(strcmp(op,"CMP")==0)
        {
            split(args,a,b,c);
            code[code_size++]=encodeA(OP_CMP,regid(a),regid(b),0);
        }
        else if(strcmp(op,"JMP")==0)
        {
            int addr=find_label(args);
            emitJ(OP_JMP, addr);
        }
        else if(strcmp(op,"JEQ")==0)
        {
            int addr=find_label(args);
            emitJ(OP_JEQ, addr);
        }
        else if(strcmp(op,"JNE")==0)
        {
            int addr=find_label(args);
            emitJ(OP_JNE, addr);
        }
        else if(strcmp(op,"CALL")==0)
        {
            int addr=find_label(args);
            emitJ(OP_CALL, addr);
        }
        else if(strcmp(op,"RET")==0)
        {
            code[code_size++]=encodeJ(OP_RET,0);
        }
        else if(strcmp(op,"PUSH")==0)
        {
            code[code_size++]=encodeA(OP_PUSH,regid(args),0,0);
        }
        else if(strcmp(op,"POP")==0)
        {
            code[code_size++]=encodeA(OP_POP,regid(args),0,0);
        }
    }
}

/* VM interpreter */
void vm()
{
    int pc=0;

    for(int i=0;i<code_size;i++)
        printf("%02d: %08x\n",i,code[i]);

    R[13]=MEM_SIZE; /* SP */

    while(pc < code_size)
    {
        uint32_t ins=code[pc++];
        printf("PC=%02d  %08x\n", pc, ins);

        int op=ins>>24;
        int ra=(ins>>20)&0xF;
        int rb=(ins>>16)&0xF;
        int rc=(ins>>12)&0xF;
        int cx=ins & 0xFFFF;
        int jx = ins & 0x00FFFFFF;
        if (jx & 0x00800000)
            jx |= 0xFF000000;

        switch(op)
        {
            case OP_LDI:
                R[ra]=cx;
                break;

            case OP_MOV:
                R[ra]=R[rb];
                break;

            case OP_ADD:
                R[ra]=R[rb]+R[rc];
                break;

            case OP_SUB:
                R[ra]=R[rb]-R[rc];
                break;

            case OP_MUL:
                R[ra]=R[rb]*R[rc];
                break;

            case OP_ADDI:
                R[ra]=R[rb]+cx;
                break;

            case OP_CMP:
                ZF=(R[ra]==R[rb]);
                NF=(R[ra]<R[rb]);
                break;

            case OP_JMP:
                pc+=jx;
                break;

            case OP_JEQ:
                if(ZF) pc+=jx;
                break;

            case OP_JNE:
                if(!ZF) pc+=jx;
                break;

            case OP_CALL:
                memory[--R[13]]=pc;
                pc+=jx;
                break;

            case OP_RET:
                pc=memory[R[13]++];
                break;

            case OP_PUSH:
                memory[--R[13]]=R[ra];
                break;

            case OP_POP:
                R[ra]=memory[R[13]++];
                break;

            default:
                printf("unknown opcode %02x\n",op);
                exit(1);
        }
    }
}

int main(int argc,char **argv)
{
    if(argc<2)
    {
        printf("usage: cpu0i program.s\n");
        return 0;
    }

    FILE *f=fopen(argv[1],"r");
    if(!f)
    {
        printf("cannot open %s\n",argv[1]);
        return 0;
    }

    pass1(f);
    rewind(f);
    pass2(f);
    fclose(f);

    printf("assembled %d instructions\n",code_size);

    vm();

    printf("\nRegisters:\n");
    for(int i=0;i<8;i++)
        printf("R%d = %d\n",i,R[i]);

    return 0;
}