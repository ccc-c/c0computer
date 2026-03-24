// expected: 55
int main() {
    int a = 0b1010;  // 10
    int b = 0b0101;  // 5
    int r = 0;
    r = r + (a & b);  // 0b0000 = 0
    r = r + (a | b);  // 0b1111 = 15
    r = r + (a ^ b);  // 0b1111 = 15
    r = r + (a << 1); // 20
    r = r + (a >> 1); // 5
    return r & 0xFF;  // 15
}
