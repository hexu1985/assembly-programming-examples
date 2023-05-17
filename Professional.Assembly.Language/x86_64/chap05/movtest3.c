#include <stdio.h>

char output[] ="The value is %d\n";
int values[] = {10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60};

int main() {
    for (int i =0; i <= 10; i++) {
        printf(output, *(values + i));
    }
}
