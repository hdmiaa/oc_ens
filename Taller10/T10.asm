section .data
char db 0
newline db 10

section .text
global _start

_start:
; --- INICIO DE LAS INSTRUCCIONES DEL TALLER (Inciso g) ---

    mov al, 103     ; Cargamos el valor ASCII de 'g' (103)

    ; 1. Rotación a la izquierda (ROL)
    rol al, 4       ; Rotamos bits para cambiar la posición
    
    ; 2. Rotación a la derecha (ROR)
    ror al, 4       ; Regresamos los bits a su lugar original (deshace el ROL)
    
    ; 3. Desplazamiento a la izquierda (SHL)
    shl al, 1       ; Multiplicamos por 2 (103 * 2 = 206). 
                    ; Nota: 206 cabe en 8 bits (máx 255), así que no perdemos datos.
    
    ; 4. Desplazamiento a la derecha (SHR)
    shr al, 1       ; Dividimos entre 2 (206 / 2 = 103). Regresamos al valor original.

    ; Al final, AL sigue valiendo 103 ('g')

; --- FIN DE LAS INSTRUCCIONES ---

    ; Guardar en variable char
    mov [char], al

    ; Escribir carácter en consola
    mov eax, 4         ; syscall write
    mov ebx, 1         ; stdout
    mov ecx, char      ; puntero al caracter
    mov edx, 1         ; longitud 1 byte
    int 0x80

    ; Salto de línea (para que se vea limpio)
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Salir del programa
    mov eax, 1         ; syscall exit
    xor ebx, ebx       ; código de salida 0
    int 0x80