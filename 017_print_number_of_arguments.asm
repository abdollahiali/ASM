%include "asm_nasm.inc"


section .text
	global _start

_start:
	pop rax ; this pops the number of arguments of this program which is 1
	printint rax
	exit
