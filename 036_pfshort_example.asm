%include "asm_nasm.inc"

%macro print_rax_and_flags 1
	pushfq
	printstr %1
	printstr str_rax
	printint rax
	printstr new_line
	popfq
	pfshort
%endmacro

section .data
	str_begin db "At the start of program:", 10, 0
	str_sub_rax db 10, "After 'sub rax, rax':", 10,\
			   "rax is zero --> zero flag (ZF) is 1", 10,\
			   "all bits of rax are zero --> PF is 1", 10, 0
	str_inc_rax1 db 10, "After 'inc rax':", 10,\
			    "rax is non zero --> ZF is 0", 10,\
			    "sum of bits of rax is odd --> Parity Flag (PF)is 0", 10, 0
	str_inc_rax2 db 10, "After 'inc rax':", 10,\
			    "rax is non zero --> ZF is 0", 10,\
			    "sum of bits of rax is odd --> Parity Flag (PF)is 0", 10, 0
	str_inc_rax3 db 10, "After 'inc rax':", 10,\
			    "rax is non zero --> ZF is 0", 10,\
			    "sum of bits of rax is even --> Parity Flag (PF)is 1", 10, 0

	str_mov_inc_al_1 db 10, "After 'mov al, 0x0F", 10,\
			    "       inc al':", 10,\
			    "al is non zero --> ZF is 0", 10,\
			    "he lower nibble of al has carry on  --> Adjust Flag (AF)is 1", 10, 0
	str_mov_inc_al_2 db 10, "After 'mov al, 0xFFFF", 10,\
			    "       inc al':", 10,\
			    "al is zero (note that rax is non zero but that does not count as we increment al not rax) --> ZF is 1", 10,\
			    "the lower nibble of al has carry on --> Adjust Flag (AF)is 1", 10, 0
	str_1 db 10, "After 'mov rax,0", 10,\
			    "       dec al':", 10, 0
	str_2 db 10, "Continue with 'inc al'", 10, \
		     "Although al is 255 and is incremented, the Carry Flag (CF) is zero.", 10,\
		     "CF is not set by inc and dec instruction.", 10, 0
	str_3 db 10, "After 'mov al, 0xFF", 10, \
		     "       add al, 1':", 10, \
		     "Carry Flag (CF) is set to 1.", 10, 0
	str_4 db 10, "After 'mov al, 0x7F", 10, \
		     "       add al, 1':", 10, \
		     "Sign Flag (SF) is set to 1.", 10, 0
	str_rax db "rax: ", 0


section .data
	global _start

_start:
	print_rax_and_flags str_begin
	

	sub rax, rax
	print_rax_and_flags str_sub_rax	

	inc rax
	print_rax_and_flags str_inc_rax1

	inc rax
	print_rax_and_flags str_inc_rax2

	inc rax
	print_rax_and_flags str_inc_rax3

	mov al, 0x0F
	inc al
	print_rax_and_flags str_mov_inc_al_1

	mov ax, 0xFFFF
	inc al
	print_rax_and_flags str_mov_inc_al_2


	mov rax, 0
	dec al
	print_rax_and_flags str_1

	inc al
	print_rax_and_flags str_2

	mov al, 0xFF
	add al, 1
	print_rax_and_flags str_3

	mov al, 0x7F
	add al, 1
	print_rax_and_flags str_4

	exit


	
