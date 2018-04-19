%include "asm_nasm.inc"
section .data
	file_name db "my_file.txt",0
	file_contents db "These are the contents of my first file created by assembly.", 10, 0

section .text
	global _start

_start:
	; create and open file
	mov rax, SYS_OPEN
	mov rdi, file_name
	mov rsi, FLAG_CREATE + FLAG_WRITE_ONLY
	mov rdx, 0664o ; 0: Special
		       ; 6: Owner Permission(Read (4)+Write (2))
		       ; 6: Group Permission(Read (4)+Write (2))
		       ; 4: Others Permission(Read (4))
	syscall 
	 
	; write the file_contents into the created file
	; NOTE after the above file creation, the rax contains the file descriptor
	
	push rax ; to be poped when we want to close the file
	mov rdi, rax ; the destination should be the file
	mov rax, SYS_WRITE
	mov rsi, file_contents
	strlen file_contents ; strlen subroutine puts the number of characters of file_contents string into rdx
	syscall

	; close the file
	mov rax, SYS_CLOSE
	pop rdi ; pop the file descriptor
	syscall
		
	exit



