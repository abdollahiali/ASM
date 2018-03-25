section .data
	digit db 0, 10

section .text
	global _start

_start:
	; push the following numbers to the stack
	push 2
	push 3
	push 5
	push 7
	

	mov bl, 3

; pop and print the last three numbers on the stack using a loop
loop:  
	pop rax
	call print_digit
	dec bl
	cmp bl, 0
	jne loop


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
