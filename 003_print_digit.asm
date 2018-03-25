section .data
	digit db 0, 10

section .text
	global _start

_start:
	mov rax, 5
	call print_digit

	mov rax, 60
	mov rdi, 0
	syscall

print_digit:
	add rax, 48
	mov [digit], al
	mov rax, 1
	mov rdi, 1
	mov rsi, digit
	mov rdx, 2
	syscall
	ret
