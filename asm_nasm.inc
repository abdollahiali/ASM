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
SYS_EXIT equ 60


