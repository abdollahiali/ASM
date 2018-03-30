section .bss
    	digit_ascii resb 1


section .text
	global _start

_start:
	nop
	mov rax, 100003

	call fnc_print_num_of_digits ; prints the number of digits of an integer stored in rax


	mov rax, 60
	mov rdi, 0
	syscall


; input: integer stored in rax
;function: prints the number of digits of the integer stored in rax
; note that if the number of the digits are greater than 9, although the calculation is correct in fnc_calc_number_of_digits, it is not printed correctly
fnc_print_num_of_digits:
	call fnc_calc_number_of_digits ;calculates the number of digits of the integer stored in rax
	mov rax, rbx
	call fnc_print_digit
	
	ret

; input: integer stored in rax
; output: rbx, number of digits of the number in rax
;calculates the number of digits of the integer stored in rax

fnc_calc_number_of_digits:
	mov rbx, 0 ; rbx is the counter
	mov rcx, 10
	fnc_calc_number_of_digits_loop1:
		inc rbx
		mov rdx, 0
		div rcx
		cmp rax, 0
		jne fnc_calc_number_of_digits_loop1

	ret
	

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


