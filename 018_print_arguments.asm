%include "asm_nasm.inc"

section .data
	str1 db "The number of argumerns: ", 0
	str2 db "Argument #", 0
	str3 db ": ", 0
	new_line db 10,0

section .text
	global _start

_start:
	pop rax
	printstr str1
	printint rax
	printstr new_line
	
	mov r8, 1; counter

	_start_loop:
		printstr str2
		printint r8
		printstr str3
		
		pop rsi
		printstr rsi
		printstr new_line
		inc r8
		dec rax
		cmp rax, 0
		jnz _start_loop
	exit
