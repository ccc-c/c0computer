// expected: 10 (simple float test)
int main() {
    float a = 3.5f;
    float b = 2.0f;
    float c = a + b;
    int r = (int)c;  // should be 5
    return r + 5;    // total = 10
}
