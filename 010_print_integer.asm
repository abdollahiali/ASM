section .bss
    	digit_ascii resb 1


section .text
	global _start

_start:
	nop
	mov rax, 1020
	call fnc_print_integer


	mov rax, 60
	mov rdi, 0
	syscall

; input: integer stored in rax
; output: none
; function: print the integer
fnc_print_integer:
	push rbx
	push rax
	push rdx

	call fnc_calc_number_of_digits ; now, rbx contains the number of digits

    	; we assume that the number of digits are not greater that 127 so it fits in bl


    	push rax
    	mov rax, 10
    	dec rbx
	;rax = al^bl
    	call fnc_al_power_bl


	; now, rax contains the order of the number; for example if the number is 271 the order is 100
	mov rbx, rax

	pop rax ; poping the number into rax

	fnc_print_integer_loop3:
		mov rdx, 0
		div rbx


		call fnc_print_digit; prints the digit in rax

        	push rdx

		; divide rbx by 10
		mov rdx, 0
		mov rax, rbx
		mov rbx, 10
		div rbx
		mov rbx, rax

        	pop rdx



		mov rax, rdx
		cmp rbx, 0
		jne fnc_print_integer_loop3


	pop rdx
	pop rax
	pop rbx

	ret






; input: integer stored in rax
; output: none
;function: prints the number of digits of the integer stored in rax
; note that if the number of the digits are greater than 9, although the calculation is correct in fnc_calc_number_of_digits, it is not printed correctly
fnc_print_num_of_digits:
	push rax

	call fnc_calc_number_of_digits ;calculates the number of digits of the integer stored in rax
	mov rax, rbx
	call fnc_print_digit

	pop rax

	ret

; input: integer stored in rax
; output: rbx, number of digits of the number in rax
;calculates the number of digits of the integer stored in rax

fnc_calc_number_of_digits:
	push rcx
	push rdx
	push rax

	mov rbx, 0 ; rbx is the counter
	mov rcx, 10
	fnc_calc_number_of_digits_loop1:
		inc rbx
		mov rdx, 0
		div rcx
		cmp rax, 0
		jne fnc_calc_number_of_digits_loop1

	pop rax
	pop rdx
	pop rcx

	ret


; input: single-digit integer stored in rax
; output: none
; function: printing the single-digit integer on screen
fnc_print_digit:
	push rdi
	push rax
	push rsi
	push rdx

	mov rdi, digit_ascii
	add rax, 48
	mov [rdi], rax

	mov rax, 1
	mov rdi, 1
	mov rsi, digit_ascii
	mov rdx, 1 ; number of bytes to print
	syscall

	pop rdx
	pop rsi
	pop rax
	pop rdi

	ret


; input: rax, rbx, but only their al and bl is nonzero
; output: rax = al^bl
fnc_al_power_bl:
	push r8
	push rbx

	mov r8, rbx
	mov rbx, rax
	mov rax, 1
	cmp r8, 0

	je fnc_al_power_bl_loop

	fnc_al_power_bl_loop1:
		mul ebx
		dec r8
		cmp r8, 0
		jne fnc_al_power_bl_loop1

	fnc_al_power_bl_loop:

	pop rbx
	pop r8

	ret
