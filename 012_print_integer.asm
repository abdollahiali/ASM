section .bss
	char_space resb 100

section .text
	global _start

_start:
	mov rax, 100003
	call print_integer1

	mov rax, 60
	mov rdi, 0
	syscall

;**************************************************************************************************
; input: integer stored in rax
; output: none
; function: prints the integer
;**************************************************************************************************
print_integer1:
	push rcx
	push rbx
	push rdx
	push rax
	push rdi
	push rsi

	mov rcx, char_space
	mov rbx, 10
	mov [rcx], bl

	print_digit_loop1:
		inc rcx
		mov rdx, 0
		div rbx
		add rdx, 48
		mov [rcx], dl
		
		cmp rax, 0
		jne print_digit_loop1

	print_digit_loop2:
		mov rax, 1
		mov rdi, 1
		mov rsi, rcx
		mov rdx, 1

		push rcx
		syscall
		pop rcx

		dec rcx
		cmp rcx, char_space-1
		jne print_digit_loop2


	pop rsi
	pop rdi
	pop rax
	pop rdx
	pop rbx
	pop rcx

	ret


