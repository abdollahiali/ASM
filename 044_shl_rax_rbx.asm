%include "asm_nasm.inc"

section .data
	str_0 db "initial value of rax:rbx (binary): ", 10, 0
	str_rax_rbx db "		    			consectuive execution of 'shl rax:rbx, 1'			", 10, \
		       "-----------------------------------------------------------------------------------------------------------------------------------------", 10, 0

section .text
	global _start

_start:
	mov rax, 123456789
	mov rbx, 999999999999999999
	
	printstr str_0
	printbin_long rax
	printbin_long rbx
	printstr new_line
	printstr new_line

	printstr str_rax_rbx
	mov r8, 30 ; number of times the shift operation is performed
	label:
		call fnc_shl_rax_rbx
		printbin_long rax
		printbin_long rbx
		printstr new_line
		dec r8
		jnz label
	exit

fnc_shl_rax_rbx:
	shl rbx, 1
	rcl rax, 1
	ret
	
