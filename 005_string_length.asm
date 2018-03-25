section .data
	; we assume that the string ends with 0
	txt db "Hello, world!", 0xa, 0

section .text
	global _start

_start:
	mov rax, txt
	call print_txt

	mov rax, 60
	mov rdi, 0
	syscall


print_txt:
	call string_length ; stores in rdx, the length of the string pointed by rax
	mov rsi, rax
	mov rax, 1
	mov rdi, 1
	syscall
	ret

; finds the length of the string pointed by rax
; and saves the length in rdx
string_length:
	push rax
	sub rdx, rdx
loop:
	inc rax
	inc rdx
	mov cl, [rax]
	cmp cl, 0
	jne loop
	pop rax
	ret
	
	










