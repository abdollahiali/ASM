section .bss
    	digit_ascii resb 1


section .text
	global _start

_start:
	nop
	mov rax, 100003
	call fnc_print_integer


	mov rax, 60
	mov rdi, 0
	syscall

; input: integer stored in rax
; function: print the integer
fnc_print_integer:
	push rax
	call fnc_calc_number_of_digits
	; now, rbx contains the number of digits

	mov r8, rbx
	mov rbx, 10
	mov rax, 1
	cmp r8, 1
	je fnc_print_integer_loop2
	
	fnc_print_integer_loop1:
		mul ebx
		dec r8
		cmp r8, 1
		jne fnc_print_integer_loop1

	fnc_print_integer_loop2:
	; now, rax contains the order of the number; for example if the number is 271 the order is 100
	mov rbx, rax
	pop rax ; poping the number into rax
	
	fnc_print_integer_loop3:
		mov rdx, 0
		div rbx

		push rdx
		call fnc_print_digit; prints the digit in rax

		; divide rbx by 10
		mov rdx, 0
		mov rax, rbx
		mov rbx, 10
		div rbx
		mov rbx, rax

		pop rdx

		
		mov rax, rdx
		cmp rdx, 0
		jne fnc_print_integer_loop3

	ret

		
		
	
	

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


