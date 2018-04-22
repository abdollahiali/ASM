; this program uses pop rax and jmp rax instead of return
; the return instruction (ret) acctually pops the latest value from the stack
; and puts that value in instruction pointer register (rip)
; instead of using ret we pop the value on top of stach to rax
; the we move the rax to rip by jmp rax

%include "asm_nasm.inc"

section .data
	str_begin db "At the beginning:		", 0
	str_foo db "Inside foo:			", 0
	str_foo_ret db "After returning from foo:	", 0

section .text
	global _start

_start:
	printsp str_begin
	call foo
	printsp str_foo_ret
	exit

foo:
	printsp str_foo
	pop rax
	jmp rax

