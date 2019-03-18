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
.comm textout, BUFLEN   #.comm definicja typu char[512]

.text                   #
.globl _start           #poczatek programu

_start:
movq $SYSREAD, %rax   #wrzucasz numer sysread do RAX
movq $STDIN,   %rdi   #(pierwszy parametr mówiący skąd czytać (numer pliku gdzie jest wejście))
movq $textin,  %rsi   #(drugi parametr mółiący gdzie zapisać)
movq $BUFLEN,  %rdx   #jak duzo znaków może być odczytane
syscall     #wywolanie funkcji systemowej

movq %rax, %r8      #będzie zwrócona wartość przez sysread, czyli ilość wczytanych znaków
movq $0,   %rdi     #zerowanie rdi
dec %r8
#jmp petla   # w tym miescu bezsensowna komenda

petla:
  #uppercase poprzez XOR 0x20
  #offset(%base, %index, multiplier)
  #textin wskazuje gdzie to est w pamieci
  #rdi indeks znaku, zmienna iteratacyjna
  # 1 odczytywnanie jednego bajtu za jednym razem
  # na koniec przeniesienie do %al (l oznacza dolny cz rej)
movb textin( , %rdi, 1), %al
cmp $'A', %al
jl dalej
cmp $'z', %al
jg dalej
cmp $'Z', %al
jle zamien
cmp $'a', %al
jge zamien
jmp dalej

zamien:
xor $0x20, %al

dalej:
movb %al, textout( , %rdi, 1)

inc %rdi
cmp %r8, %rdi     #compare
jle petla       #jump if less or equal
#jmp wyswietl

wyswietl:
movq $SYSWRITE, %rax
movq $STDOUT, %rdi
movq $textout, %rsi
movq %r8, %rdx
syscall

movq $SYSEXIT, %rax
movq $EXIT_SUCCESS, %rdi
syscall
