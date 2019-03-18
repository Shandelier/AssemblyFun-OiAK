.data

#iterator: .int 0  #
A: .float 1   #przedział całkowania
B: .float 2   #przedział całkowania końcowy
k: .float 200 #ile prostokątów na przedziale A->B
cztery: .float 4
#f(x) = 2x+4
.bss
.comm VIV, 8 #Very Important Value (basicly a trash can where you throw everything)
.comm iterator, 4  #
.text

.global calc
.type calc, @function

calc:
  push %rbp
  mov %rsp, %rbp

  push %rdi
  push %rsi
  push %rbx

  FNINIT
            #throwing args on stack

  FLDZ    # 0 for iterator
FLDZ
  #calculatinf lenght B-A/k for further use

  FLD A
  FLD B
  FSUBP  %ST(0), %ST(1)
  FDIV k
#  FLD A

  FLD A     # A (+ n*lenght)

  #STACK
  # R7> iterator
  # R6> sum of rectangles
  # R5> lenght
  # R4> A
  # ST(0) -> R4

LOOP:
  FLD A #wrzucenie jedynki do dodania do iteratora
  FADD %ST(0), %ST(4) #backup: 4 do 0
  FFREE %ST(0)
  FINCSTP
  FLD %ST(3)
  #STACK
  # R7> iterator
  # R6> sum of rectangles
  # R5> lenght
  # R4> A
  # R3> n
  # ST(0) -> R3

  FLD k #value 200 for FCOMI


  FCOMIP  #compare iterator with k = 200 (ilość przedzialow) and pop register ST(0)
  je ZAKONCZ



  #args for f(x)
  FMUL %ST(2), %ST(0) # (n*lenght)
  FADD %ST(1), %ST(0) # (A+ n*lenght)
  #STACK
  # R7> iterator
  # R6> sum of rectangles
  # R5> lenght
  # R4> A
  # R3> x (arg)
  # ST(0) -> R3

  #value of f(x)
  FLD B   #actually its 2
  FMULP # ST(1) = ST(0) * ST(1), FINCSTP
  FLD cztery
  FADDP # ST(1) = ST(0) + ST(1), FINCSTP
  #STACK
  # R7> iterator
  # R6> sum of rectangles
  # R5> lenght
  # R4> A
  # R3> f(x)
  # ST(0) -> R3

  #f(x) * lenght
  FMUL %ST(2), %ST(0)
  #STACK
  # R7> iterator
  # R6> sum of rectangles
  # R5> lenght
  # R4> A
  # R3> area of rectangle
  # ST(0) -> R3


  FADD %ST(0), %ST(3)   #adding rec area to tmp sum
  FFREE %ST(0)
  FINCSTP               #zwalnianie pamięci pod R4

jmp LOOP

ZAKONCZ:
  FFREE %ST(0)
  FINCSTP
  FFREE %ST(0)
  FINCSTP
  FFREE %ST(0)
  FINCSTP
  FXCH
  FFREE %ST(0)
  FINCSTP

  #niestety nadal nie zwraca wymarzonej wartosci do C zatem dodaje kolejne linijki super quality kodu
  #MOV  %xmm0, ST(0)
  FST VIV
  #movsd VIV, %xmm0
  cvtss2sd VIV, %xmm0

  # dupa dupa 123 nie dziala wiec lecimy z klasyką gatunku:
  #FIST VIV
  #MOV VIV, %rax
  #klasyka nie pomogla, nadal w C nic nie widac

  #olo
  #mov $1, %rax
  #fstpl   (%rsp)
  #movsd   (%rsp), %xmm0
  #to coś wypisuje bardzo brzydką liczbę ale jakimś cudem zwraca ją do C

  #jak do cholery zrzucić z ST(0) value do esi?!
  #FSTP VIV  #chyba tak...
  #to wyżej niepotrzebne, bo chcę to zostawić w jednostce zmiennoprzecinkowej aby c sobie samo z niej wyjęło ST(0)

  #zdaje się żę w celu zwrócenia value do c należy floaty wrzucić do %xmm0
  #przemek: inty podobno można zwracać po rdi ( bo jest to podobno też rejestr obsługujący pierwszy argument wkładany do funkcji)
  #wychodzenie z funkcji
  #push %rbx
  #lea  format(%rip), %rdi
  #mov  $1, %esi
  #xor %eax, %eax
  #call printf
  #pop %rbx
  pop %rbx
  pop %rsi
  pop %rdi
  # Restore stack pointer
  mov %rbp, %rsp
  # Restore stack
  pop %rbp
  #leave generalnie bylby ładniejszy ale klasyka to klasyka
ret
