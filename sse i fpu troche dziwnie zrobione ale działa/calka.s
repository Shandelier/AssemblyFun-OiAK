.code32



.data


xp: .float 0.001
xk: .float 1000
dx: .float 0.0
i: .long 0x0
n: .long 0x0
wynik: .float 0.0

.text


.global calka
.type calka, @function

calka:
push %ebp
mov %esp, %ebp
push %edi
push %esi
push %ebx

fninit

mov 20(%esp), %esi #funkcja wywolywana dla ktorej obliczana jest calka 
mov 24(%esp), %edi
mov %edi, n
#finit #inicjalizacja fpu 
fld xp #push na stos fpu
fld xk
fsubp %st(0), %st(1)
fstp dx
fildl n
fld dx
fdivp %st(0), %st(1)
fstp dx
xor %ecx, %ecx
petla:
incl %ecx
mov %ecx, i
fld dx
fildl i
fmulp %st(0), %st(1)
fld xp
faddp %st(0), %st(1)
push %ecx #funkcja moze zmienic %ecx wiec go zachowuje
add $-4, %esp
fstp (%esp)
call *%esi #wywolanie funkcji z pointera 
add $4, %esp
pop %ecx #odtwarzam %ecx
#int3
fld wynik
faddp %st(0), %st(1)
fstp wynik

cmp n, %ecx
jbe petla

fld wynik
fld dx
#int3
fmulp %st(0), %st(1)


pop %ebx
pop %esi
pop %edi
leave
ret

