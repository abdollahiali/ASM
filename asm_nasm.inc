section .bss
	char_space resb 100


%macro exit 0
	mov rax, SYS_EXIT
	mov rdi, 0
	syscall
%endmacro


%macro printint 1

;**************************************************************************************************
; input: integer stored in rax
; output: none
; function: prints the integer
;**************************************************************************************************
	mov rax, %1
	push rcx
	push rbx
	push rdx
	push rax
	push rdi
	push rsi

	mov rcx, char_space
	mov rbx, 10
	mov [rcx], bl

	%%print_digit_loop1:
		inc rcx
		mov rdx, 0
		div rbx
		add rdx, 48
		mov [rcx], dl
		
		cmp rax, 0
		jne %%print_digit_loop1

	%%print_digit_loop2:
		mov rax, 1
		mov rdi, 1
		mov rsi, rcx
		mov rdx, 1

		push rcx
		syscall
		pop rcx

		dec rcx
		cmp rcx, char_space-1
		jne %%print_digit_loop2


	pop rsi
	pop rdi
	pop rax
	pop rdx
	pop rbx
	pop rcx

%endmacro



%macro strlen 1
;**************************************************************************************************
; input: rax as pointer to a string
; output: rdx as an integer
; function: finds the length of the string pointed by rax and saves the length in rdx
;**************************************************************************************************
	mov rax, %1
	push rax
	push rcx

	sub rdx, rdx
	%%fnc_string_length_loop:
        	inc rax
        	inc rdx
        	mov cl, [rax]
        	cmp cl, 0
        	jne %%fnc_string_length_loop
	pop rcx
	pop rax
%endmacro


%macro str2int 1
;**************************************************************************************************
; input: string of an integer stored in the address pointed by rax
; output: the integer is saved in rax
; function: coverts the string of an integer to integer
;**************************************************************************************************
	mov rax, %1
	push rdx
	push rcx
	push rbx
	push r8

	push rax
	strlen rax ; stores in rdx, the length of the string pointed by rax
	mov rcx, 0 ; summation initialization

	mov rax, 10 ; means al = 10
	mov rbx, rdx ; means bl = magnitude of the number
	dec rbx ; for example for 103 we need the mask to be 10^2 not 10^3
	al_power_bl

	mov r8, rax
	pop rbx ; now, rbx points to the start of the string


	%%fnc_string2integer_loop:
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
        	jne %%fnc_string2integer_loop
	mov rax, rcx

	pop r8
	pop rbx
	pop rcx
	pop rdx
%endmacro


%macro al_power_bl 0
;**************************************************************************************************
; input: rax, rbx, but only their al and bl are nonzero
; output: rax
; function: rax = al^bl
;**************************************************************************************************
	push r8
	push rbx

	mov r8, rbx
	mov rbx, rax
	mov rax, 1
	cmp r8, 0

	je %%fnc_al_power_bl_loop

	%%fnc_al_power_bl_loop1:
		mul ebx
		dec r8
		cmp r8, 0
		jne %%fnc_al_power_bl_loop1

	%%fnc_al_power_bl_loop:

	pop rbx
	pop r8
%endmacro

SYS_EXIT equ 60


