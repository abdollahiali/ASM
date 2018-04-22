; this program shows the stack pointer when a function is called
; the rsp decreases with calling foo function
%include "asm_nasm.inc"

section .data
	str_begin db "At the beginning:		", 0
	str_1push db "After first push:		", 0
	str_foo db "Inside foo:			", 0
	str_foo_ret db "After returning from foo:	", 0

section .text
	global _start

_start:
	printsp str_begin
	push rax
	printsp str_1push
	call foo
	printsp str_foo_ret
	exit

foo:
	printsp str_foo
	ret

