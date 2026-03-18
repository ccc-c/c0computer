// expected: 8
int main() {
    int x = 5;
    int y = ++x;  // y = 6, x = 6
    int z = x++;  // z = 6, x = 7
    int w = --x;  // w = 6, x = 6
    return x + y + z + w;
}
