%include "asm_nasm.inc"

section .data
	str_no_file_to_read db "No file entered to be read", 10, "You need to enter the name of the file as second argument and the number of characters to be reas as the third argument.", 10, 0
	str_no_char_to_be_read db "You entered the name of the file.", 10, "But you did not enter the number of characters to be read from the file.", 10, 0
	str_read_file db "Two or more arguments entered.", 10, "The contents of the file to the requested extent:", 10, 0

MAX_NUMBER_OF_CHARS equ 100000

section .bss
	file_contents_read resb MAX_NUMBER_OF_CHARS+1

section .text
	global _start

_start:
	pop rax ; the number of arguments
	mov r8, rax ; counter
	dec r8
	cmp r8, 0
	jz branch_no_file_to_read

	; if the arguments are greater than 1, then then consider the second argument as the name of the file
	pop rax ; pop the name of the program (we don't need it)

	dec r8
	cmp r8, 0
	jz branch_no_char_to_be_read
	
	; if we reach this point it means we have two or more arguments
	; the third argument is assumed as the number of characters that we are going to read from the file
	; we ignore any other argument greater than three

	; open the file with the specified name
	mov rax, SYS_OPEN
	pop rdi ; pop the name of the file which is the second argument
	mov rsi, FLAG_READ_ONLY
	mov rdx, 0
	syscall


	printstr str_read_file
	pop rdx ; pop the number of characters to be read
	push rax ; rax contains the file descriptor and it is needed when we want to close the file
	mov rdi, rax
	str2int rdx ; now, rax contains the number of characters to be read
	mov rdx, rax
	mov rax, SYS_READ
	mov rsi, file_contents_read ; place to save the read characters
	syscall
	
	
	; print the contents
	mov rax, SYS_WRITE
	mov rdi, 1
	mov rsi, file_contents_read
	; rdx contains the number of characters that have been read
	syscall

	pop rdi ; pop the file descriptor
	mov rax, SYS_CLOSE
	syscall

	jmp branch_exit


	branch_no_char_to_be_read:
		printstr str_no_char_to_be_read
		jmp branch_exit
		
	branch_no_file_to_read:
		printstr str_no_file_to_read
	branch_exit:
		exit
		
		

