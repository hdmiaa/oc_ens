section .data
msg_ok db "Operacion completada", 10, 0
msg_err db "Se produjo un error: codigo=", 0

section .bss
error_code resb 1 ; 0 = ok, otro = error

section .text
global _start

_start:
mov byte [error_code], 0 ; limpiar error

; TRY block (label TRY_START)
TRY_START:
; ejemplo: intentar una operacion crítica
; (simula falla si eax == 0)
mov eax, 0 ; cambiar a 0 para provocar error demo
cmp eax, 0
je .raise_error ; si hay condición, saltar a 'raise'

; operación exitosa (continuar)
; ... (código normal)

jmp TRY_END

.raise_error:
; establecer código de error y saltar al manejador
mov byte [error_code], 1 ; 1 = fallo de ejemplo
jmp CATCH_HANDLER

TRY_END:
; código que corre si no hubo error
; imprimir msg_ok (pseudo-instrucción)
; CALL PRINT(msg_ok)
jmp FINALLY

CATCH_HANDLER:
; CATCH block: manejar el error
; leer error_code
mov al, [error_code]
cmp al, 1
je .handle_type1
; otros manejadores...
jmp .catch_done

.handle_type1:
; manejar tipo 1 de error
; por ejemplo: revertir cambios, limpiar recursos
; ... (código de limpieza)
; registrar o preparar respuesta de error
; CALL PRINT(msg_err + codigo)
jmp .catch_done

None
.catch_done:
; después de manejar el error, se decide:
; - terminar programa
; - reintentar
; - saltar a FINALLY
jmp FINALLY

FINALLY:
; bloque 'finally' corre siempre
; limpiar recursos finales
; terminar programa
; EXIT