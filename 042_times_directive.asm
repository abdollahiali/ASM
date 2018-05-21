%include "asm_nasm.inc"

section .data
	str1 times 100 db "This is a test. "
	str2 db 10, 0

section .text
	global _start

_start:
	printstr str1
	exit
