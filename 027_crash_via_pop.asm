; this program crashes because of two many pops
%include "asm_nasm.inc"

section .data
	str1 db "Stack pointers: ", 0

section .text
	global _start

_start:
	printsp str1
	pop rax
	jmp _start
	exit

	

