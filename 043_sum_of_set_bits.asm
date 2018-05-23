%include "asm_nasm.inc"

section .data
	str_dec db          "Number (decimal)                                : ", 0
	str_hex db          "Number (hex)                                    : ", 0
	str_bin db          "Number (binary)                                 : ", 0
	str_sum_set_bits db "Number of set bits in the binary representation : ", 0

section .text
	global _start

_start:
	mov rax, 0x123456789
	printstr str_dec
	printint rax
	printstr new_line
	
	printstr str_hex
	printhex rax
	printstr new_line
	printstr str_bin
	printbin rax
	printstr new_line

	; calculate the number of set bits in rax
	mov rcx, 64 ; counter for loop instruction
	mov rbx, 0 ; initialization
	label:
		shl rax, 1
		jnc label_skip_inc
		inc rbx
		label_skip_inc:
		loop label

	printstr str_sum_set_bits
	printint rbx
	printstr new_line
	exit
	
