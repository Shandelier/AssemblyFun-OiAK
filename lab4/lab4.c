#include <stdio.h>

int const ARG = 0;
extern long long unsigned my_cpuid(int ARG);

int main(void)
{
    long long unsigned  t = my_cpuid(ARG);
    int x = 0;
    t = my_cpuid(ARG)-t;
    printf("czas: %llu\n", t);
    return 0;
}
