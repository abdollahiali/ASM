%include "asm_nasm.inc"

; prints the contents of a table using 'xlat'
; In 'xlat', AL contains the index of the table
; rbx contains the address of the table
; and after instruction 'xlat' is executed, 
; AL becomes equal to the content of the table that AL had its index before 'xlat' was executed

section .data
	str1 db "          ", 0
	table db 23, 29, 31


section .text
	global _start

_start:
	mov rbx, table
	mov rax, 0
	printint rax
	xlat
	printstr str1
	printint rax
	printstr new_line

	mov rax, 1
	printint rax
	xlat
	printstr str1
	printint rax
	printstr new_line

	mov rax, 2
	printint rax
	xlat
	printstr str1
	printint rax
	printstr new_line
	
	exit

