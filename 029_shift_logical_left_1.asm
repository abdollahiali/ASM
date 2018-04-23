; shifts rax to left logically (rax initialized by 1), and produces all powers of 2 from 2^0 to 2^63
; note that shl of 2^63 results in zero as rax is 64 bits

%include "asm_nasm.inc"

section .data
	str0 db "Initial value:", 10, 0
	str1 db "rax = ", 0
	str2 db "After shift logical left 1 time, we have:	", 0

section .text
	global _start

_start:
	mov rax, 1
	printstr str0
	printstr str1
	printint rax
	printstr new_line

	mov rbx, 64
	loop:
		shl rax, 1; shifts rax logically to the left 1 time
		printstr str2
		printstr str1
		printint rax
		printstr new_line
		dec rbx
		jnz loop
	exit
	

