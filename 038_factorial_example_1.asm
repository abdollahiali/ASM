%include "asm_nasm.inc"

section .data
	str0 db "This program needs an integer as argument to calculate its factorial.", 10, "Try again with an argument (an integer less than 20).", 10, 0
	str1 db "n = ", 0
	str2 db "n! = ", 0

section .text
	global _start

_start:
	pop rax
	cmp rax, 1
	jg lable_calc_factorial
	printstr str0
	jmp label_exit

	lable_calc_factorial:
	pop rax; pops the file name
	pop rax; pops the first argument and assumes it is the string of an integer
	str2int rax

	printstr str1
	printint rax
	printstr new_line

	factorial rax
	printstr str2
	printint rax
	printstr new_line

	label_exit:
	exit
	
	
