%include "asm_nasm.inc"




section .data
	str_rax db "rax = ", 0
	str_bin db "Its binary representation is:", 10, 0

section .text
	global _start

_start:
	mov rax, 30
	printstr str_rax
	printint rax
	printstr new_line
	
	printstr str_bin
	printbin_long rax
	printstr new_line
	
	exit

	


	
	

