%include "asm_nasm.inc"
; this is exactly the same as '048_sum_pass_arg_stack.asm' except that instead
; of using 'add rsp, 4' after returnig from procedure 'sum', it uses 'ret 4' at the end of
; porcedure 'sum'. This cuases an addition of 4 to rsp after the program returns from 'sum'

section .data
	number1 dw 53
	number2 dw 73
	str1 db 10, "At the start of program:", 10, 0
	str2 db 10, "After pushing two words (a word being two bytes):", 10, 0
	str3 db 10, "After procedure 'sum' being called (the return address (which is 8 bytes) is now on the top of stack):", 10, 0
	str4 db 10, "After pushing rbp and also moving rsp to rbp (this is done so that rbp be used to access the arguments stored on the stack):", 10, 0
	str5 db 10, "Before returning from procedure 'sum':", 10, 0
	str6 db 10, "After returning from procedure 'sum' using 'ret 4':", 10, 0

section .text
	global _start

_start:
	printsp str1
	push word [number1]
	push word [number2]

	mov rax, 0; initialize with zero because the printint uses rax and we are only using the first 16 bit of rax, namely ax
	
	printsp str2
	call sum
	printsp str6
	printint rax
	printstr new_line
	exit

sum:
	printsp str3
	push rbp
	mov rbp, rsp
	printsp str4
	mov ax, [rbp+16]
	mov bx, [rbp+18]
	add ax, bx
	pop rbp
	printsp str5
	ret 4
	
