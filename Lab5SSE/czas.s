
.data
.text
.global czas
.type czas, @function

czas:
push %rbp
mov %rsp, %rbp
push %rsi
push %rdi
push %rbx
rdtsc
shl  $32, %rdx
xor %rdx, %rax
pop %rbx
pop %rdi
pop %rsi
leave
ret
