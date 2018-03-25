section .data
	txt1 db "What is your name?", 0xa
	txt2 db "Hello, "
	txt3 db "How are you?", 0xa

section .bss
	name resb 20

section .text
	global _start

_start:
	call print_txt1
	call get_name
	call print_greeting

	mov rax, 60
	mov rdi, 0
	syscall

print_txt1:
	mov rax, 1
	mov rdi, 1
	mov rsi, txt1
	mov rdx, 19
	syscall
	ret

print_txt2:
	mov rax, 1
	mov rdi, 1
	mov rsi, txt2
	mov rdx, 7
	syscall
	ret

print_txt3:
	mov rax, 1
	mov rdi, 1
	mov rsi, txt3
	mov rdx, 13
	syscall
	ret


get_name:
	mov rax, 0
	mov rdi, 0
	mov rsi, name
	mov rdx, 20
	syscall
	ret

print_name:
	mov rax, 1
	mov rdi, 1
	mov rsi, name
	mov rdx, 20
	syscall
	ret


print_greeting:
	call print_txt2
	call print_name
	call print_txt3
	ret

