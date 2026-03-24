// expected: 10 (test int to float conversion)
int main() {
    int a = 5;
    float f = a;  // int to float
    int b = f;    // float to int
    
    double d = a; // int to double
    int c = d;    // double to int
    
    return b + c;
}
