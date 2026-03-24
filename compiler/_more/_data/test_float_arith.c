// expected: 0 (test float add, sub, mul, div)
int main() {
    float a = 3.5f;
    float b = 1.5f;
    float c = a + b;  // 5.0
    float d = a - b;  // 2.0
    float e = a * b;  // 5.25
    float f = a / b;  // 2.333...
    
    int r = 0;
    if (c > 4.9f && c < 5.1f) r += 1;
    if (d > 1.9f && d < 2.1f) r += 1;
    if (e > 5.2f && e < 5.3f) r += 1;
    if (f > 2.3f && f < 2.4f) r += 1;
    
    return r;
}
