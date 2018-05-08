%include "asm_nasm.inc"

section .data
	str1 db "n = ", 0
	str2 db "n! = ", 0

section .text
	global _start

_start:
	mov rax, 9
	printstr str1
	printint rax
	printstr new_line

	factorial 9
	
	printstr str2
	printint rax
	printstr new_line

	exit





