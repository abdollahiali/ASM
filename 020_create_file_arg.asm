%include "asm_nasm.inc"

section .data
	file_name db "my_file.txt", 0
	str_default db "No ragument entered.", 10, "An empty file with my_file.txt name is created.", 10, 0
	str_file_name_only db "One argument entered.", 10, "An empty file with the name of your agument is created.", 10, 0
	str_file_name_and_content db "Two or more arguments entered.", 10, "A file with the name of your first agument is created.", 10, "The file contents are those in your second argument.", 10, "The third and other arguments (if any) are ignored.", 10, 0

section .text
	global _start

_start:
	pop rax ; the number of arguments
	mov r8, rax ; counter
	dec r8
	cmp r8, 0
	jz branch_create_default_file

	; if the arguments are greater than 1, then then consider the second argument as the name of the file
	pop rax ; pop the name of the program (we don't need it)
	
	; create the file with the specified name
	mov rax, SYS_OPEN
	pop rdi ; pop the name of the file which is the second argument
	mov rsi, FLAG_CREATE + FLAG_WRITE_ONLY
	mov rdx, 0664o  ; 0: Special
		       	; 6: Owner Permission(Read (4)+Write (2))
		       	; 6: Group Permission(Read (4)+Write (2))
		      	; 4: Others Permission(Read (4))
	syscall

	dec r8
	cmp r8, 0
	jz branch_file_name_only

	; if we reach this point it means we have other arguments
	; the third argument is assumed as the contents of the file
	; we ignore any other argument greater than three
	printstr str_file_name_and_content
	pop rsi ; pop the contents of the file that will be generated at the end of this program
	push rax ; rax contains the file descriptor and it is needed when we want to close the file
	mov rdi, rax
	mov rax, SYS_WRITE
	strlen rsi ; this puts the length of the third argument in the rdx
	syscall

	pop rax ; pop the file descriptor
	jmp branch_close_file

	
	branch_create_default_file:
		printstr str_default
		mov rax, SYS_OPEN
		mov rdi, file_name
		mov rsi, FLAG_CREATE
		mov rdx, 0664o  ; 0: Special
		       		; 6: Owner Permission(Read (4)+Write (2))
		       		; 6: Group Permission(Read (4)+Write (2))
		      		; 4: Others Permission(Read (4))
		syscall
		jmp branch_close_file
	
	branch_file_name_only:
		printstr str_file_name_only
	
	branch_close_file:	
		; close the file
		mov rdi, rax ; move the file description
		mov rax, SYS_CLOSE
		syscall

	exit
		
		

