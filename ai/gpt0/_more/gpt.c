/*
 * MicroGPT translated to C (UTF-8 Character-Level Support)
 * Original Python code by @karpathy
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>

// ----------------------------------------------------------------------------
// Config & Constants
// ----------------------------------------------------------------------------
#define MAX_DOCS 100000
#define MAX_PARAMS 100000
#define MAX_VOCAB 10000                 // 支援最大詞彙量
#define ARENA_BYTES (1024 * 1024 * 128) // 128 MB Arena for computation graph
#define MAX_NODES 1000000               // Max nodes in topological sort

// ----------------------------------------------------------------------------
// Arena Allocator
// ----------------------------------------------------------------------------
char* arena_mem;
size_t arena_offset = 0;

void arena_reset() {
    arena_offset = 0;
}

void* arena_alloc(size_t size) {
    size = (size + 7) & ~7; // 8-byte alignment
    if (arena_offset + size > ARENA_BYTES) {
        fprintf(stderr, "Out of memory in arena\n");
        exit(1);
    }
    void* ptr = arena_mem + arena_offset;
    arena_offset += size;
    return ptr;
}

// ----------------------------------------------------------------------------
// Autograd Engine (Value)
// ----------------------------------------------------------------------------
typedef struct Value {
    double data;
    double grad;
    struct Value* child1;
    struct Value* child2;
    double local_grad1;
    double local_grad2;
    int visited;
} Value;

Value* new_value(double data) {
    Value* v = arena_alloc(sizeof(Value));
    v->data = data;
    v->grad = 0.0;
    v->child1 = NULL;
    v->child2 = NULL;
    v->local_grad1 = 0.0;
    v->local_grad2 = 0.0;
    v->visited = 0;
    return v;
}

Value* params[MAX_PARAMS];
int num_params = 0;

Value* new_param(double data) {
    Value* v = malloc(sizeof(Value));
    v->data = data;
    v->grad = 0.0;
    v->child1 = NULL;
    v->child2 = NULL;
    v->visited = 0;
    params[num_params++] = v;
    return v;
}

Value* add(Value* a, Value* b) {
    Value* out = new_value(a->data + b->data);
    out->child1 = a;
    out->child2 = b;
    out->local_grad1 = 1.0;
    out->local_grad2 = 1.0;
    return out;
}

Value* mul(Value* a, Value* b) {
    Value* out = new_value(a->data * b->data);
    out->child1 = a;
    out->child2 = b;
    out->local_grad1 = b->data;
    out->local_grad2 = a->data;
    return out;
}

Value* power(Value* a, double b) {
    Value* out = new_value(pow(a->data, b));
    out->child1 = a;
    out->local_grad1 = b * pow(a->data, b - 1.0);
    return out;
}

Value* v_log(Value* a) {
    Value* out = new_value(log(a->data));
    out->child1 = a;
    out->local_grad1 = 1.0 / a->data;
    return out;
}

Value* v_exp(Value* a) {
    Value* out = new_value(exp(a->data));
    out->child1 = a;
    out->local_grad1 = exp(a->data);
    return out;
}

Value* v_relu(Value* a) {
    Value* out = new_value(a->data > 0 ? a->data : 0);
    out->child1 = a;
    out->local_grad1 = a->data > 0 ? 1.0 : 0.0;
    return out;
}

Value* neg(Value* a) {
    Value* out = new_value(-a->data);
    out->child1 = a;
    out->local_grad1 = -1.0;
    return out;
}

Value* div_v(Value* a, Value* b) {
    Value* out = new_value(a->data / b->data);
    out->child1 = a;
    out->child2 = b;
    out->local_grad1 = 1.0 / b->data;
    out->local_grad2 = -a->data / (b->data * b->data);
    return out;
}

Value** topo;

void build_topo(Value* v, int* topo_idx) {
    if (!v->visited) {
        v->visited = 1;
        if (v->child1) build_topo(v->child1, topo_idx);
        if (v->child2) build_topo(v->child2, topo_idx);
        if (*topo_idx >= MAX_NODES) {
            fprintf(stderr, "MAX_NODES exceeded in topological sort\n");
            exit(1);
        }
        topo[(*topo_idx)++] = v;
    }
}

void backward(Value* root) {
    int topo_idx = 0;
    build_topo(root, &topo_idx);
    
    root->grad = 1.0;
    for (int i = topo_idx - 1; i >= 0; i--) {
        Value* v = topo[i];
        if (v->child1) v->child1->grad += v->local_grad1 * v->grad;
        if (v->child2) v->child2->grad += v->local_grad2 * v->grad;
    }
}

// ----------------------------------------------------------------------------
// Data handling & Random utilities (UTF-8)
// ----------------------------------------------------------------------------
char* docs[MAX_DOCS];
int num_docs = 0;

char vocab_str[MAX_VOCAB][5]; // 每個 Token 最多佔 4 byte + '\0'
int vocab_size = 0;
int BOS = 0;

int get_utf8_len(unsigned char c) {
    if ((c & 0x80) == 0x00) return 1; // 1-byte (ASCII)
    if ((c & 0xE0) == 0xC0) return 2; // 2-byte
    if ((c & 0xF0) == 0xE0) return 3; // 3-byte (大部分中文字)
    if ((c & 0xF8) == 0xF0) return 4; // 4-byte (Emoji 等)
    return 1; // Fallback
}

int get_token_id(const char* str) {
    for (int i = 0; i < vocab_size; i++) {
        if (strcmp(vocab_str[i], str) == 0) return i;
    }
    if (vocab_size >= MAX_VOCAB) {
        fprintf(stderr, "MAX_VOCAB exceeded\n");
        exit(1);
    }
    strcpy(vocab_str[vocab_size], str);
    return vocab_size++;
}

void load_data() {
    FILE* f = fopen("input.txt", "r");
    if (!f) {
        printf("Downloading input.txt...\n");
        int ret = system("wget -qO input.txt https://raw.githubusercontent.com/karpathy/makemore/988aa59/names.txt || curl -so input.txt https://raw.githubusercontent.com/karpathy/makemore/988aa59/names.txt");
        if (ret != 0) {
            printf("Failed to download input.txt\n");
            exit(1);
        }
        f = fopen("input.txt", "r");
        if (!f) {
            printf("Still cannot open input.txt\n");
            exit(1);
        }
    }
    char line[256];
    while (fgets(line, sizeof(line), f)) {
        int len = strlen(line);
        while (len > 0 && (line[len-1] == '\n' || line[len-1] == '\r')) {
            line[len-1] = '\0';
            len--;
        }
        if (len > 0) docs[num_docs++] = strdup(line);
    }
    fclose(f);
}

void build_vocab() {
    vocab_size = 0;
    for (int i = 0; i < num_docs; i++) {
        int j = 0;
        int len = strlen(docs[i]);
        while (j < len) {
            int char_len = get_utf8_len((unsigned char)docs[i][j]);
            char temp[5] = {0};
            strncpy(temp, &docs[i][j], char_len);
            get_token_id(temp);
            j += char_len;
        }
    }
    BOS = vocab_size;
    strcpy(vocab_str[BOS], "<BOS>");
    vocab_size++; // +1 for BOS
    printf("vocab size: %d\n", vocab_size);
}

int* tokenize(const char* doc, int* out_len) {
    int max_tokens = strlen(doc) + 2; 
    int* tokens = malloc(max_tokens * sizeof(int));
    int count = 0;
    tokens[count++] = BOS;

    int j = 0;
    int len = strlen(doc);
    while (j < len) {
        int char_len = get_utf8_len((unsigned char)doc[j]);
        char temp[5] = {0};
        strncpy(temp, &doc[j], char_len);
        tokens[count++] = get_token_id(temp);
        j += char_len;
    }
    tokens[count++] = BOS;
    *out_len = count;
    return tokens;
}

double gauss(double mean, double std) {
    static int has_spare = 0;
    static double spare;
    if (has_spare) {
        has_spare = 0;
        return mean + std * spare;
    }
    has_spare = 1;
    double u, v, s;
    do {
        u = ((double)rand() / RAND_MAX) * 2.0 - 1.0;
        v = ((double)rand() / RAND_MAX) * 2.0 - 1.0;
        s = u * u + v * v;
    } while (s >= 1.0 || s == 0.0);
    s = sqrt(-2.0 * log(s) / s);
    spare = v * s;
    return mean + std * (u * s);
}

int random_choice(double* weights, int size) {
    double sum = 0;
    for (int i = 0; i < size; i++) sum += weights[i];
    double r = ((double)rand() / RAND_MAX) * sum;
    double acc = 0;
    for (int i = 0; i < size; i++) {
        acc += weights[i];
        if (r <= acc) return i;
    }
    return size - 1;
}

// ----------------------------------------------------------------------------
// Matrix & Model Architecture
// ----------------------------------------------------------------------------
typedef struct {
    int rows;
    int cols;
    Value*** data; // data[row][col]
} Matrix;

Matrix create_matrix(int rows, int cols, double std) {
    Matrix m;
    m.rows = rows;
    m.cols = cols;
    m.data = malloc(rows * sizeof(Value**));
    for (int i = 0; i < rows; i++) {
        m.data[i] = malloc(cols * sizeof(Value*));
        for (int j = 0; j < cols; j++) m.data[i][j] = new_param(gauss(0, std));
    }
    return m;
}

int n_layer = 1, n_embd = 16, block_size = 16, n_head = 4;
int head_dim;

Matrix wte, wpe, lm_head;
Matrix attn_wq[10], attn_wk[10], attn_wv[10], attn_wo[10];
Matrix mlp_fc1[10], mlp_fc2[10];

Value** linear(Value** x, int x_len, Matrix w) {
    Value** out = arena_alloc(w.rows * sizeof(Value*));
    for (int i = 0; i < w.rows; i++) {
        Value* sum = new_value(0.0);
        for (int j = 0; j < x_len; j++) {
            sum = add(sum, mul(w.data[i][j], x[j]));
        }
        out[i] = sum;
    }
    return out;
}

Value** softmax_v(Value** logits, int len) {
    double max_val = logits[0]->data;
    for (int i = 1; i < len; i++) {
        if (logits[i]->data > max_val) max_val = logits[i]->data;
    }
    Value** exps = arena_alloc(len * sizeof(Value*));
    Value* total = new_value(0.0);
    for (int i = 0; i < len; i++) {
        exps[i] = v_exp(add(logits[i], new_value(-max_val)));
        total = add(total, exps[i]);
    }
    Value** out = arena_alloc(len * sizeof(Value*));
    for (int i = 0; i < len; i++) out[i] = div_v(exps[i], total);
    return out;
}

Value** rmsnorm(Value** x, int len) {
    Value* ms = new_value(0.0);
    for (int i = 0; i < len; i++) ms = add(ms, mul(x[i], x[i]));
    ms = div_v(ms, new_value((double)len));
    Value* scale = power(add(ms, new_value(1e-5)), -0.5);
    
    Value** out = arena_alloc(len * sizeof(Value*));
    for (int i = 0; i < len; i++) out[i] = mul(x[i], scale);
    return out;
}

Value** gpt(int token_id, int pos_id, Value**** keys, Value**** values) {
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

// ----------------------------------------------------------------------------
// Main Routine
// ----------------------------------------------------------------------------
int main() {
    srand(42);
    arena_mem = malloc(ARENA_BYTES);
    topo = malloc(MAX_NODES * sizeof(Value*));
    head_dim = n_embd / n_head;

    load_data();
    // 打亂資料庫
    for (int i = num_docs - 1; i > 0; i--) {
        int j = rand() % (i + 1);
        char* temp = docs[i]; docs[i] = docs[j]; docs[j] = temp;
    }
    printf("num docs: %d\n", num_docs);
    build_vocab();

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
    printf("num params: %d\n", num_params);

    double learning_rate = 0.01, beta1 = 0.85, beta2 = 0.99, eps_adam = 1e-8;
    double* m_adam = calloc(num_params, sizeof(double));
    double* v_adam = calloc(num_params, sizeof(double));

    int num_steps = 1000;
    for (int step = 0; step < num_steps; step++) {
        int out_len;
        int* tokens = tokenize(docs[step % num_docs], &out_len);
        int n = block_size < (out_len - 1) ? block_size : (out_len - 1);

        Value**** keys = arena_alloc(n_layer * sizeof(Value***));
        Value**** values = arena_alloc(n_layer * sizeof(Value***));
        for (int i = 0; i < n_layer; i++) {
            keys[i] = arena_alloc(block_size * sizeof(Value**));
            values[i] = arena_alloc(block_size * sizeof(Value**));
        }

        Value* loss = new_value(0.0);
        for (int pos_id = 0; pos_id < n; pos_id++) {
            Value** logits = gpt(tokens[pos_id], pos_id, keys, values);
            Value** probs = softmax_v(logits, vocab_size);
            loss = add(loss, neg(v_log(probs[tokens[pos_id + 1]])));
        }
        loss = div_v(loss, new_value((double)n));

        for (int i = 0; i < num_params; i++) params[i]->visited = 0;
        backward(loss);

        double lr_t = learning_rate * (1.0 - (double)step / num_steps);
        for (int i = 0; i < num_params; i++) {
            m_adam[i] = beta1 * m_adam[i] + (1.0 - beta1) * params[i]->grad;
            v_adam[i] = beta2 * v_adam[i] + (1.0 - beta2) * params[i]->grad * params[i]->grad;
            double m_hat = m_adam[i] / (1.0 - pow(beta1, step + 1));
            double v_hat = v_adam[i] / (1.0 - pow(beta2, step + 1));
            params[i]->data -= lr_t * m_hat / (sqrt(v_hat) + eps_adam);
            params[i]->grad = 0.0;
        }

        printf("step %4d / %4d | loss %.4f\r", step + 1, num_steps, loss->data);
        fflush(stdout);
        
        arena_reset();
        free(tokens);
    }

    double temperature = 0.5;
    printf("\n--- inference ---\n");
    for (int sample_idx = 0; sample_idx < 20; sample_idx++) {
        Value**** keys = arena_alloc(n_layer * sizeof(Value***));
        Value**** values = arena_alloc(n_layer * sizeof(Value***));
        for (int i = 0; i < n_layer; i++) {
            keys[i] = arena_alloc(block_size * sizeof(Value**));
            values[i] = arena_alloc(block_size * sizeof(Value**));
        }

        int token_id = BOS;
        printf("sample %2d: ", sample_idx + 1);

        for (int pos_id = 0; pos_id < block_size; pos_id++) {
            Value** logits = gpt(token_id, pos_id, keys, values);
            Value** scaled_logits = arena_alloc(vocab_size * sizeof(Value*));
            for (int i = 0; i < vocab_size; i++) {
                scaled_logits[i] = div_v(logits[i], new_value(temperature));
            }
            Value** probs = softmax_v(scaled_logits, vocab_size);
            
            double* probs_data = malloc(vocab_size * sizeof(double));
            for (int i = 0; i < vocab_size; i++) probs_data[i] = probs[i]->data;
            token_id = random_choice(probs_data, vocab_size);
            free(probs_data);

            if (token_id == BOS) break;
            
            // 現在 token 存放的是完整的字串，直接印出即可
            printf("%s", vocab_str[token_id]);
        }
        printf("\n");
        
        arena_reset();
    }

    return 0;
}