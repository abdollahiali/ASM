section .data
	digit db 0, 10


section .text
	global _start

_start:
	mov rax, 31415
	call fnc_digit_counts ; finds the number digits of the integer saved in rax. save its number of digits in rbx

	mov rax, rbx
	call fnc_print_digit

	mov rax, 60
	mov rdi, 0
	syscall


fnc_print_digit:
	add rax, 48
	mov [digit], al
	mov rax, 1
	mov rdi, 1
	mov rsi, digit
	mov rdx, 2
	syscall
	ret

fnc_digit_counts:
    	mov rcx, 10
    	mov rbx, 0 ; this is the counter

	loop_digits:
    		add rbx, 1
		mov rdx, 0
    		div rcx
   		cmp rax, 0
    		jne loop_digits

 	ret








