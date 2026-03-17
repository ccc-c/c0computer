#include "ll0.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

Function functions[MAX_FUNCTIONS];
int      n_functions = 0;

/* ── Parser helpers ── */
static char *skip_ws(char *p){ while(*p==' '||*p=='\t') p++; return p; }

static char *read_token(char *p, char *buf, int sz) {
    p=skip_ws(p); int i=0;
    while(*p&&!isspace((unsigned char)*p)&&*p!=','&&*p!='('&&*p!=')'&&i<sz-1)
        buf[i++]=*p++;
    buf[i]=0; return p;
}

static void rstrip(char *s){
    int n=strlen(s);
    while(n>0&&(s[n-1]=='\n'||s[n-1]=='\r'||s[n-1]==' '||s[n-1]=='\t')) s[--n]=0;
}

static Value parse_value(const char *tok){
    Value v; memset(&v,0,sizeof v);
    if(tok[0]=='%'){v.kind=VK_REG;strncpy(v.name,tok,MAX_NAME-1);}
    else{char*e;long n=strtol(tok,&e,10);
         if(e!=tok){v.kind=VK_IMM;v.imm=(int32_t)n;}
         else{v.kind=VK_REG;strncpy(v.name,tok,MAX_NAME-1);}}
    return v;
}

/* parse "type [noundef] value" */
static char *parse_arg(char *p, Value *v){
    char t[MAX_NAME];
    p=skip_ws(p); p=read_token(p,t,sizeof t); /* type */
    p=skip_ws(p);
    if(*p==','||*p==')'||!*p){*v=parse_value(t);return p;}
    char t2[MAX_NAME]; p=read_token(p,t2,sizeof t2);
    p=skip_ws(p);
    if(!strcmp(t2,"noundef")){char t3[MAX_NAME];p=read_token(p,t3,sizeof t3);*v=parse_value(t3);}
    else *v=parse_value(t2);
    return p;
}

static Block *get_block(Function *fn, const char *name){
    for(int i=0;i<fn->n_blocks;i++) if(!strcmp(fn->blocks[i].name,name)) return &fn->blocks[i];
    Block *b=&fn->blocks[fn->n_blocks++];
    strncpy(b->name,name,MAX_NAME-1); b->n_instrs=0;
    return b;
}

/* ── Main parser ── */
void parse_ll(FILE *fp){
    char line[MAX_LINE];
    Function *cur_fn=NULL;
    Block    *cur_blk=NULL;

    while(fgets(line,sizeof line,fp)){
        rstrip(line);
        char *p=line; p=skip_ws(p);
        if(!*p||*p==';') continue;

        if(!strncmp(p,"define ",7)){
            cur_fn=&functions[n_functions++];
            memset(cur_fn,0,sizeof *cur_fn);
            cur_blk=NULL;
            char *at=strchr(p,'@'); if(!at) continue; at++;
            char *par=strchr(at,'('); if(!par) continue;
            int len=par-at; if(len>=MAX_NAME)len=MAX_NAME-1;
            strncpy(cur_fn->name,at,len); cur_fn->name[len]=0;

            char abuf[MAX_LINE]; char *ae=strchr(par+1,')');
            if(!ae) continue;
            int alen=ae-(par+1); if(alen>=(int)sizeof(abuf))alen=sizeof(abuf)-1;
            strncpy(abuf,par+1,alen); abuf[alen]=0;
            char *ap=abuf;
            while(*ap){
                ap=skip_ws(ap); if(!*ap) break;
                char t1[MAX_NAME]; ap=read_token(ap,t1,sizeof t1); if(!t1[0]) break;
                ap=skip_ws(ap);
                char t2[MAX_NAME]; ap=read_token(ap,t2,sizeof t2);
                if(!strcmp(t2,"noundef")){char t3[MAX_NAME];ap=read_token(ap,t3,sizeof t3);
                    if(t3[0]=='%') strncpy(cur_fn->arg_names[cur_fn->n_args++],t3,MAX_NAME-1);}
                else{if(t2[0]=='%') strncpy(cur_fn->arg_names[cur_fn->n_args++],t2,MAX_NAME-1);}
                ap=skip_ws(ap); if(*ap==',') ap++;
            }
            continue;
        }

        if(*p=='}'){cur_fn=NULL;cur_blk=NULL;continue;}
        if(!cur_fn) continue;

        /* detect block label "N:" */
        {
            char ltok[MAX_NAME]; int li=0; char *lp=p;
            while(*lp&&*lp!=':'&&!isspace((unsigned char)*lp)&&li<MAX_NAME-1) ltok[li++]=*lp++;
            ltok[li]=0;
            if(*lp==':'&&li>0){cur_blk=get_block(cur_fn,ltok);continue;}
        }

        if(!cur_blk) cur_blk=get_block(cur_fn,"entry");

        Instr ins; memset(&ins,0,sizeof ins);
        char tok[MAX_NAME];

        if(*p=='%'){
            char *eq=strstr(p," = "); if(!eq) continue;
            int dlen=eq-p; if(dlen>=MAX_NAME)dlen=MAX_NAME-1;
            strncpy(ins.dst,p,dlen); ins.dst[dlen]=0;
            p=eq+3;
        }
        p=skip_ws(p); p=read_token(p,tok,sizeof tok);

        if(!strcmp(tok,"alloca")){
            ins.op=OP_ALLOCA;
            cur_blk->instrs[cur_blk->n_instrs++]=ins;
            continue;
        }
        if(!strcmp(tok,"store")){
            ins.op=OP_STORE; ins.dst[0]=0;
            char t[MAX_NAME]; p=read_token(p,t,sizeof t);
            p=skip_ws(p);
            char vt[MAX_NAME]; p=read_token(p,vt,sizeof vt);
            if(!strcmp(vt,"noundef")) p=read_token(p,vt,sizeof vt);
            ins.src[0]=parse_value(vt);
            p=skip_ws(p); if(*p==',') p++;
            p=read_token(p,t,sizeof t); /* ptr */
            p=skip_ws(p);
            char pt[MAX_NAME]; p=read_token(p,pt,sizeof pt);
            ins.src[1]=parse_value(pt);
            cur_blk->instrs[cur_blk->n_instrs++]=ins;
            continue;
        }
        if(!strcmp(tok,"load")){
            ins.op=OP_LOAD;
            char t[MAX_NAME]; p=read_token(p,t,sizeof t);
            p=skip_ws(p); if(*p==',') p++;
            p=read_token(p,t,sizeof t); /* ptr */
            p=skip_ws(p);
            char pt[MAX_NAME]; p=read_token(p,pt,sizeof pt);
            pt[strcspn(pt,",")]=0;
            ins.src[0]=parse_value(pt);
            cur_blk->instrs[cur_blk->n_instrs++]=ins;
            continue;
        }
        if(!strcmp(tok,"icmp")){
            ins.op=OP_ICMP;
            char pr[MAX_NAME]; p=read_token(p,pr,sizeof pr);
            if(!strcmp(pr,"eq"))ins.pred=PRED_EQ;
            else if(!strcmp(pr,"ne"))ins.pred=PRED_NE;
            else if(!strcmp(pr,"slt"))ins.pred=PRED_SLT;
            else if(!strcmp(pr,"sle"))ins.pred=PRED_SLE;
            else if(!strcmp(pr,"sgt"))ins.pred=PRED_SGT;
            else if(!strcmp(pr,"sge"))ins.pred=PRED_SGE;
            char t[MAX_NAME]; p=read_token(p,t,sizeof t);
            p=skip_ws(p);
            char a[MAX_NAME]; p=read_token(p,a,sizeof a); a[strcspn(a,",")]=0;
            ins.src[0]=parse_value(a);
            p=skip_ws(p); if(*p==',') p++;
            char b[MAX_NAME]; p=read_token(p,b,sizeof b);
            ins.src[1]=parse_value(b);
            cur_blk->instrs[cur_blk->n_instrs++]=ins;
            continue;
        }
        if(!strcmp(tok,"br")){
            p=skip_ws(p);
            char t2[MAX_NAME]; p=read_token(p,t2,sizeof t2);
            if(!strcmp(t2,"label")){
                ins.op=OP_JMP;
                char lt[MAX_NAME]; p=read_token(p,lt,sizeof lt);
                strncpy(ins.jmp_label, lt[0]=='%'?lt+1:lt, MAX_NAME-1);
            } else {
                ins.op=OP_BR;
                char ct[MAX_NAME]; p=read_token(p,ct,sizeof ct); ct[strcspn(ct,",")]=0;
                ins.src[0]=parse_value(ct);
                p=skip_ws(p); if(*p==',') p++;
                p=read_token(p,t2,sizeof t2); /* label */
                char lt[MAX_NAME]; p=read_token(p,lt,sizeof lt); lt[strcspn(lt,",")]=0;
                strncpy(ins.true_label,  lt[0]=='%'?lt+1:lt, MAX_NAME-1);
                p=skip_ws(p); if(*p==',') p++;
                p=read_token(p,t2,sizeof t2); /* label */
                char lf[MAX_NAME]; p=read_token(p,lf,sizeof lf);
                strncpy(ins.false_label, lf[0]=='%'?lf+1:lf, MAX_NAME-1);
            }
            cur_blk->instrs[cur_blk->n_instrs++]=ins;
            continue;
        }
        if(!strcmp(tok,"add")||!strcmp(tok,"sub")||!strcmp(tok,"mul")){
            ins.op= !strcmp(tok,"add")?OP_ADD:!strcmp(tok,"sub")?OP_SUB:OP_MUL;
            char t[MAX_NAME]; p=read_token(p,t,sizeof t);
            if(!strcmp(t,"nsw")||!strcmp(t,"nuw")) p=read_token(p,t,sizeof t);
            p=skip_ws(p);
            char a[MAX_NAME]; p=read_token(p,a,sizeof a); a[strcspn(a,",")]=0;
            ins.src[0]=parse_value(a);
            p=skip_ws(p); if(*p==',') p++;
            char b[MAX_NAME]; p=read_token(p,b,sizeof b);
            ins.src[1]=parse_value(b);
            cur_blk->instrs[cur_blk->n_instrs++]=ins;
            continue;
        }
        if(!strcmp(tok,"call")){
            ins.op=OP_CALL;
            char rt[MAX_NAME]; p=read_token(p,rt,sizeof rt);
            p=skip_ws(p);
            char cn[MAX_NAME]; p=read_token(p,cn,sizeof cn);
            char *par2=strchr(cn,'('); if(par2)*par2=0;
            strncpy(ins.callee, cn[0]=='@'?cn+1:cn, MAX_NAME-1);
            p=skip_ws(p); if(*p=='(') p++;
            ins.call_argc=0;
            while(*p&&*p!=')'){
                p=skip_ws(p); if(*p==')') break;
                Value v; p=parse_arg(p,&v);
                ins.call_args[ins.call_argc++]=v;
                p=skip_ws(p); if(*p==',') p++;
            }
            cur_blk->instrs[cur_blk->n_instrs++]=ins;
            continue;
        }
        if(!strcmp(tok,"ret")){
            ins.op=OP_RET;
            char rt[MAX_NAME]; p=read_token(p,rt,sizeof rt);
            p=skip_ws(p);
            if(*p&&strcmp(rt,"void")!=0){
                char vt[MAX_NAME]; p=read_token(p,vt,sizeof vt);
                ins.src[0]=parse_value(vt);
            }
            cur_blk->instrs[cur_blk->n_instrs++]=ins;
            continue;
        }
    }
}
