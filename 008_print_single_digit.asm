section .bss
    	digit_ascii resb 1


section .text
	global _start

_start:
	nop
	mov rax, 3

	call fnc_print_digit ; prints a single digit integer on screen

	mov rax, 60
	mov rdi, 0
	syscall



; input: single-digit integer stored in rax
; output: none
; function: printing the single-digit integer on screen 
fnc_print_digit:
	mov rdi, digit_ascii
	add rax, 48
	mov [rdi], rax

	mov rax, 1
	mov rdi, 1
	mov rsi, digit_ascii
	mov rdx, 1 ; number of bytes to print
	syscall

	ret


