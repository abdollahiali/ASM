%include "asm_nasm.inc"


section .data
	str1 db "Test", 0
	str2 dw 0x6554, 0x7473, 0x0000; based on little-endian storage, the str2 is as follows, 0x54, 0x65, 0x73, 0x64, 0x00, 0x00
				      ; the first four bytes in ASCII are equal to 'T', 'e', 's', 't'
section .text
	global _start

_start:
	printstr str1
	printstr new_line
	printstr str2
	printstr new_line
	exit
	
	
