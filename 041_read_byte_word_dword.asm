%include "asm_nasm.inc"
; read (and print) the stored number in three ways:
;							byte-by-byte
;							word-by-word
;							dword-by-dword
; It helps better understand little-endian strage strategy

section .data
	str_data_dec db "The number in decimal: ", 0
	str_data_hex db "The number in hex    : ", 0
	str1 db "Reading the number, byte by bye:", 10, 0
	str2 db "Reading the number, word by word:", 10, 0
	str3 db "Reading the number, double-word by double-word:", 10, 0
	str_dash db "------------------------------------------------------", 10, 0
	str_caption db "address                                [address]", 10, 0
	str_space db     "                                 ", 0
	
	x dq 7256374986534530897
	
	
section .text
	global _start

_start:
	printstr str_dash
	printstr str_data_dec
	printint [x]
	printstr new_line
	
	printstr str_data_hex
	printhex [x]
	printstr new_line
	printstr new_line
	
	printstr str1
	printstr str_dash
	printstr str_caption
	printstr str_dash
	
	mov r9, 8
	mov rdi, x
	label:
		printint rdi ; print the address
		printstr str_space

		mov rbx, 0
		mov bl, [rdi]

		printhex rbx ; print the contents of the address (one byte) in hex
		printstr new_line

		inc rdi ; increment once to point to the next byte
		dec r9
		jnz label

	printstr new_line
	printstr new_line
	printstr str2
	printstr str_dash
	printstr str_caption
	printstr str_dash

	mov r9, 4
	mov rdi, x
	label1:
		printint rdi ; print the address
		printstr str_space

		mov rbx, 0
		mov bx, [rdi]

		printhex rbx ; print the contents of the address (one word) in hex
		printstr new_line

		inc rdi
		inc rdi ; increment twice to point to the next word
		dec r9
		jnz label1

	printstr new_line
	printstr new_line
	printstr str3
	printstr str_dash
	printstr str_caption
	printstr str_dash

	mov r9, 2
	mov rdi, x
	label2:
		printint rdi ; print the address
		printstr str_space

		mov rbx, 0
		mov ebx, [rdi]

		printhex rbx ; print the contents of the address (one word) in hex
		printstr new_line

		inc rdi
		inc rdi
		inc rdi
		inc rdi ; increment four times to point to the next double-word
		dec r9
		jnz label2

	exit

