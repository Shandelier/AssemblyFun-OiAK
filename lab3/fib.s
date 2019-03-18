# x /256bx & fn1
.data
SYSEXIT = 0
fibx = 42

.section .bss
.comm fn1, 256
.comm fn2, 256

.text
.global main
main:

    movb $1, %al
    movl $255, %ecx
    movb %al, fn2(%ecx)
    movl $fibx, %eax
    xor %edx, %edx
    incl %eax
    movl $2, %ebx
    divl %ebx
    push %edx
    push %eax

    petla_fib:
        movl $fn1, %eax
        movl $fn2, %ebx
        call dodawanie
        movl $fn1, %ebx
        movl $fn2, %eax
        call dodawanie

        pop %edx
        decl %edx
        push %edx
        cmp $0, %edx
        jg petla_fib

        pop %edx
        pop %edx
        xor %eax, %eax
        cmp %eax, %edx
        jne zakoncz
            movl $fn1, %ebx
            movl $fn2, %eax
            call kopiowanie
        zakoncz:


    movl $SYSEXIT, %eax
    movl $0, %ebx
    int $0x80
ret

.type kopiowanie, @function
kopiowanie:
    addl $255, %eax
    addl $255, %ebx
    movl $255, %edx
    poczatek_petli1:
        movb (%eax), %cl
        movb %cl, (%ebx)
        decl %eax
        decl %ebx
        decl %edx
        cmp $0, %edx
        jge poczatek_petli1
ret

.type dodawanie, @function
dodawanie:
    addl $255, %eax
    addl $255, %ebx
    movl $255, %edx
    movb (%eax), %cl
    movb (%ebx), %ch
    addb %cl, %ch
    pushf
    movb %ch, (%ebx)
    poczatek_petli:
        decl %eax
        decl %ebx
        decl %edx
        movb (%eax), %cl
        movb (%ebx), %ch
        popf
        adcb %cl, %ch
        pushf
        movb %ch, (%ebx)
        cmp $0, %edx
        jg poczatek_petli
    popf

ret
