%include "asm_nasm.inc"


section .bss
	str_des resb 100

section .data
	str_source db "This program converts lower-case letters to upper-case ones!", 10, 0

section .text
	global _start

_start:
	mov rax, str_source
	printstr rax
	capstr str_des, str_source
	printstr str_des
	exit

