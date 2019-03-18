#include <stdio.h>

 
int a[2000];
// Deklaracja funkcji które dołączone zostaną
// do programu dopiero na etapie linkowania kodu
extern long long unsigned my_cpuid();
 
 
int main(void)
{
    register long long unsigned  t;
    register int i;
    register int b;
    for(i = 0; i<2000; ++i){
    // Wywołanie funkcji Asemblerowej
    t = my_cpuid();
        b = a[i];
    t = my_cpuid()-t;
    printf("%i\t %llu\n",i, t);
    }
    // Wyświetlenie wyniku
    
 
    // Zwrot wartości EXIT_SUCCESS na wyjściu programu
    return b;
}
