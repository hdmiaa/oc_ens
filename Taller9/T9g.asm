;Direccionamiento inmediato
section .data
msg db 'Resultado: ', 0
nl db 10    ; Salto de línea


section .text
global _start

_start:
    ; Imprimir mensaje
    mov eax,4
    mov ebx,1
    mov ecx,msg
    mov edx,11
    int 0x80

    ; Direccionamiento inmediato:
    ; Se carga el carácter '@' (ASCII 64 = 0x40) directamente en AL
    mov al, '@'

    ; Imprimir usando syscall
    mov eax,4
    mov ebx,1
    mov ecx,esp
    sub ecx,1
    mov [ecx],al
    mov edx,1
    int 0x80

    ; Salir del programa
    mov eax,1
    xor ebx,ebx
    int 0x80