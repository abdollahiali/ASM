; this program intentionally skips an instruction by manupulating the instruction pointer register (rip)

%include "asm_nasm.inc"

section .data
	str_begin db "Beginning of the program.", 10, 0
	str_inside_foo db "It is inside foo now.", 10, 0
	str_skip db "This string will not be printed.", 10, 0
	str1 db "Previous instruction is intentionally skipped.", 10, 0
	str_end db "End of the program.", 10, 0

section .text
	global _start

_start:
	printstr str_begin
	call foo
	call foo_1
	printstr str1
	printstr str_end
	exit

foo:
	printstr str_inside_foo
	pop rax
	add rax, 8 
	jmp rax ; the program skips call foo_1

foo_1:
	printstr str_skip
	ret

	

