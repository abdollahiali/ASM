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
	str4 db 10, "After executing 'enter 20, 0' (it is equivalent to '1. push rbp 2. mov rbp, rsp 3. add rsp, 20'):", 10, 0
	str5 db 10, "Before returning from procedure 'sum' (after executing 'leave', which is equal to '1. mov rsp, rbp 2. pop rbp'):", 10, 0
	str6 db 10, "After returning from procedure 'sum' using 'ret 4':", 10, 0
	str_sum db "result of sum: ", 0

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
	printstr new_line
	printstr str_sum
	printint rax
	printstr new_line
	exit

sum:
	printsp str3
	enter 20, 0
	printsp str4
	mov ax, [rbp+16]
	mov bx, [rbp+18]
	add ax, bx
	leave
	printsp str5
	ret 4
	
