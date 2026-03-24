// expected: 1 (test sqrt)
#include <math.h>

int main() {
    double x = 4.0;
    double y = sqrt(x);
    int r = (y > 1.9 && y < 2.1) ? 1 : 0;
    return r;
}
