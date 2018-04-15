%include "asm_nasm.inc"
section .data
	new_line db 10, 0


section .text
	global _start

_start:
	pop rax ; rax holds 1 now, because the function has not argument
	printint rax
	printstr new_line
	exit
