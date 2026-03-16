#include <math.h>
#include "gpt.h"

// 超參數定義
int n_layer = 1;
int n_embd = 16;
int block_size = 16;
int n_head = 4;
int head_dim = 0;

// 模型權重矩陣
static Matrix wte, wpe, lm_head;
static Matrix attn_wq[10], attn_wk[10], attn_wv[10], attn_wo[10];
static Matrix mlp_fc1[10], mlp_fc2[10];

void init_gpt(int vocab_size) {
    head_dim = n_embd / n_head;
    
    wte = create_matrix(vocab_size, n_embd, 0.08);
    wpe = create_matrix(block_size, n_embd, 0.08);
    lm_head = create_matrix(vocab_size, n_embd, 0.08);
    
    for (int i = 0; i < n_layer; i++) {
        attn_wq[i] = create_matrix(n_embd, n_embd, 0.08);
        attn_wk[i] = create_matrix(n_embd, n_embd, 0.08);
        attn_wv[i] = create_matrix(n_embd, n_embd, 0.08);
        attn_wo[i] = create_matrix(n_embd, n_embd, 0.08);
        mlp_fc1[i] = create_matrix(4 * n_embd, n_embd, 0.08);
        mlp_fc2[i] = create_matrix(n_embd, 4 * n_embd, 0.08);
    }
}

Value** gpt_forward(int token_id, int pos_id, Value**** keys, Value**** values) {
    Value** x = arena_alloc(n_embd * sizeof(Value*));
    for (int i = 0; i < n_embd; i++) x[i] = add(wte.data[token_id][i], wpe.data[pos_id][i]);
    x = rmsnorm(x, n_embd);

    for (int li = 0; li < n_layer; li++) {
        // Multi-head Attention
        Value** x_residual = x;
        x = rmsnorm(x, n_embd);
        Value** q = linear(x, n_embd, attn_wq[li]);
        Value** k = linear(x, n_embd, attn_wk[li]);
        Value** v = linear(x, n_embd, attn_wv[li]);
        
        keys[li][pos_id] = k;
        values[li][pos_id] = v;
        
        Value** x_attn = arena_alloc(n_embd * sizeof(Value*));
        int len_seq = pos_id + 1;
        
        for (int h = 0; h < n_head; h++) {
            int hs = h * head_dim;
            Value** attn_logits = arena_alloc(len_seq * sizeof(Value*));
            for (int t = 0; t < len_seq; t++) {
                Value* sum = new_value(0.0);
                for (int j = 0; j < head_dim; j++) sum = add(sum, mul(q[hs + j], keys[li][t][hs + j]));
                attn_logits[t] = div_v(sum, new_value(sqrt((double)head_dim)));
            }
            Value** attn_weights = softmax_v(attn_logits, len_seq);
            
            for (int j = 0; j < head_dim; j++) {
                Value* sum = new_value(0.0);
                for (int t = 0; t < len_seq; t++) sum = add(sum, mul(attn_weights[t], values[li][t][hs + j]));
                x_attn[hs + j] = sum;
            }
        }
        x = linear(x_attn, n_embd, attn_wo[li]);
        Value** x_res1 = arena_alloc(n_embd * sizeof(Value*));
        for (int i = 0; i < n_embd; i++) x_res1[i] = add(x[i], x_residual[i]);
        x = x_res1;
        
        // MLP block
        Value** x_residual_mlp = x;
        x = rmsnorm(x, n_embd);
        x = linear(x, n_embd, mlp_fc1[li]);
        Value** x_relu = arena_alloc(4 * n_embd * sizeof(Value*));
        for (int i = 0; i < 4 * n_embd; i++) x_relu[i] = v_relu(x[i]);
        x = linear(x_relu, 4 * n_embd, mlp_fc2[li]);
        Value** x_res2 = arena_alloc(n_embd * sizeof(Value*));
        for (int i = 0; i < n_embd; i++) x_res2[i] = add(x[i], x_residual_mlp[i]);
        x = x_res2;
    }
    return linear(x, n_embd, lm_head);
}