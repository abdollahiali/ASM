section .text

; this is an internal function used by factorial macro	
; we assume that the n! is at most 64 bits and rax is enough to hold it
_factorial:
	pop rcx ; the return address
	pop rax
	cmp rax, 1
	jle _factorial_label_factorial_is_one

	push rcx ; the return address
	push rax ; n
	dec rax
	push rax ; n-1
	call _factorial
	pop rbx ; (n-1)!
	pop rax ; n
	pop rcx ; the return address
	mul rbx ; rax becomes n!
	push rax
	push rcx ; the return address
	ret

	_factorial_label_factorial_is_one:
		push 1
		push rcx
		ret

section .data 
	str_rbp db "rbp = ", 0
	str_rsp db ", rsp = ", 0
	new_line db 10, 0

	; data needed for pfshort
	_str_flags db "  RF  NT  IOPL  OF  DF  IF  TF  SF ZF  AF  PF  CF", 10, 0
	_str_one_w_space db "  1 ", 0
	_str_zero_w_space db "  0 ", 0
	_str_3_spaces db "   ", 0
	_print_IOPL_str_00 db "00 ", 0
	_print_IOPL_str_01 db "01 ", 0
	_print_IOPL_str_10 db "10 ", 0
	_print_IOPL_str_11 db "11 ", 0

section .bss
	char_space resb 100
	_str_digit resb 1



;-----------------------------List of Macros---------------------------------
; 	MACRO								DESCRIPTION
; 	exit
; 	printstr
; 	printint val
; 	strlen str 				output: rdx	the str is a pointer to the string and the string ends with 0
; 	str2int str						 output:rax
; 	al_power_bl 						al^bl, output: rax
; 	printsp str						prints str and the contenst of rbp and rsp
; 	printbin_long integer					prints the binary form (64 bits version)
; 	printbin integer					prints the binary form (without any zero on the left-hand side)
; 	printhex integer					prints the hex form
;	pfshort 						prints these flags: RF  NT  IOPL  OF  DF  IF  TF  SF ZF  AF  PF  CF 
;	factorial n				output: rax	n!
;----------------------------------------------------------------------------


%macro exit 0
	mov rax, SYS_EXIT
	mov rdi, 0
	syscall
%endmacro


%macro printstr 1
;**************************************************************************************************
; input: a pointer to a string
; output: none
; function: prints the string
;**************************************************************************************************

	push rax
	push rdi
	push rsi
	push rdx
	
	mov rax, 1
	mov rdi, 1
	mov rsi, %1 ; rsi now hold the prointer to the the string
	strlen rsi   ; rdx now hold the length of the string
	syscall

	pop rdx
	pop rsi
	pop rdi
	pop rax

%endmacro

%macro printint 1

;**************************************************************************************************
; input: immediate integer or a register or address
; output: none
; function: prints the integer
;**************************************************************************************************	
	push rcx
	push rbx
	push rdx
	push rax
	push rdi
	push rsi

	mov rax, %1

	mov rcx, char_space
	mov rbx, 10

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
	push rax
	push rcx
	mov rax, %1

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
; input: pointer to the string of an integer stored
; output: the integer is saved in rax
; function: coverts the string of an integer to integer
;**************************************************************************************************
	push rdx
	push rcx
	push rbx
	push r8
	mov rax, %1

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
		push rbx ; rbx holds the pointer, so we need to push it if we are going to use rbx for another purpose
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

%macro printsp 1
;**************************************************************************************************
; input: a string
; output: none
; function: prints the string and also the contents of of rbp and rsp followed by a new line
;**************************************************************************************************
	printstr %1
	printstr str_rbp
	printint rbp
	printstr str_rsp
	printint rsp
	printstr new_line
%endmacro

%macro printbin_long 1
;**************************************************************************************************
; input: an integer
; output: none
; function: prints 64-bit-long binary representation of the input
;**************************************************************************************************
	push rax
	push rbx

	mov rax, %1
	mov rbx, 1
	ror rbx, 1 ; rotate to right

	%%printbin_long_label:
		push rax
		and rax, rbx
		jnz %%printbin_long_label_print_one
			printint 0
			jmp %%printbin_long_label_continue
		%%printbin_long_label_print_one:
			printint 1
		%%printbin_long_label_continue:
		pop rax
		shr rbx, 1
		jnz %%printbin_long_label

	pop rbx
	pop rax
%endmacro


%macro printbin 1
;**************************************************************************************************
; input: an integer
; output: none
; function: prints the binary representation of the input
;**************************************************************************************************
	push rax
	push rbx
	push rdx
	mov rdx, 0; this is used as a flag so that we do not print the zeros on the left-hand side of the binary representation

	mov rax, %1
	mov rbx, 1
	ror rbx, 1 ; rotate to right

	%%printbin_label:
		push rax
		and rax, rbx
		jnz %%printbin_label_print_one
			cmp rdx, 0
			jz %%printbin_label_continue ; skip printing zero
				printint 0
				jmp %%printbin_label_continue
		%%printbin_label_print_one:
			printint 1
			cmp rdx, 1
			jz %%printbin_label_continue
				mov rdx, 1
		%%printbin_label_continue:
		pop rax
		shr rbx, 1
		jnz %%printbin_label

	pop rdx
	pop rbx
	pop rax
%endmacro

%macro printhex 1
;**************************************************************************************************
; input: an integer
; output: none
; function: prints the hex representation of the input
;**************************************************************************************************
	push rax
	push rbx
	push rdx
	push r8

	mov rdx, 0; this is used as a flag so that we do not print the zeros on the left-hand side of the binary representation

	mov rax, %1
	mov rbx, 15 ;  eqivalent to 1111 in binary
	ror rbx, 4; rotate to right four times
	mov r8, 0x10; rax is 16 nibble and if the left-most nibble is 1111 we can shift it 15 nibbles

	%%printhex_label:
		push rax
		and rax, rbx
		cmp r8, 1
		jz %%printhex_skip_4shr
		push r8
		dec r8
		%%printhex_loop:
			shr rax, 4; this brings the nibble to the right-most
			dec r8
			jnz %%printhex_loop
		
		pop r8
		
		%%printhex_skip_4shr: 
		cmp rax, 0
		jnz %%printhex_print_nozero
			cmp rdx, 0
			jz %%printhex_continue ; skip printing zero
				printint 0
				jmp %%printhex_continue
		%%printhex_print_nozero:
			printnibble_in_hex rax
			cmp rdx, 1
			jz %%printhex_continue
				mov rdx, 1
		%%printhex_continue:
		pop rax
		shr rbx, 4; shift rbx one nibble to right
		dec r8
		jnz %%printhex_label

	pop r8
	pop rdx
	pop rbx
	pop rax
%endmacro

%macro printnibble_in_hex 1
	push rax
	push rdi
	push rsi
	push rdx

	mov rax, %1
	mov rdi, _str_digit
	cmp rax, 10
	jl %%printnibble_in_hex_less_than_10
	sub rax, 10
	add rax, 97 ; 97 is ASCII for 'a'
	jmp %%printnibble_in_hex_print_hex

	%%printnibble_in_hex_less_than_10:
	add rax, 48
	
	%%printnibble_in_hex_print_hex:
	mov [rdi], rax
	mov rax, 1
	mov rdi, 1
	mov rsi, _str_digit
	mov rdx, 1
	syscall
	
	pop rdx
	pop rsi
	pop rdi
	pop rax
%endmacro


%macro pfshort 0
;**************************************************************************************************
; input: none
; output: none
; function: prints these flags: RF  NT  IOPL  OF  DF  IF  TF  SF ZF  AF  PF  CF 
; it uses two other macros namely _print_flag and _print_IOPL
;**************************************************************************************************
	push rax

	pushfq
	
	printstr _str_flags
	
	;print RF (Resume flag)
	_print_flag 0x10000

	;print NT (Nested task)
	_print_flag 0x4000
	
	;print IOPL (I/O privilege level)
	_print_IOPL

	;print OF (Overflow flag)
	_print_flag 0x800

	;print DF (Direction flag)
	_print_flag 0x400
	
	;print IF (Interrup enable flag)
	_print_flag 0x200

	;print TF (Trap flag)
	_print_flag 0x100

	;print SF (Sign flag)
	_print_flag 0x80

	;print ZF (Zero flag)
	_print_flag 0x40

	;print AF (Adjust flag)
	_print_flag 0x10

	;print PF (Parity flag)
	_print_flag 0x4

	;print CF (Carry flag)
	_print_flag 0x1

	pop rax ;this is just to remove the rflags from the stack that have been pushed by _print_flag 0x1

	printstr new_line

	pop rax
	
%endmacro

%macro _print_flag 1
	pop rax
	push rax
	and rax, %1
	cmp rax, 0
	jz %%_print_flag_0
	printstr _str_one_w_space
	jmp %%_print_flag_skip_0
	%%_print_flag_0:
		printstr _str_zero_w_space
	%%_print_flag_skip_0:
%endmacro

%macro _print_IOPL 0
	pop rax
	push rax
	and rax, 0x3000
	shr rax, 11
	printstr _str_3_spaces
	cmp rax, 0
	jz %%_print_IOPL_print_zero
	cmp rax, 1
	jz %%_print_IOPL_print_one
	cmp rax, 2
	jz %%_print_IOPL_print_two
	printstr _print_IOPL_str_11
	jmp %%_print_IOPL_endmacro

	%%_print_IOPL_print_zero:
		printstr _print_IOPL_str_00
		jmp %%_print_IOPL_endmacro
	%%_print_IOPL_print_one:
		printstr _print_IOPL_str_01
		jmp %%_print_IOPL_endmacro
	%%_print_IOPL_print_two:
		printstr _print_IOPL_str_10
		jmp %%_print_IOPL_endmacro
	%%_print_IOPL_endmacro:
%endmacro

%macro factorial 1
;**************************************************************************************************
; input: integer
; output: rax (integer) 
; function: calculates the factorial of the input
;**************************************************************************************************
	push rdx
	push rbx
	push rcx
	
	mov rax, %1
	push rax
	call _factorial
	pop rax

	pop rcx
	pop rbx
	pop rdx
%endmacro

;------------------------------------------------------------------------------------------------
; system calls
SYS_EXIT 		equ 	60
SYS_READ		equ	0
SYS_WRITE		equ	1
SYS_OPEN		equ 	2
SYS_CLOSE		equ	3
;------------------------------------------------------------------------------------------------


;------------------------------------------------------------------------------------------------
; file permissions
PRMSN_XRWE 		equ 	0 ; no read, no write, not execute
PRMSN_R 		equ 	1; permission to read
PRMSN_W 		equ 	2; permission to write
PRMSN_E 		equ	4; permission to execute
; combinations of the above can be used for other permissions
; for example 3 means permssion to write and read as 6 = PRMSN_W + PRMSN_R
; Note that permssion number is a four digit octal number
; the first is mostly zero
; the second shows the permission for owner
; the third shows the permission for group
; the fourth shows the permission of other
;------------------------------------------------------------------------------------------------


;------------------------------------------------------------------------------------------------
; file flags
FLAG_READ_ONLY		equ 	0
FLAG_WRITE_ONLY		equ 	1
FLAG_READ_WRITE		equ 	2
FLAG_CREATE		equ	64
;------------------------------------------------------------------------------------------------


;------------------------------------------------------------------------------------------------
STD_IN			equ	0
STD_OUT			equ	1
;------------------------------------------------------------------------------------------------





