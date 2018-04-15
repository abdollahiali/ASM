%include "asm_nasm.inc"

section .data
	new_line db 10,0

section .text
	global _start

_start:
	pop rax
	printint rax
	exit
