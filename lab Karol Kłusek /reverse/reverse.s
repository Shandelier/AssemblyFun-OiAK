.data
STDIN = 0     #strumien wejscia
STDOUT = 1    # strumien wyjscia
SYSREAD = 0   #systemowa funcja czytania z STDIN
SYSWRITE = 1  #systemowa funkcja pisania w STDOUT
SYSEXIT = 60
EXIT_SUCCESS = 0
BUFLEN = 512  #wlasna zmienna
KONIEC_LINI= 0xA  #znak zakonczenia linii

.bss                    #def buforów
.comm textin, BUFLEN     #możliwe ze wymagany jest $

.text                   #
.globl _start           #poczatek programu

#main:
_start:
movq $SYSREAD, %rax   #wrzucasz numer sysread do RAX
movq $STDIN,   %rdi   #(pierwszy parametr mówiący skąd czytać (numer pliku gdzie jest wejście))
movq $textin,  %rsi   #(drugi parametr mółiący gdzie zapisać)
movq $BUFLEN,  %rdx   #jak duzo znaków może być odczytane
syscall     #wywolanie funkcji systemowej

movq %rax, %r8
movq %rax, %rsi      #będzie zwrócona wartość przez sysread, czyli ilość wczytanych znaków
movq $0,   %rdi     #zerowanie rdi
dec %rsi
dec %rsi          # żeby skopiować ostatni znak, a nie ten po ostatnim -

petla:
  movb textin (, %rsi, 1), %bl
  movb textin (, %rdi, 1), %cl
  movb %cl, textin(, %rsi, 1)
  movb %bl, textin(, %rdi, 1)

  inc %rdi
  dec %rsi
  cmp %rdi, %rsi
  jg petla

wyswietl:
movq $SYSWRITE, %rax
movq $STDOUT, %rdi
movq $textin, %rsi
movq %r8, %rdx
syscall

movq $SYSEXIT, %rax
movq $EXIT_SUCCESS, %rdi
syscall
