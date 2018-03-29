section .bss
    	num_string resb 100


section .text
	global _start

_start:
	nop
	mov rax, 100003

	call fnc_num2str ; saves the integer stored in rax as a string in num_string with a CR (ASCII of 10) at the end

	inc rbx ; to type the CR that we appended to the end of the string

	mov rax, 1
	mov rdi, 1
	mov rsi, num_string
	mov rdx, rbx
	syscall

	mov rax, 60
	mov rdi, 0
	syscall




; converts the integer in rax to a string and save the string in num_string with a CR (ASCII of 10) at the end
fnc_num2str:
    call fnc_digit_counts ; finds the number of digits of the integer saved in rax and saves it in rbx

    push rbx ;  since rbx contains the number of the digits of the integer, and we need it later


    ;inc rbx ; make room for CR
    mov rcx, num_string
    add rcx, rbx

    mov dl, 10
    mov [rcx], dl

    mov r8, 10
    loop_store_number:
        dec rcx
        dec rbx
        mov rdx, 0
        div r8

        ; store ASCII of the digit in rdx
        add dl, 48
        mov [rcx], dl
        cmp rax, 0
        jne loop_store_number

    pop rbx
    ret

; inpput: integer in rax
; output: integer in rbx
; function: number of digits of the integer input
fnc_digit_counts:
	push rax
    	mov rcx, 10 ; used for division to find the lsb in decimal
    	mov rbx, 0 ; this is the counter

	loop_digits:
    		add rbx, 1
		mov rdx, 0 ; this should be zero, because the div instruction, assumes (rdx:rdx) as a 128-bit input
    		div rcx
   		cmp rax, 0
    		jne loop_digits
	pop rax
	ret

