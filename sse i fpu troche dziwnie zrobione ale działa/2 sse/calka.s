.code32



.data


xp: .float 0.001
xk: .float 1000
dx: .float 0.0
i: .long 0x0
n: .long 0x0
#wynik: .float 0.0


#calka_z: .float 0.0, 0.0, 0.0, 0.0

calka_temp: .float 0.0, 0.0, 0.0, 0.0



.text


.global calka
.type calka, @function

calka:
push %ebp
mov %esp, %ebp
push %edi
push %esi
push %ebx

#finit #inicjalizacja fpu 

xorps %xmm0, %xmm0
xorps %xmm1, %xmm1

mov 20(%esp), %esi #funkcja wywolywana dla ktorej obliczana jest calka 
mov 24(%esp), %edi

#movups calka_temp, %xmm1 #od razu zapis
#int3
mov %edi, n
fld xp #push na stos fpu
fld xk
fsubp %st(0), %st(1)
fstp dx
fildl n
fld dx
fdivp %st(0), %st(1)
fstp dx


#-------------tutaj jest petla zaczeta 

xor %ecx, %ecx
petla:

xor %edi, %edi #do tablicy aby w petli mmx uzyc 
petla_m: #petla do wyliczania kolejnych elementow mmx
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
fstp calka_temp(, %edi, 4)

#zakonczenie mniejszej petli 
inc %edi
cmp $4, %edi
jne petla_m

movups calka_temp, %xmm0
addps %xmm0, %xmm1


cmp n, %ecx
jbe petla
movups %xmm1, calka_temp

xor %ecx, %ecx
fld calka_temp(, %ecx, 4) #pierwsza liczba do st0
inc %ecx
petla_k:

fld calka_temp(,%ecx,4)
faddp %st(0), %st(1)

inc %ecx
cmp $4, %ecx
jne petla_k

fld dx
#int3
fmulp %st(0), %st(1)

#int3

pop %ebx
pop %esi
pop %edi
leave
ret

