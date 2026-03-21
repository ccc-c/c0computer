#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include "cnn0.h"

#define TYPE_CONV 0
#define TYPE_POOL 1
#define TYPE_FLATTEN 2
#define TYPE_LINEAR 3

void init_cnn(CNN* cnn, int num_layers) {
    cnn->num_layers = 0;
    cnn->layers = malloc(MAX_PARAMS * sizeof(Layer*));
}

void add_conv2d(CNN* cnn, int in_ch, int out_ch, int kernel_size, int stride, int padding) {
    if (cnn->num_layers >= MAX_PARAMS) {
        fprintf(stderr, "Too many layers\n"); exit(1);
    }
    Layer* layer = malloc(sizeof(Layer));
    layer->type = TYPE_CONV;
    layer->conv = malloc(sizeof(Conv2D));
    layer->conv->in_channels = in_ch;
    layer->conv->out_channels = out_ch;
    layer->conv->kernel_size = kernel_size;
    layer->conv->stride = stride;
    layer->conv->padding = padding;
    layer->conv->kernels = malloc(out_ch * sizeof(Matrix));
    double std = sqrt(2.0 / (in_ch * kernel_size * kernel_size));
    for (int oc = 0; oc < out_ch; oc++) {
        layer->conv->kernels[oc] = create_matrix(in_ch * kernel_size * kernel_size, 1, std);
    }
    layer->conv->biases = malloc(out_ch * sizeof(Value*));
    for (int oc = 0; oc < out_ch; oc++) {
        layer->conv->biases[oc] = new_param(0.0);
    }
    layer->pool = NULL;
    layer->linear = NULL;
    cnn->layers[cnn->num_layers++] = layer;
}

void add_maxpool2d(CNN* cnn, int kernel_size, int stride) {
    if (cnn->num_layers >= MAX_PARAMS) {
        fprintf(stderr, "Too many layers\n"); exit(1);
    }
    Layer* layer = malloc(sizeof(Layer));
    layer->type = TYPE_POOL;
    layer->pool = malloc(sizeof(MaxPool2D));
    layer->pool->kernel_size = kernel_size;
    layer->pool->stride = stride;
    layer->conv = NULL;
    layer->linear = NULL;
    cnn->layers[cnn->num_layers++] = layer;
}

void add_flatten(CNN* cnn) {
    if (cnn->num_layers >= MAX_PARAMS) {
        fprintf(stderr, "Too many layers\n"); exit(1);
    }
    Layer* layer = malloc(sizeof(Layer));
    layer->type = TYPE_FLATTEN;
    layer->conv = NULL;
    layer->pool = NULL;
    layer->linear = NULL;
    cnn->layers[cnn->num_layers++] = layer;
}

void add_linear(CNN* cnn, int in_features, int out_features) {
    if (cnn->num_layers >= MAX_PARAMS) {
        fprintf(stderr, "Too many layers\n"); exit(1);
    }
    Layer* layer = malloc(sizeof(Layer));
    layer->type = TYPE_LINEAR;
    layer->linear = malloc(sizeof(Linear));
    layer->linear->in_features = in_features;
    layer->linear->out_features = out_features;
    double std = sqrt(2.0 / in_features);
    layer->linear->w = create_matrix(out_features, in_features, std);
    layer->linear->biases = malloc(out_features * sizeof(Value*));
    for (int i = 0; i < out_features; i++) {
        layer->linear->biases[i] = new_param(0.0);
    }
    layer->conv = NULL;
    layer->pool = NULL;
    cnn->layers[cnn->num_layers++] = layer;
}

int get_conv_out_size(int in_size, int kernel_size, int stride, int padding) {
    return (in_size + 2 * padding - kernel_size) / stride + 1;
}

int get_pool_out_size(int in_size, int kernel_size, int stride) {
    return (in_size + stride - 1) / stride;
}

static Value* relu_activ(Value* x) {
    return v_relu(x);
}

static Value** apply_conv(Value** input, int batch, int in_h, int in_w, int in_c,
                          Conv2D* conv, int* out_h, int* out_w, int* out_c) {
    *out_h = get_conv_out_size(in_h, conv->kernel_size, conv->stride, conv->padding);
    *out_w = get_conv_out_size(in_w, conv->kernel_size, conv->stride, conv->padding);
    *out_c = conv->out_channels;
    
    int output_size = batch * (*out_h) * (*out_w) * (*out_c);
    Value** output = arena_alloc(output_size * sizeof(Value*));
    
    for (int b = 0; b < batch; b++) {
        for (int oc = 0; oc < conv->out_channels; oc++) {
            for (int oh = 0; oh < *out_h; oh++) {
                for (int ow = 0; ow < *out_w; ow++) {
                    Value* sum = new_value(0.0);
                    
                    for (int ic = 0; ic < in_c; ic++) {
                        int ksize = conv->kernel_size * conv->kernel_size;
                        for (int kh = 0; kh < conv->kernel_size; kh++) {
                            for (int kw = 0; kw < conv->kernel_size; kw++) {
                                int ih = oh * conv->stride - conv->padding + kh;
                                int iw = ow * conv->stride - conv->padding + kw;
                                
                                if (ih >= 0 && ih < in_h && iw >= 0 && iw < in_w) {
                                    int ki = ic * conv->kernel_size * conv->kernel_size + kh * conv->kernel_size + kw;
                                    int in_idx = b * in_c * in_h * in_w + ic * in_h * in_w + ih * in_w + iw;
                                    int out_idx = b * (*out_c) * (*out_h) * (*out_w) + oc * (*out_h) * (*out_w) + oh * (*out_w) + ow;
                                    
                                    Value* w_val = conv->kernels[oc].data[ki][0];
                                    Value* prod = mul(w_val, input[in_idx]);
                                    sum = add(sum, prod);
                                }
                            }
                        }
                    }
                    Value* bias = conv->biases[oc];
                    sum = add(sum, bias);
                    
                    int out_idx = b * (*out_c) * (*out_h) * (*out_w) + oc * (*out_h) * (*out_w) + oh * (*out_w) + ow;
                    output[out_idx] = relu_activ(sum);
                }
            }
        }
    }
    return output;
}

static Value** apply_pool(Value** input, int batch, int in_h, int in_w, int in_c,
                          MaxPool2D* pool, int* out_h, int* out_w) {
    *out_h = get_pool_out_size(in_h, pool->kernel_size, pool->stride);
    *out_w = get_pool_out_size(in_w, pool->kernel_size, pool->stride);
    
    int output_size = batch * in_c * (*out_h) * (*out_w);
    Value** output = arena_alloc(output_size * sizeof(Value*));
    
    for (int b = 0; b < batch; b++) {
        for (int c = 0; c < in_c; c++) {
            for (int oh = 0; oh < *out_h; oh++) {
                for (int ow = 0; ow < *out_w; ow++) {
                    int ih_start = oh * pool->stride;
                    int iw_start = ow * pool->stride;
                    Value* max_val = NULL;
                    
                    for (int kh = 0; kh < pool->kernel_size && ih_start + kh < in_h; kh++) {
                        for (int kw = 0; kw < pool->kernel_size && iw_start + kw < in_w; kw++) {
                            int idx = b * in_c * in_h * in_w + c * in_h * in_w + (ih_start + kh) * in_w + (iw_start + kw);
                            if (max_val == NULL || input[idx]->data > max_val->data) {
                                max_val = input[idx];
                            }
                        }
                    }
                    
                    int out_idx = b * in_c * (*out_h) * (*out_w) + c * (*out_h) * (*out_w) + oh * (*out_w) + ow;
                    output[out_idx] = max_val ? max_val : new_value(0.0);
                }
            }
        }
    }
    return output;
}

Value** forward(CNN* cnn, double* input, int batch, int in_h, int in_w, int in_c) {
    int cur_batch = batch;
    int cur_h = in_h;
    int cur_w = in_w;
    int cur_c = in_c;
    int cur_size = batch * cur_h * cur_w * cur_c;
    
    if (cur_size <= 0 || cur_size > 10000000) {
        fprintf(stderr, "Invalid cur_size: %d\n", cur_size);
        return NULL;
    }
    
    Value** current = arena_alloc(cur_size * sizeof(Value*));
    for (int i = 0; i < cur_size; i++) {
        current[i] = new_value(input[i]);
    }
    
    for (int l = 0; l < cnn->num_layers; l++) {
        Layer* layer = cnn->layers[l];
        
        if (layer->type == TYPE_CONV) {
            int out_h, out_w, out_c;
            Value** output = apply_conv(current, cur_batch, cur_h, cur_w, cur_c, 
                                        layer->conv, &out_h, &out_w, &out_c);
            current = output;
            cur_h = out_h;
            cur_w = out_w;
            cur_c = out_c;
            cur_size = cur_batch * cur_c * cur_h * cur_w;
        }
        else if (layer->type == TYPE_POOL) {
            int out_h, out_w;
            Value** output = apply_pool(current, cur_batch, cur_h, cur_w, cur_c,
                                        layer->pool, &out_h, &out_w);
            current = output;
            cur_h = out_h;
            cur_w = out_w;
            cur_size = cur_batch * cur_c * cur_h * cur_w;
        }
        else if (layer->type == TYPE_FLATTEN) {
            int total = cur_batch * cur_c * cur_h * cur_w;
            Value** output = arena_alloc(total * sizeof(Value*));
            for (int i = 0; i < total; i++) {
                output[i] = current[i];
            }
            current = output;
            cur_c = total;
            cur_h = 1;
            cur_w = 1;
            cur_size = total;
        }
        else if (layer->type == TYPE_LINEAR) {
            Linear* lin = layer->linear;
            Value** output = linear(current, cur_c, lin->w);
            for (int i = 0; i < lin->out_features; i++) {
                output[i] = add(output[i], lin->biases[i]);
                if (l < cnn->num_layers - 1) {
                    output[i] = relu_activ(output[i]);
                }
            }
            current = output;
            cur_c = lin->out_features;
            cur_size = lin->out_features;
        }
    }
    
    return current;
}

void save_cnn(CNN* cnn, const char* filename) {
    FILE* f = fopen(filename, "wb");
    if (!f) { fprintf(stderr, "Cannot open file for saving\n"); return; }

    fwrite(&cnn->num_layers, sizeof(int), 1, f);

    for (int l = 0; l < cnn->num_layers; l++) {
        Layer* layer = cnn->layers[l];
        fwrite(&layer->type, sizeof(int), 1, f);

        if (layer->type == TYPE_CONV) {
            Conv2D* conv = layer->conv;
            fwrite(&conv->in_channels, sizeof(int), 1, f);
            fwrite(&conv->out_channels, sizeof(int), 1, f);
            fwrite(&conv->kernel_size, sizeof(int), 1, f);
            fwrite(&conv->stride, sizeof(int), 1, f);
            fwrite(&conv->padding, sizeof(int), 1, f);
            for (int oc = 0; oc < conv->out_channels; oc++) {
                for (int i = 0; i < conv->in_channels * conv->kernel_size * conv->kernel_size; i++) {
                    fwrite(&conv->kernels[oc].data[i][0]->data, sizeof(double), 1, f);
                }
            }
            for (int oc = 0; oc < conv->out_channels; oc++) {
                fwrite(&conv->biases[oc]->data, sizeof(double), 1, f);
            }
        }
        else if (layer->type == TYPE_LINEAR) {
            Linear* lin = layer->linear;
            fwrite(&lin->in_features, sizeof(int), 1, f);
            fwrite(&lin->out_features, sizeof(int), 1, f);
            for (int i = 0; i < lin->out_features; i++) {
                for (int j = 0; j < lin->in_features; j++) {
                    fwrite(&lin->w.data[i][j]->data, sizeof(double), 1, f);
                }
            }
            for (int i = 0; i < lin->out_features; i++) {
                fwrite(&lin->biases[i]->data, sizeof(double), 1, f);
            }
        }
        else if (layer->type == TYPE_POOL) {
            MaxPool2D* pool = layer->pool;
            fwrite(&pool->kernel_size, sizeof(int), 1, f);
            fwrite(&pool->stride, sizeof(int), 1, f);
        }
    }
    fclose(f);
}

void load_cnn(CNN* cnn, const char* filename) {
    FILE* f = fopen(filename, "rb");
    if (!f) { fprintf(stderr, "Cannot open file for loading\n"); return; }

    fread(&cnn->num_layers, sizeof(int), 1, f);

    for (int l = 0; l < cnn->num_layers; l++) {
        int type;
        fread(&type, sizeof(int), 1, f);

        Layer* layer = malloc(sizeof(Layer));
        layer->type = type;

        if (type == TYPE_CONV) {
            layer->conv = malloc(sizeof(Conv2D));
            fread(&layer->conv->in_channels, sizeof(int), 1, f);
            fread(&layer->conv->out_channels, sizeof(int), 1, f);
            fread(&layer->conv->kernel_size, sizeof(int), 1, f);
            fread(&layer->conv->stride, sizeof(int), 1, f);
            fread(&layer->conv->padding, sizeof(int), 1, f);
            layer->conv->kernels = malloc(layer->conv->out_channels * sizeof(Matrix));
            for (int oc = 0; oc < layer->conv->out_channels; oc++) {
                int ksize = layer->conv->in_channels * layer->conv->kernel_size * layer->conv->kernel_size;
                layer->conv->kernels[oc].rows = ksize;
                layer->conv->kernels[oc].cols = 1;
                layer->conv->kernels[oc].data = malloc(ksize * sizeof(Value*));
                for (int i = 0; i < ksize; i++) {
                    double val;
                    fread(&val, sizeof(double), 1, f);
                    layer->conv->kernels[oc].data[i] = malloc(sizeof(Value*));
                    layer->conv->kernels[oc].data[i][0] = new_param(val);
                }
            }
            layer->conv->biases = malloc(layer->conv->out_channels * sizeof(Value*));
            for (int oc = 0; oc < layer->conv->out_channels; oc++) {
                double val;
                fread(&val, sizeof(double), 1, f);
                layer->conv->biases[oc] = new_param(val);
            }
            layer->pool = NULL;
            layer->linear = NULL;
        }
        else if (type == TYPE_LINEAR) {
            layer->linear = malloc(sizeof(Linear));
            fread(&layer->linear->in_features, sizeof(int), 1, f);
            fread(&layer->linear->out_features, sizeof(int), 1, f);
            layer->linear->w.rows = layer->linear->out_features;
            layer->linear->w.cols = layer->linear->in_features;
            layer->linear->w.data = malloc(layer->linear->w.rows * sizeof(Value**));
            for (int i = 0; i < layer->linear->w.rows; i++) {
                layer->linear->w.data[i] = malloc(layer->linear->w.cols * sizeof(Value*));
                for (int j = 0; j < layer->linear->w.cols; j++) {
                    double val;
                    fread(&val, sizeof(double), 1, f);
                    layer->linear->w.data[i][j] = new_param(val);
                }
            }
            layer->linear->biases = malloc(layer->linear->out_features * sizeof(Value*));
            for (int i = 0; i < layer->linear->out_features; i++) {
                double val;
                fread(&val, sizeof(double), 1, f);
                layer->linear->biases[i] = new_param(val);
            }
            layer->conv = NULL;
            layer->pool = NULL;
        }
        else if (type == TYPE_POOL) {
            layer->conv = NULL;
            layer->pool = malloc(sizeof(MaxPool2D));
            fread(&layer->pool->kernel_size, sizeof(int), 1, f);
            fread(&layer->pool->stride, sizeof(int), 1, f);
            layer->linear = NULL;
        }
        else {
            layer->conv = NULL;
            layer->pool = NULL;
            layer->linear = NULL;
        }

        cnn->layers[l] = layer;
    }
    fclose(f);
}

void free_cnn(CNN* cnn) {
    for (int l = 0; l < cnn->num_layers; l++) {
        Layer* layer = cnn->layers[l];
        if (layer->type == TYPE_CONV) {
            for (int oc = 0; oc < layer->conv->out_channels; oc++) {
                int ksize = layer->conv->in_channels * layer->conv->kernel_size * layer->conv->kernel_size;
                for (int i = 0; i < ksize; i++) {
                    free(layer->conv->kernels[oc].data[i]);
                }
                free(layer->conv->kernels[oc].data);
            }
            free(layer->conv->kernels);
            free(layer->conv->biases);
            free(layer->conv);
        }
        else if (layer->type == TYPE_LINEAR) {
            for (int i = 0; i < layer->linear->w.rows; i++) {
                free(layer->linear->w.data[i]);
            }
            free(layer->linear->w.data);
            free(layer->linear->biases);
            free(layer->linear);
        }
        free(layer);
    }
    free(cnn->layers);
}
