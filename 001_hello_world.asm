section .data
	txt db "hello, world", 0xa

section .text
	global _start

_start:
	call hello_world

	mov rax, 60
	mov rdi, 0
	syscall

hello_world:
	mov rax, 1
	mov rdi, 1
	mov rsi, txt
	mov rdx, 13 ;this is the length of our "hello, world" text
	syscall
	ret

	










