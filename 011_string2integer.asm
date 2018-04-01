section .data
	num_string db "100003", 0
section .bss
    	digit_ascii resb 1


section .text
	global _start

_start:
	nop
	mov rax, num_string
	call fnc_string2integer

	;  we add a number to rax to make sure that rax has successfully been converted to an integer (here 100003)
	; and we expect that 111113 be printed on the screen
	add rax, 11110
	call fnc_print_integer

	mov rax, 60
	mov rdi, 0
	syscall



;**************************************************************************************************
; input: string of an integer stored in the address pointed by rax
; output: the integer is saved in rax
; function: coverts the string of an integer to integer
;**************************************************************************************************
fnc_string2integer:
	push rdx
	push rcx
	push rbx
	push r8

	push rax
	call fnc_string_length ; stores in rdx, the length of the string pointed by rax
	mov rcx, 0 ; summation initialization

	mov rax, 10 ; means al = 10
	mov rbx, rdx ; means bl = magnitude of the number
	dec rbx ; for example for 103 we need the mask to be 10^2 not 10^3
	call fnc_al_power_bl

	mov r8, rax
	pop rbx ; now, rbx points to the start of the string


	fnc_string2integer_loop:
		mov rax, 0
        	mov al, [rbx]
	
        	sub rax, 48 ; to extract the value of the number

		; rcx = rcx + rax*r8
        	mov rdx, 0
        	mul r8
        	add rcx, rax

		; divide r8 by 10
        	mov rax, r8
		push rbx ; rbx hold the pointer, so we need to push it if we are going to use rbx for another purpose
        	mov rbx, 10
        	div rbx
        	mov r8, rax
		pop rbx
    

		inc rbx ; increment the address to point to the next digital character
        	cmp r8, 0
        	jne fnc_string2integer_loop
	mov rax, rcx

	pop r8
	pop rbx
	pop rcx
	pop rdx
	ret





;**************************************************************************************************
; input: rax as pointer to a string
; output: rdx as an integer
; function: finds the length of the string pointed by rax and saves the length in rdx
;**************************************************************************************************
fnc_string_length:
	push rax
	push rcx

	sub rdx, rdx
	fnc_string_length_loop:
        	inc rax
        	inc rdx
        	mov cl, [rax]
        	cmp cl, 0
        	jne fnc_string_length_loop
	pop rcx
	pop rax
	ret

;**************************************************************************************************
; input: integer stored in rax
; output: none
; function: prints the integer
;**************************************************************************************************
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


;**************************************************************************************************
; input: integer stored in rax
; output: none
;function: prints the number of digits of the integer stored in rax
; note that if the number of the digits are greater than 9, although the calculation is correct in fnc_calc_number_of_digits, it is not printed correctly
;**************************************************************************************************
fnc_print_num_of_digits:
	push rax

	call fnc_calc_number_of_digits ;calculates the number of digits of the integer stored in rax
	mov rax, rbx
	call fnc_print_digit

	pop rax

	ret

;**************************************************************************************************
; input: integer stored in rax
; output: rbx, number of digits of the number in rax
;calculates the number of digits of the integer stored in rax
;**************************************************************************************************
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

;**************************************************************************************************
; input: single-digit integer stored in rax
; output: none
; function: printing the single-digit integer on screen
;**************************************************************************************************
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



;**************************************************************************************************
; input: rax, rbx, but only their al and bl are nonzero
; output: rax
; function: rax = al^bl
;**************************************************************************************************
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
