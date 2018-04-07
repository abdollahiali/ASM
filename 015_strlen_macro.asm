%include "asm_nasm.inc"

section .data
	str1 db "This is a string.", 0

section .text
	global _start

_start:
	strlen str1
	printint rdx
	exit
	
