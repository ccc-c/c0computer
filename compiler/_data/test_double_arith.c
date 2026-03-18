// expected: 4 (test double precision)
int main() {
    double a = 10.5;
    double b = 2.5;
    double c = a + b;  // 13.0
    double d = a - b;  // 8.0
    double e = a * b;  // 26.25
    double f = a / b;  // 4.2
    
    int r = 0;
    if (c > 12.9 && c < 13.1) r += 1;
    if (d > 7.9 && d < 8.1) r += 1;
    if (e > 26.2 && e < 26.3) r += 1;
    if (f > 4.1 && f < 4.3) r += 1;
    
    return r;
}
