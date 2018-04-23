; shifts rax to left logically (rax initialized by 1), and produces all powers of 2 from 2^0 to 2^63
; note that shl of 2^63 results in zero as rax is 64 bits
; this program produces the same result as the 029_shift_logical_left_1.asm
; hoever, this problem uses the "loop" instruciton
; loop instructions uses rcx as counter, decrements it and if the result is nonzero jumps to the label provided after loop
; the range of loop should be short (I think 127 bytes)
; That's why I have put everything in foo function, otherwise it gives error
; Also I have pushed and poped rcx before and after calling foo, because the macros inside foo function change the contents of rcx
; in general this is not a better implementaion for 029_shift_logical_left_1.asm, but I just wanted to use the loop instruction


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

	mov rcx, 64
	label:
		push rcx
		call foo
		pop rcx
		loop label; the loop instruction decrements rcx and if the result is nonzero jumps to the label
	exit

foo:
	shl rax, 1; shifts rax logically to the left 1 time
	printstr str2
	printstr str1
	printint rax
	printstr new_line
	ret
	

