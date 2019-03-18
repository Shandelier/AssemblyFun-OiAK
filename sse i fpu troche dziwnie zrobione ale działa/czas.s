.code32


.data



.text



.global czas
.type czas, @function

czas:
push %ebp
mov %esp, %ebp
push %esi
push %edi
push %ebx

cpuid
rdtsc


pop %ebx
pop %edi
pop %esi
leave
ret
