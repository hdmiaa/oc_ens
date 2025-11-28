global _start

section .bss
input resb 16

section .data
msg1 db "Ejercicio 1: Ingrese N1: ",0
msg2 db "Ingrese N2: ",0
msg3 db "N1 = N2",10,0
msg4 db "N1 > N2",10,0
msg5 db "N1 < N2",10,0
msg6 db "Negativo",10,0
msg7 db "Positivo",10,0
msg8 db "Cero",10,0
msg9 db "Par",10,0
msg10 db "Impar",10,0
msg11 db "Overflow",10,0
msg12 db "Sin Overflow",10,0
msg13 db "Carry",10,0
msg14 db "Sin Carry",10,0
msg15 db "Minimo: ",0
msg16 db "Maximo: ",0
msg17 db "Ordenado: ",0
msg18 db "Ingrese numero: ",0
newline db 10,0

section .text

_start:
    call EJ1
    call EJ2
    call EJ3
    call EJ4
    call EJ5
    call EJ6
    call EJ7
    call EJ8
    jmp FIN

;=========== Función imprimir cadena ==========
print_str:
    mov eax,4
    mov ebx,1
    int 0x80
    ret

;============ Imprimir salto de línea =========
print_nl:
    mov ecx,newline
    mov edx,1
    call print_str
    ret

;========= Leer número desde teclado ==========
read_int:
    mov eax,3
    mov ebx,0
    mov ecx,input
    mov edx,16
    int 0x80
    mov ecx,input
    xor eax,eax
    xor ebx,ebx
.loop:
    mov bl,[ecx]
    cmp bl,10
    je .done
    sub bl,'0'
    imul eax,10
    add eax,ebx
    inc ecx
    jmp .loop
.done:
    ret

;======== Imprimir número (positivo) ===========
print_int:
    mov ebx,eax
    mov ecx,10
    mov edi,esp
    dec edi
.loop2:
    xor edx,edx
    div ecx
    add dl,'0'
    dec edi
    mov [edi],dl
    test eax,eax
    jnz .loop2
    mov eax,4
    mov ebx,1
    mov ecx,edi
    mov edx,esp
    sub edx,edi
    int 0x80
    ret

;================ EJERCICIO 1 =================
EJ1:
    mov ecx,msg1
    mov edx,22
    call print_str
    call read_int
    mov ebx,eax

    mov ecx,msg2
    mov edx,12
    call print_str
    call read_int
    mov ecx,eax

    cmp ebx,ecx
    je eq
    jg gt
    jl lt

eq:
    mov ecx,msg3
    mov edx,8
    call print_str
    ret

gt:
    mov ecx,msg4
    mov edx,8
    call print_str
    ret

lt:
    mov ecx,msg5
    mov edx,8
    call print_str
    ret

;================ EJERCICIO 2 =================
EJ2:
    mov ecx,msg18
    mov edx,16
    call print_str
    call read_int
    cmp eax,0
    je ZERO
    js NEG
    jmp POS

ZERO:
    mov ecx,msg8
    mov edx,5
    call print_str
    ret

NEG:
    mov ecx,msg6
    mov edx,8
    call print_str
    ret

POS:
    mov ecx,msg7
    mov edx,8
    call print_str
    ret

;================ EJERCICIO 3 =================
EJ3:
    mov ecx,msg18
    mov edx,16
    call print_str
    call read_int
    mov bl,al
    test bl,bl
    jpe EVEN
    jmp ODD

EVEN:
    mov ecx,msg9
    mov edx,4
    call print_str
    ret

ODD:
    mov ecx,msg10
    mov edx,5
    call print_str
    ret

;================ EJERCICIO 4 =================
EJ4:
    mov ecx,msg1
    mov edx,22
    call print_str
    call read_int
    mov ebx,eax

    mov ecx,msg2
    mov edx,12
    call print_str
    call read_int

    add eax,ebx
    jo OF
    mov ecx,msg12
    mov edx,12
    call print_str
    ret

OF:
    mov ecx,msg11
    mov edx,8
    call print_str
    ret

;================ EJERCICIO 5 =================
EJ5:
    mov ecx,msg1
    mov edx,22
    call print_str
    call read_int
    mov ebx,eax

    mov ecx,msg2
    mov edx,12
    call print_str
    call read_int

    add eax,ebx
    jc CARRY
    mov ecx,msg14
    mov edx,10
    call print_str
    ret

CARRY:
    mov ecx,msg13
    mov edx,5
    call print_str
    ret

;================ EJERCICIO 6 =================
EJ6:
    mov ecx,msg1
    mov edx,22
    call print_str
    call read_int
    mov ebx,eax

    mov ecx,msg2
    mov edx,12
    call print_str
    call read_int
    mov ecx,eax

    call read_int

    mov edx,ebx
    mov esi,ebx
    cmp ecx,edx
    jl MIN2
    cmp ecx,esi
    jg MAX2
NEXT:
    cmp eax,edx
    jl MIN3
    cmp eax,esi
    jg MAX3
    jmp SHOW

MIN2:
    mov edx,ecx
    cmp ecx,esi
    jg MAX2
    jmp NEXT

MAX2:
    mov esi,ecx
    jmp NEXT

MIN3:
    mov edx,eax
    jmp SHOW

MAX3:
    mov esi,eax
    jmp SHOW

SHOW:
    mov ecx,msg15
    mov edx,8
    call print_str
    mov eax,edx
    call print_int
    call print_nl

    mov ecx,msg16
    mov edx,8
    call print_str
    mov eax,esi
    call print_int
    call print_nl
    ret

;================ EJERCICIO 7 =================
EJ7:
    mov ecx,msg1
    mov edx,22
    call print_str
    call read_int
    mov ebx,eax

    mov ecx,msg2
    mov edx,12
    call print_str
    call read_int

    cmp ebx,eax
    jle OK
    xchg eax,ebx

OK:
    mov ecx,msg17
    mov edx,10
    call print_str
    call print_int
    mov ecx," "
    mov edx,1
    call print_str
    mov eax,ebx
    call print_int
    call print_nl
    ret

;================ EJERCICIO 8 =================
EJ8:
    mov eax,0
    mov ecx,10
LOOP:
    call print_int
    call print_nl
    inc eax
    dec ecx
    jnz LOOP
    ret

FIN:
    mov eax,1
    mov ebx,0
    int 0x80