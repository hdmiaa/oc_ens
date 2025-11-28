; Taller 12: Estructura x/x/x y Macro de Suma (NASM - Linux)

section .data
    ; 1. Estructura x/x/x
    ; Se simula como un arreglo de 3 Double Words (DD = 4 bytes)
    STRUCTURE_X_X_X:
        DD 10  ; X1 (Offset 0)
        DD 20  ; X2 (Offset 4)
        DD 30  ; X3 (Offset 8)

section .text

; 2. Definición del Macro: SUM_ELEMENTS
; Argumentos:
; %1: Etiqueta de la estructura (ej: STRUCTURE_X_X_X)
; %2: Registro donde se almacenará el resultado (ej: EAX)
%macro SUM_ELEMENTS 2
    
    MOV %2, 0               ; Inicializa el registro de resultado (%2) a cero.
    
    ; Suma del Elemento 1 (X1)
    ADD %2, DWORD [%1 + 0]  ; Accede a X1 (Offset 0) y lo suma al registro de resultado.
    
    ; Suma del Elemento 2 (X2)
    ADD %2, DWORD [%1 + 4]  ; Accede a X2 (Offset 4) y lo suma.
    
    ; Suma del Elemento 3 (X3)
    ADD %2, DWORD [%1 + 8]  ; Accede a X3 (Offset 8) y lo suma.
    
%endmacro

global _start

_start:
    
    ; 3. Llamada al Macro
    ; Resultado: EAX = 10 + 20 + 30 = 60
    SUM_ELEMENTS STRUCTURE_X_X_X, EAX ; Llama al macro, guarda la suma en EAX.
    
    ; --- Salida del Programa (System Call) ---
    MOV EBX, EAX            ; Mueve el resultado (60) a EBX para usarlo como código de salida.
    MOV EAX, 1              ; Número de syscall para sys_exit (salir del programa).
    INT 0x80                ; Ejecuta la interrupción.

; **Este código cumple con el requisito de usar al menos un macro y una estructura (arreglo de 3 elementos).**