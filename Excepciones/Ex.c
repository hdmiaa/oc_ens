#include <stdio.h>
#include <stdlib.h>
#include <setjmp.h>
#include <string.h>

/* Variables globales de ejemplo */
int inventario = 5; /* unidades en inventario */

int reservado = 0; /* unidades reservadas para el pedido */

jmp_buf env;

void rollback(const char *razon) {
/* limpieza/rollback global */
if (reservado > 0) {
inventario += reservado;
printf("[ROLLBACK] Se devolvieron %d unidades al

inventario.\n", reservado);
reservado = 0;
}
printf("[ERROR] %s\n", razon);
}

void fail_and_longjmp(const char *razon) {
rollback(razon);
/* saltar de regreso al punto de control con codigo de
error 1 */
longjmp(env, 1);
}

/* Simula reservar items en inventario; falla si no hay
suficiente. */
void reservar_inventario(int cantidad) {
if (cantidad <= 0) {
fail_and_longjmp("Cantidad a reservar invalida");
}
if (inventario < cantidad) {
fail_and_longjmp("Inventario insuficiente");

}
inventario -= cantidad;
reservado += cantidad;
printf("[INFO] Reservadas %d unidades. Inventario

restante: %d\n", cantidad, inventario);
}

/* Simula procesar el pago; falla según una condicion
artificial */
void procesar_pago(const char *metodo, double monto) {
if (strcmp(metodo, "card") == 0) {
/* simulamos fallo si monto > 1000 */
if (monto > 1000.0) {

fail_and_longjmp("Pago con tarjeta rechazado

(limite excedido)");

}
} else if (strcmp(metodo, "paypal") == 0) {
/* aceptamos, nada */
} else {
fail_and_longjmp("Metodo de pago no soportado");
}

printf("[INFO] Pago procesado con %s por %.2f\n", metodo,
monto);
}

/* Confirmacion del pedido: consume la reserva (reservadas ->
vendidas) */
void confirmar_pedido() {
if (reservado > 0) {

printf("[INFO] Pedido confirmado: %d unidades

vendidas.\n", reservado);
reservado = 0;
} else {

printf("[WARN] No hay unidades reservadas para

confirmar.\n");
}
}

int main(void) {
/*variables modificables para probar las excepciones*/
int pedido_cantidad = 3;
const char *metodo_pago = "card";
double monto = 900.0;

printf("Inventario inicial: %d\n", inventario);

/* setjmp devuelve 0 la primera vez; si se vuelve mediante
longjmp devuelve el valor pasado */
if (setjmp(env) == 0) {
/* TRY: intentamos procesar el pedido */
reservar_inventario(pedido_cantidad); /* puede

fallar */

procesar_pago(metodo_pago, monto); /* puede

fallar */

confirmar_pedido();
printf("[SUCCESS] Pedido procesado correctamente.\n");
} else {

/* CATCH: ya se ejecuto rollback dentro de

fail_and_longjmp */

printf("[CATCH] Manejo de la exception completado. No

se confirmo el pedido.\n");
}

printf("Estado final -> inventario: %d, reservado: %d\n",
inventario, reservado);
return 0;
}