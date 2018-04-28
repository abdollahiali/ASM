%include "asm_nasm.inc"

section .text
	global _start

_start:
	mov rcx, 25 ; counter for number of Fibonacci sequence to be printed
	mov rax, 0
	mov rbx, 1
	loop_1:
		push rcx; rcx is changed by system call

		printint rax
		printstr new_line
		mov rdx, rbx
		add rbx, rax
		mov rax, rdx

		pop rcx
		dec rcx
		jnz loop_1
	exit

