.data

.text

.global my_cpuid
.type my_cpuid, @function
  my_cpuid:
    push %rbp
    mov %rsp, %rbp
    sub $4, %rsp
    xor %eax, %eax
    movl %eax, -4(%rbp)

    mov %rdi, %rax

    cmp $0, %rdi
    je zero

    cmp $1, %rdi
    je jeden
    jmp else

    zero:
        rdtsc
        movl -4(%rbp), %ecx
        incl %ecx
        movl %ecx, -4(%rbp)
        cmp $10, %ecx
          jl zero
          jmp koniec

    jeden:
        xor %eax, %eax
        cpuid
        rdtsc
          jmp koniec

    else:
        rdtscp

    koniec:
     shl $32, %rdx
     or %rdx, %rax
    mov %rbp, %rsp
    pop %rbp
ret
