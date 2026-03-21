#include "num0ad.h"

static int seed = 42;

static double rand_double(void) {
    seed = seed * 1103515245 + 12345;
    return (double)(seed / 65536) / 32768.0 - 1.0;
}

int num0ad_total_size(Num0AD *arr) {
    int total = 1;
    for (int i = 0; i < arr->ndim; i++) total *= arr->shape[i];
    return total;
}

Num0AD *num0ad_create(int ndim, int *shape) {
    Num0AD *arr = (Num0AD *)malloc(sizeof(Num0AD));
    arr->ndim = ndim;
    arr->shape = (int *)malloc(ndim * sizeof(int));
    memcpy(arr->shape, shape, ndim * sizeof(int));
    
    int total = 1;
    for (int i = 0; i < ndim; i++) total *= shape[i];
    arr->data = (double *)calloc(total, sizeof(double));
    arr->grad = (double *)calloc(total, sizeof(double));
    
    arr->n_children = 0;
    arr->children = (Num0AD **)calloc(MAX_CHILDREN, sizeof(Num0AD *));
    arr->local_grads = (double **)calloc(MAX_CHILDREN, sizeof(double *));
    arr->op_type = 0;
    
    return arr;
}

Num0AD *num0ad_create_from_data(int ndim, int *shape, double *data) {
    Num0AD *arr = num0ad_create(ndim, shape);
    int total = num0ad_total_size(arr);
    memcpy(arr->data, data, total * sizeof(double));
    return arr;
}

void num0ad_free(Num0AD *arr) {
    if (arr) {
        free(arr->data);
        free(arr->grad);
        free(arr->shape);
        free(arr->children);
        free(arr->local_grads);
        free(arr);
    }
}

static int is_visited(Num0AD **visited, int count, Num0AD *node) {
    for (int i = 0; i < count; i++) {
        if (visited[i] == node) return 1;
    }
    return 0;
}

void num0ad_free_all(Num0AD *arr) {
    if (!arr) return;
    
    Num0AD **visited = (Num0AD **)malloc(sizeof(Num0AD *) * 1000);
    int visited_count = 0;
    
    Num0AD **stack = (Num0AD **)malloc(sizeof(Num0AD *) * 1000);
    int stack_top = 0;
    stack[stack_top++] = arr;
    
    while (stack_top > 0) {
        Num0AD *node = stack[--stack_top];
        if (!node || is_visited(visited, visited_count, node)) continue;
        visited[visited_count++] = node;
        
        for (int i = 0; i < node->n_children; i++) {
            if (node->children[i]) {
                stack[stack_top++] = node->children[i];
            }
        }
    }
    
    for (int i = 0; i < visited_count; i++) {
        num0ad_free(visited[i]);
    }
    
    free(visited);
    free(stack);
}

Num0AD *num0ad_zeros(int ndim, int *shape) {
    return num0ad_create(ndim, shape);
}

Num0AD *num0ad_ones(int ndim, int *shape) {
    Num0AD *arr = num0ad_create(ndim, shape);
    int total = num0ad_total_size(arr);
    for (int i = 0; i < total; i++) arr->data[i] = 1.0;
    return arr;
}

Num0AD *num0ad_randn(int ndim, int *shape) {
    Num0AD *arr = num0ad_create(ndim, shape);
    int total = num0ad_total_size(arr);
    for (int i = 0; i < total; i++) arr->data[i] = rand_double();
    return arr;
}

Num0AD *num0ad_arange(int start, int stop, int step) {
    int count = (stop - start + step - 1) / step;
    int shape[1] = {count};
    Num0AD *arr = num0ad_create(1, shape);
    for (int i = 0; i < count; i++) {
        arr->data[i] = start + i * step;
    }
    return arr;
}

Num0AD *num0ad_add(Num0AD *a, Num0AD *b) {
    int size_a = num0ad_total_size(a);
    int size_b = num0ad_total_size(b);
    
    Num0AD *res = num0ad_create(a->ndim, a->shape);
    res->op_type = 1;
    
    if (size_b == 1) {
        for (int i = 0; i < size_a; i++) res->data[i] = a->data[i] + b->data[0];
    } else {
        for (int i = 0; i < size_a; i++) res->data[i] = a->data[i] + b->data[i];
    }
    
    res->n_children = 2;
    res->children[0] = a;
    res->children[1] = b;
    
    double *grad_a = (double *)malloc(size_a * sizeof(double));
    double *grad_b = (double *)malloc(size_b * sizeof(double));
    
    if (size_b == 1) {
        for (int i = 0; i < size_a; i++) {
            grad_a[i] = 1.0;
            grad_b[0] += 1.0;
        }
    } else {
        for (int i = 0; i < size_a; i++) {
            grad_a[i] = 1.0;
            grad_b[i] = 1.0;
        }
    }
    
    res->local_grads[0] = grad_a;
    res->local_grads[1] = grad_b;
    
    return res;
}

Num0AD *num0ad_sub(Num0AD *a, Num0AD *b) {
    int size_a = num0ad_total_size(a);
    int size_b = num0ad_total_size(b);
    
    Num0AD *res = num0ad_create(a->ndim, a->shape);
    res->op_type = 2;
    
    if (size_b == 1) {
        for (int i = 0; i < size_a; i++) res->data[i] = a->data[i] - b->data[0];
    } else {
        for (int i = 0; i < size_a; i++) res->data[i] = a->data[i] - b->data[i];
    }
    
    res->n_children = 2;
    res->children[0] = a;
    res->children[1] = b;
    
    double *grad_a = (double *)malloc(size_a * sizeof(double));
    double *grad_b = (double *)malloc(size_b * sizeof(double));
    
    if (size_b == 1) {
        for (int i = 0; i < size_a; i++) {
            grad_a[i] = 1.0;
            grad_b[0] -= 1.0;
        }
    } else {
        for (int i = 0; i < size_a; i++) {
            grad_a[i] = 1.0;
            grad_b[i] = -1.0;
        }
    }
    
    res->local_grads[0] = grad_a;
    res->local_grads[1] = grad_b;
    
    return res;
}

Num0AD *num0ad_mul(Num0AD *a, Num0AD *b) {
    int size_a = num0ad_total_size(a);
    int size_b = num0ad_total_size(b);
    
    Num0AD *res = num0ad_create(a->ndim, a->shape);
    res->op_type = 3;
    
    if (size_b == 1) {
        for (int i = 0; i < size_a; i++) res->data[i] = a->data[i] * b->data[0];
    } else {
        for (int i = 0; i < size_a; i++) res->data[i] = a->data[i] * b->data[i];
    }
    
    res->n_children = 2;
    res->children[0] = a;
    res->children[1] = b;
    
    double *grad_a = (double *)malloc(size_a * sizeof(double));
    double *grad_b = (double *)malloc(size_b * sizeof(double));
    
    if (size_b == 1) {
        for (int i = 0; i < size_a; i++) {
            grad_a[i] = b->data[0];
            grad_b[0] += a->data[i];
        }
    } else {
        for (int i = 0; i < size_a; i++) {
            grad_a[i] = b->data[i];
            grad_b[i] = a->data[i];
        }
    }
    
    res->local_grads[0] = grad_a;
    res->local_grads[1] = grad_b;
    
    return res;
}

Num0AD *num0ad_div(Num0AD *a, Num0AD *b) {
    int size_a = num0ad_total_size(a);
    int size_b = num0ad_total_size(b);
    
    Num0AD *res = num0ad_create(a->ndim, a->shape);
    res->op_type = 4;
    
    if (size_b == 1) {
        for (int i = 0; i < size_a; i++) res->data[i] = a->data[i] / b->data[0];
    } else {
        for (int i = 0; i < size_a; i++) res->data[i] = a->data[i] / b->data[i];
    }
    
    res->n_children = 2;
    res->children[0] = a;
    res->children[1] = b;
    
    double *grad_a = (double *)malloc(size_a * sizeof(double));
    double *grad_b = (double *)malloc(size_b * sizeof(double));
    
    if (size_b == 1) {
        for (int i = 0; i < size_a; i++) {
            grad_a[i] = 1.0 / b->data[0];
            grad_b[0] -= a->data[i] / (b->data[0] * b->data[0]);
        }
    } else {
        for (int i = 0; i < size_a; i++) {
            grad_a[i] = 1.0 / b->data[i];
            grad_b[i] = -a->data[i] / (b->data[i] * b->data[i]);
        }
    }
    
    res->local_grads[0] = grad_a;
    res->local_grads[1] = grad_b;
    
    return res;
}

Num0AD *num0ad_neg(Num0AD *a) {
    int size = num0ad_total_size(a);
    
    Num0AD *res = num0ad_create(a->ndim, a->shape);
    res->op_type = 5;
    
    for (int i = 0; i < size; i++) res->data[i] = -a->data[i];
    
    res->n_children = 1;
    res->children[0] = a;
    
    double *grad_a = (double *)malloc(size * sizeof(double));
    for (int i = 0; i < size; i++) grad_a[i] = -1.0;
    res->local_grads[0] = grad_a;
    
    return res;
}

Num0AD *num0ad_exp(Num0AD *a) {
    int size = num0ad_total_size(a);
    
    Num0AD *res = num0ad_create(a->ndim, a->shape);
    res->op_type = 6;
    
    for (int i = 0; i < size; i++) res->data[i] = exp(a->data[i]);
    
    res->n_children = 1;
    res->children[0] = a;
    
    double *grad_a = (double *)malloc(size * sizeof(double));
    for (int i = 0; i < size; i++) grad_a[i] = exp(a->data[i]);
    res->local_grads[0] = grad_a;
    
    return res;
}

Num0AD *num0ad_log(Num0AD *a) {
    int size = num0ad_total_size(a);
    
    Num0AD *res = num0ad_create(a->ndim, a->shape);
    res->op_type = 7;
    
    for (int i = 0; i < size; i++) res->data[i] = log(a->data[i]);
    
    res->n_children = 1;
    res->children[0] = a;
    
    double *grad_a = (double *)malloc(size * sizeof(double));
    for (int i = 0; i < size; i++) grad_a[i] = 1.0 / a->data[i];
    res->local_grads[0] = grad_a;
    
    return res;
}

Num0AD *num0ad_relu(Num0AD *a) {
    int size = num0ad_total_size(a);
    
    Num0AD *res = num0ad_create(a->ndim, a->shape);
    res->op_type = 8;
    
    for (int i = 0; i < size; i++) res->data[i] = a->data[i] > 0 ? a->data[i] : 0;
    
    res->n_children = 1;
    res->children[0] = a;
    
    double *grad_a = (double *)malloc(size * sizeof(double));
    for (int i = 0; i < size; i++) grad_a[i] = a->data[i] > 0 ? 1.0 : 0.0;
    res->local_grads[0] = grad_a;
    
    return res;
}

Num0AD *num0ad_abs(Num0AD *a) {
    int size = num0ad_total_size(a);
    
    Num0AD *res = num0ad_create(a->ndim, a->shape);
    res->op_type = 9;
    
    for (int i = 0; i < size; i++) res->data[i] = fabs(a->data[i]);
    
    res->n_children = 1;
    res->children[0] = a;
    
    double *grad_a = (double *)malloc(size * sizeof(double));
    for (int i = 0; i < size; i++) grad_a[i] = a->data[i] >= 0 ? 1.0 : -1.0;
    res->local_grads[0] = grad_a;
    
    return res;
}

Num0AD *num0ad_sqrt(Num0AD *a) {
    int size = num0ad_total_size(a);
    
    Num0AD *res = num0ad_create(a->ndim, a->shape);
    res->op_type = 10;
    
    for (int i = 0; i < size; i++) res->data[i] = sqrt(a->data[i]);
    
    res->n_children = 1;
    res->children[0] = a;
    
    double *grad_a = (double *)malloc(size * sizeof(double));
    for (int i = 0; i < size; i++) grad_a[i] = 0.5 / sqrt(a->data[i]);
    res->local_grads[0] = grad_a;
    
    return res;
}

Num0AD *num0ad_pow(Num0AD *a, double p) {
    int size = num0ad_total_size(a);
    
    Num0AD *res = num0ad_create(a->ndim, a->shape);
    res->op_type = 11;
    
    for (int i = 0; i < size; i++) res->data[i] = pow(a->data[i], p);
    
    res->n_children = 1;
    res->children[0] = a;
    
    double *grad_a = (double *)malloc(size * sizeof(double));
    for (int i = 0; i < size; i++) grad_a[i] = p * pow(a->data[i], p - 1.0);
    res->local_grads[0] = grad_a;
    
    return res;
}

Num0AD *num0ad_sum(Num0AD *a) {
    int size = num0ad_total_size(a);
    
    Num0AD *res = num0ad_create(1, (int[]){1});
    res->op_type = 12;
    
    double s = 0;
    for (int i = 0; i < size; i++) s += a->data[i];
    res->data[0] = s;
    
    res->n_children = 1;
    res->children[0] = a;
    
    double *grad_a = (double *)malloc(size * sizeof(double));
    for (int i = 0; i < size; i++) grad_a[i] = 1.0;
    res->local_grads[0] = grad_a;
    
    return res;
}

Num0AD *num0ad_mean(Num0AD *a) {
    int size = num0ad_total_size(a);
    
    Num0AD *res = num0ad_create(1, (int[]){1});
    res->op_type = 13;
    
    double s = 0;
    for (int i = 0; i < size; i++) s += a->data[i];
    res->data[0] = s / size;
    
    res->n_children = 1;
    res->children[0] = a;
    
    double inv_n = 1.0 / size;
    double *grad_a = (double *)malloc(size * sizeof(double));
    for (int i = 0; i < size; i++) grad_a[i] = inv_n;
    res->local_grads[0] = grad_a;
    
    return res;
}

Num0AD *num0ad_matmul(Num0AD *a, Num0AD *b) {
    if (a->ndim != 2 || b->ndim != 2) return NULL;
    
    int a_rows = a->shape[0];
    int a_cols = a->shape[1];
    int b_cols = b->shape[1];
    
    int shape[2] = {a_rows, b_cols};
    Num0AD *res = num0ad_create(2, shape);
    res->op_type = 14;
    
    for (int i = 0; i < a_rows; i++) {
        for (int j = 0; j < b_cols; j++) {
            double sum = 0;
            for (int k = 0; k < a_cols; k++) {
                sum += a->data[i * a_cols + k] * b->data[k * b_cols + j];
            }
            res->data[i * b_cols + j] = sum;
        }
    }
    
    res->n_children = 2;
    res->children[0] = a;
    res->children[1] = b;
    
    int size_a = a_rows * a_cols;
    int size_b = a_cols * b_cols;
    
    double *grad_a = (double *)malloc(size_a * sizeof(double));
    double *grad_b = (double *)malloc(size_b * sizeof(double));
    
    for (int i = 0; i < size_a; i++) grad_a[i] = 0;
    for (int i = 0; i < size_b; i++) grad_b[i] = 0;
    
    for (int i = 0; i < a_rows; i++) {
        for (int j = 0; j < b_cols; j++) {
            for (int k = 0; k < a_cols; k++) {
                grad_a[i * a_cols + k] += b->data[k * b_cols + j];
                grad_b[k * b_cols + j] += a->data[i * a_cols + k];
            }
        }
    }
    
    res->local_grads[0] = grad_a;
    res->local_grads[1] = grad_b;
    
    return res;
}

Num0AD *num0ad_dot(Num0AD *a, Num0AD *b) {
    if (a->ndim == 1 && b->ndim == 1) {
        int size = a->shape[0];
        double sum = 0;
        for (int i = 0; i < size; i++) sum += a->data[i] * b->data[i];
        
        Num0AD *res = num0ad_create(1, (int[]){1});
        res->op_type = 15;
        res->data[0] = sum;
        
        res->n_children = 2;
        res->children[0] = a;
        res->children[1] = b;
        
        double *grad_a = (double *)malloc(size * sizeof(double));
        double *grad_b = (double *)malloc(size * sizeof(double));
        for (int i = 0; i < size; i++) {
            grad_a[i] = b->data[i];
            grad_b[i] = a->data[i];
        }
        res->local_grads[0] = grad_a;
        res->local_grads[1] = grad_b;
        
        return res;
    }
    return num0ad_matmul(a, b);
}

Num0AD *num0ad_reshape(Num0AD *a, int ndim, int *shape) {
    int total = num0ad_total_size(a);
    int new_size = 1;
    for (int i = 0; i < ndim; i++) new_size *= shape[i];
    
    if (total != new_size) return NULL;
    
    Num0AD *res = num0ad_create(ndim, shape);
    res->op_type = 16;
    memcpy(res->data, a->data, total * sizeof(double));
    
    res->n_children = 1;
    res->children[0] = a;
    
    double *grad_a = (double *)malloc(total * sizeof(double));
    for (int i = 0; i < total; i++) grad_a[i] = 1.0;
    res->local_grads[0] = grad_a;
    
    return res;
}

Num0AD *num0ad_flatten(Num0AD *a) {
    int total = num0ad_total_size(a);
    int shape[1] = {total};
    return num0ad_reshape(a, 1, shape);
}

double num0ad_maxval(Num0AD *a) {
    int size = num0ad_total_size(a);
    double m = a->data[0];
    for (int i = 1; i < size; i++) {
        if (a->data[i] > m) m = a->data[i];
    }
    return m;
}

int num0ad_argmax(Num0AD *a) {
    int size = num0ad_total_size(a);
    int idx = 0;
    double m = a->data[0];
    for (int i = 1; i < size; i++) {
        if (a->data[i] > m) {
            m = a->data[i];
            idx = i;
        }
    }
    return idx;
}

Num0AD *num0ad_max(Num0AD *a) {
    Num0AD *res = num0ad_create(1, (int[]){1});
    res->op_type = 17;
    res->data[0] = num0ad_maxval(a);
    return res;
}

Num0AD *num0ad_scalar_add(Num0AD *a, double b) {
    int size = num0ad_total_size(a);
    
    Num0AD *res = num0ad_create(a->ndim, a->shape);
    res->op_type = 18;
    
    for (int i = 0; i < size; i++) res->data[i] = a->data[i] + b;
    
    res->n_children = 1;
    res->children[0] = a;
    
    double *grad_a = (double *)malloc(size * sizeof(double));
    for (int i = 0; i < size; i++) grad_a[i] = 1.0;
    res->local_grads[0] = grad_a;
    
    return res;
}

Num0AD *num0ad_scalar_mul(Num0AD *a, double b) {
    int size = num0ad_total_size(a);
    
    Num0AD *res = num0ad_create(a->ndim, a->shape);
    res->op_type = 19;
    
    for (int i = 0; i < size; i++) res->data[i] = a->data[i] * b;
    
    res->n_children = 1;
    res->children[0] = a;
    
    double *grad_a = (double *)malloc(size * sizeof(double));
    for (int i = 0; i < size; i++) grad_a[i] = b;
    res->local_grads[0] = grad_a;
    
    return res;
}

void num0ad_zero_grad(Num0AD *a) {
    if (!a) return;
    int size = num0ad_total_size(a);
    for (int i = 0; i < size; i++) a->grad[i] = 0;
}

static int contains(Num0AD **arr, int count, Num0AD *item) {
    for (int i = 0; i < count; i++) {
        if (arr[i] == item) return 1;
    }
    return 0;
}

void num0ad_backward(Num0AD *out) {
    if (!out) return;
    
    int size = num0ad_total_size(out);
    for (int i = 0; i < size; i++) out->grad[i] = 1.0;
    
    Num0AD **visited = (Num0AD **)malloc(sizeof(Num0AD *) * 1000);
    int visited_count = 0;
    
    Num0AD **queue = (Num0AD **)malloc(sizeof(Num0AD *) * 1000);
    int queue_front = 0, queue_back = 0;
    
    queue[queue_back++] = out;
    
    while (queue_front < queue_back) {
        Num0AD *node = queue[queue_front++];
        
        if (contains(visited, visited_count, node)) continue;
        visited[visited_count++] = node;
        
        for (int i = 0; i < node->n_children; i++) {
            Num0AD *child = node->children[i];
            int child_size = num0ad_total_size(child);
            int node_size = num0ad_total_size(node);
            double *local_grad = node->local_grads[i];
            
            for (int j = 0; j < child_size; j++) {
                int grad_idx = (node_size == 1) ? 0 : j;
                child->grad[j] += local_grad[j] * node->grad[grad_idx];
            }
            
            if (!contains(visited, visited_count, child) && child->n_children > 0) {
                queue[queue_back++] = child;
            }
        }
    }
    
    free(visited);
    free(queue);
}

void num0ad_print(Num0AD *arr) {
    printf("Num0AD[");
    for (int i = 0; i < arr->ndim; i++) {
        printf("%d", arr->shape[i]);
        if (i < arr->ndim - 1) printf(",");
    }
    printf("] = [");
    
    int total = num0ad_total_size(arr);
    for (int i = 0; i < total; i++) {
        printf("%.4f", arr->data[i]);
        if (i < total - 1) printf(", ");
    }
    printf("]\n");
}

void num0ad_print_grad(Num0AD *arr) {
    printf("Grad[");
    for (int i = 0; i < arr->ndim; i++) {
        printf("%d", arr->shape[i]);
        if (i < arr->ndim - 1) printf(",");
    }
    printf("] = [");
    
    int total = num0ad_total_size(arr);
    for (int i = 0; i < total; i++) {
        printf("%.4f", arr->grad[i]);
        if (i < total - 1) printf(", ");
    }
    printf("]\n");
}
