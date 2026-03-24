// expected: 6 (test float comparisons)
int main() {
    float a = 5.0f;
    float b = 3.0f;
    int r = 0;
    
    if (a > b) r += 1;
    if (a >= b) r += 1;
    if (b < a) r += 1;
    if (b <= a) r += 1;
    if (a == a) r += 1;
    if (a != b) r += 1;
    
    return r;
}
