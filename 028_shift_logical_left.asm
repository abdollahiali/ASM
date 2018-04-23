%include "asm_nasm.inc"

section .data
	str0 db "Initial value:", 10, 0
	str1 db "rax = ", 0
	str2 db "After shift logical left 1 time, we have:", 10, 0

section .text
	global _start

_start:
	mov rax, 8
	printstr str0
	printstr str1
	printint rax
	printstr new_line
	printstr new_line

	printstr str2
	printstr str1
	shl rax, 1; shifts rax logically to the left 1 time
	printint rax
	printstr new_line
	exit
	

