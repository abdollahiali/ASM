%include "asm_nasm.inc"
; prints two values one positive and one negative
; this programs uses "printsint" macro


section .data
	
	str1 db "value of rax (in hex): ", 0
	str2 db "value of rax if treated as a signed integer (in decimal): ", 0
	x dq 17
	y dq -7
	
	
section .text
	global _start

_start:
	printstr str1
	printhex [x]
	printstr new_line
	printstr str2
	printsint [x]
	printstr new_line

	printstr new_line
	printstr str1
	printhex [y]
	printstr new_line
	printstr str2
	printsint [y]
	printstr new_line
	exit
	
	
