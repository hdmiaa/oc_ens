;Direccionamiento Indirecto

section .data
msg db 'Resultado: ', 0
caracter db '@'        ; Guardado en memoria (data segment)

section .text
global _start

_start:
    ; Imprimir mensaje
    mov eax,4
    mov ebx,1
    mov ecx,msg
    mov edx,11
    int 0x80

    ; Direccionamiento indirecto:
    ; Usamos ECX como puntero a la dirección del carácter en memoria
    mov ecx, caracter
    mov al, [ecx]       ; AL toma el valor desde la dirección apuntada (indirecto)

    ; Imprimir carácter que está en memoria
    mov eax,4
    mov ebx,1
    mov ecx,esp
    sub ecx,1
    mov [ecx],al
    mov edx,1
    int 0x80

    ; Salir
    mov eax,1
    xor ebx,ebx
    int 0x80