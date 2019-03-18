.data
 
.text
# Zadeklarowane tutaj funkcje będą możliwe do wykorzystania
# w języku C po zlinkowaniu plików wynikowych kompilacji obu kodów
.global my_cpuid
.type my_cpuid, @function
 

my_cpuid:
    # Odłożenie rejestru bazowego na stos i skopiwanie obecnej
    # wartości wskaźnika stosu do rejestru bazowego
    push %rbp
    mov %rsp, %rbp
    
        rdtsc

     shl $32, %rdx
     or %rdx, %rax

    # Przywrócenie poprzedniej wartości rejestru bazowego
    # i wskaźnika stosu
    mov %rbp, %rsp
    pop %rbp
ret # Powrót do miejsca wywołania funkcji
