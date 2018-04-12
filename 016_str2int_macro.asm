%include "asm_nasm.inc"

section .data
	str1 db "100003", 0

section .text
	global _start

_start:
	str2int str1
	printint rax
	exit
