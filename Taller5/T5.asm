section .data
summand_A_1 db 30 
summand_A_2 db 35
result_A db 0

initial_value_B db 100 
subtract_value_B db 34
result_B db 0

newline db 0xA

section .text
global _start

_start:
mov al, 0 
add al, [summand_A_1]
add al, [summand_A_2]

mov [result_A], al

mov eax, 4
mov ebx, 1
mov ecx, result_A
mov edx, 1
int 0x80

mov al, [initial_value_B] 
sub al, [subtract_value_B] 

mov [result_B], al

mov eax, 4
mov ebx, 1
mov ecx, result_B
mov edx, 1
int 0x80

mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 0x80

mov eax, 1
xor ebx, ebx
int 0x80