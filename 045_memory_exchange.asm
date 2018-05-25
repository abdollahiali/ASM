%include "asm_nasm.inc"

%macro mxchg 2
	xchg rax, %1
	xchg rax, %2
	xchg rax, %1
%endmacro
	

section .data
	memory_1 dq 11111111
	memory_2 dq 99999999
	str1 db "contents of rax and the two memory data, before memory exchange:", 10, 0
	str2 db "contents of rax and the two memory data, after memory exchange:", 10, 0

section .text
	global _start

_start:
	mov rax, 127

	printstr str1
	printint rax
	printstr new_line	
	printint [memory_1]
	printstr new_line
	printint [memory_2]
	printstr new_line

	printstr new_line
	mxchg [memory_1], [memory_2]

	printstr str2
	printint rax
	printstr new_line	
	printint [memory_1]
	printstr new_line
	printint [memory_2]
	printstr new_line
	
	exit
	
	
