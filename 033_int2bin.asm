%include "asm_nasm.inc"

section .data
	str_no_arg db "The program has no argument.",10, "You need to enter a digit as argument so that the program prints it binary representation.", 10, 0
	str_you_entered db "You entered: ", 0
	str_bin db "Its binary representation is:", 0

section .text
	global _start

_start:
	pop rcx
	dec rcx
	jz label_no_arg
	
	; if the proram reaches here it means the user has entered an argument.
	; we consider only the first argument and neglect any other argument, if any.
	pop rbx;  this pops the name of the prgoram
	pop rbx; this pops the first argument, which we assume is the string of an integer
	str2int rbx; rax now contains the integer value
	
	printstr str_you_entered
	printint rax
	printstr new_line
	
	printstr str_bin
	printbin rax
	printstr new_line
	jmp label_exit
	
	label_no_arg:
	printstr str_no_arg	

	label_exit:
	exit

	


	
	

