; in this example we will see how the push and pop affect the rsp
; in general after each push the rsp decreases by 8
; and after each pop it increases by 8
%include "asm_nasm.inc"


%macro print_sp 1
	printstr %1
	printstr str_rbp
	printint rbp
	printstr str_rsp
	printint rsp
	printstr new_line
%endmacro


section .data
	str_0 db "At the beginning:	", 0
	str_1push db "After one push:		", 0
	str_2push db "After one more push:	", 0
	str_1pop db "After one pop:		", 0
	str_2pop db "After one more pop:	", 0

	str_rbp db "rbp = ", 0
	str_rsp db ", rsp = ", 0
	new_line db 10, 0

section .text
	global _start

_start:
	print_sp str_0
	
	push rax
	print_sp str_1push

	push rax
	print_sp str_2push
	
	pop rax
	print_sp str_1pop

	pop rax
	print_sp str_2pop

	exit
	


