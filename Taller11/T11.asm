section .data
    msg db "Resultado: ", 0
    len equ $ - msg

    msg_error db "ERROR: Division por Cero (Simulacion de Interrupcion)", 0 
    len_error equ $ - msg_error
    
    newline db 10, 0
    lenNL equ $ - newline

section .bss
    resultado resb 1

section .text
    global _start

_start:
    ; ============================
    ; Números hardcoded
    ; ============================
    mov al, '8'       ; Cargar el número 8 (ASCII)
    sub al, '0'       ; Convertir '8' a entero 8

    mov bl, '0'       ; Cargar el divisor '0' (ASCII) para forzar el error
    sub bl, '0'       ; Convertir '0' a entero 0

    ; =================================
    ; SIMULACIÓN DE MANEJO DE INTERRUPCIÓN (INT 0)
    ; =================================
    ; 1. Comparar el divisor (BL) con cero (0).
    cmp bl, 0
    ; 2. Si son iguales (Zero Flag = 1), saltamos al manejador de error.
    je DIVISION_POR_CERO_HANDLER 
    
    ; Si no es cero, la división procede
    JMP REALIZAR_DIVISION

; ============================
; RUTINA DE DIVISIÓN NORMAL
; ============================
REALIZAR_DIVISION:
    xor ah, ah        ; Limpiar AH para la división (AX = 8)
    div bl            ; Realizar la división: AL = AX / BL

    ; ============================
    ; Convertir resultado a ASCII
    ; ============================
    add al, '0'       ; Convertir el resultado (4 si fue 8/2) a ASCII
    mov [resultado], al

    ; ============================
    ; Imprimir "Resultado: "
    ; ============================
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, len
    int 0x80

    ; ============================
    ; Imprimir el resultado (el número)
    ; ============================
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 1
    int 0x80
    
    ; Salta al final para evitar ejecutar el manejador de error
    JMP FIN_PROGRAMA 

; =================================
; RUTINA DE MANEJO DE ERROR (HANDLER)
; =================================
DIVISION_POR_CERO_HANDLER:
    ; ============================
    ; Imprimir mensaje de error
    ; ============================
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_error
    mov edx, len_error
    int 0x80
    
    ; Continúa a FIN_PROGRAMA


; ============================
; Imprimir salto de línea y Salir
; ============================
FIN_PROGRAMA:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80