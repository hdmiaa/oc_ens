section .data        
msg db 'A, $, &, 1', 10, 0     ; Cadena con los caracteres pedidos, seguida de salto de línea

section .text
global _start

_start:
    mov eax,4         
    mov ebx,1         
    mov ecx,msg       
    mov edx,11        ; Longitud exacta: A(1), ,(1), $(1), ,(1), &(1), ,(1), 1(1) = 7 + 4 comas/espacios = 11
    int 0x80          

    mov eax,1         
    xor ebx,ebx       
    int 0x80          