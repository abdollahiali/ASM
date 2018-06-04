%include "asm_nasm.inc"

section .data
	number1 dw 53
	number2 dw 73
	str1 db 10, "At the start of program:", 10, 0
	str2 db 10, "After pushing two words (a word being two bytes):", 10, 0
	str3 db 10, "After procedure 'sum' being called (the return address (which is 8 bytes) is now on the top of stack):", 10, 0
	str4 db 10, "After pushing rbp and also moving rsp to rbp (this is done so that rbp be used to access the arguments stored on the stack):", 10, 0
	str5 db 10, "Before returning from procedure 'sum':", 10, 0
	str6 db 10, "After returning from procedure 'sum':", 10, 0
	str7 db 10, "After execution of 'add rsp, 4' (this is done because the arguments were two word and each used 2 bytes on stack for being stored):", 10, 0

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
	add rsp, 4
	printsp str7
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
	ret
	
