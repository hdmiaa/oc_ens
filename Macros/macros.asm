section .data
array dd 1, 2, 3, 4, 5

section .text
    mov ecx, 0
    mov eax, 0
    ;Direccionamiento indexado (base + índice × tamaño)
    mov ebx, [array + ecx*4]
    add eax, ebx
    
;Estructura de control repetitiva (tipo FOR o WHILE)
    inc ecx
    cmp ecx, 5
    jl bucle

;Macro para imprimir (abstracción del código)
    %macro print_int 1
    mov eax,4
    mov ebx,1
    mov ecx,%1
    mov edx,4
    int 0x80
    %endmacro

    mov eax,1
    xor ebx,ebx
    int 0x80