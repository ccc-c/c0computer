// expected: 10 (simple float test)
int main() {
    float a = 3.0f;
    float b = 2.0f;
    float c = a + b;
    int r = (int)c;
    return r + 5;
}
