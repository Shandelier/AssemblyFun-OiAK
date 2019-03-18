.bss
.comm ptr, 4
.comm size, 4


.data
vzero: .float 0

.text
.global calc
.type calc, @function



calc:

  pushq %rbp
  movq %rsp, %rbp
  #RDI posiada adres tablicy
  #RSI posiada jej rozmiar
  mov %rsi, %rbx
  xor %rsi, %rsi


  movaps (%rdi, %rsi, 4), %xmm0

LOAD_ELE:
  add $4, %rsi
  movaps (%rdi, %rsi, 4), %xmm1

SUM_ELE:
  addps %xmm1, %xmm0
  cmp %rsi, %rbx
  jge LOAD_ELE
  jmp FINAL_CALC


# xmm0 - suma wyrazow
# xmm1 - wczytane wyrazy
# ? %rsi - ile liczb?

FINAL_CALC:
  #sumowanie 4 pól w xmm0
  movaps %xmm0, %xmm3
  shufps $0b00011011, %xmm3, %xmm3
  addss %xmm3, %xmm0
  shufps $0b00011011, %xmm3, %xmm3
  addss %xmm3, %xmm0
  shufps $0b00011011, %xmm3, %xmm3
  addss %xmm3, %xmm0

  movss vzero, %xmm3

  shufps $0b10010011, %xmm0, %xmm0
  movss %xmm3, %xmm0
  shufps $0b10010011, %xmm0, %xmm0
  movss %xmm3, %xmm0
  shufps $0b10010011, %xmm0, %xmm0
  movss %xmm3, %xmm0
  shufps $0b10010011, %xmm0, %xmm0


  mov %rbp, %rsp
  pop %rbp
ret
