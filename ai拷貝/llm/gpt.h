#ifndef GPT_H
#define GPT_H

#include "nn.h"

// GPT 模型的超參數
extern int n_layer;
extern int n_embd;
extern int block_size;
extern int n_head;
extern int head_dim;

// 初始化 GPT 模型權重
void init_gpt(int vocab_size);

// GPT 前向傳播
Value** gpt_forward(int token_id, int pos_id, Value**** keys, Value**** values);

#endif // GPT_H