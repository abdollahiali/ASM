; This program uses the stack to pass the address of two arguments of a function.
; It is an example of pass-by-reference

%include "asm_nasm.inc"

%macro print_num1_num2_and_stack 1
	mov rax, 0
	mov rbx, num1
	mov ax, [rbx]
	printstr str_addr
	printint rbx
	printstr str_num
	printint rax
	printstr new_line

	mov rax, 0
	mov rbx, num2
	mov ax, [rbx]
	printstr str_addr
	printint rbx
	printstr str_num
	printint rax
	printstr new_line
	
	printsp %1
	printstr new_line
%endmacro

section .data
	num1 dw 23
	num2 dw 29
	str1 db "Stack status, before caling 'xchg_mem_call_by_ref':", 10, 0
	str2 db "Stack status, after caling 'xchg_mem_call_by_ref':", 10, 0
	str_addr db "Memory address of ", 0
	str_num db " contains: ", 0
	

section .text
	global _start

_start:
	print_num1_num2_and_stack str1

	push num1
	push num2

	call xchg_mem_call_by_ref

	print_num1_num2_and_stack str2
	
	
	exit 

xchg_mem_call_by_ref:
	enter 0, 0; allocates a stack fram. it is equal to: push rbp; mov rbp, rsp; sub rsp, 0
	mov rbx, [rbp + 24] ; mov the address of the first argument to rbx; 24 is 3*8: 8 for rbp being pushed by enter, 8 for the second
			    ; argument, and 8 for the first argument
	push rbx
	xchg ax, [rbx]
	mov rbx, [rbp + 16] ; mov the address of the second argument to rbx
	xchg ax, [rbx]
	pop rbx ; retrieve the address of the first argument
	xchg ax, [rbx]
	leave ; releases the stack frame; it is equal to: mov rsp, rbp; pop rbp
	ret 16; returns and then subtracts rsp by 16 to remove the two arguments (each being 8 bytes) from stack
	
	
