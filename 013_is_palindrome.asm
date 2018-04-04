section .data
	str1 db "abcddcba", 0
	str2 db " is palindrome.", 10, 0
	str3 db " is not palindrome.", 10, 0

section .text
	global _start

_start:
	
	; printing the string
	mov rax, 1
	mov rdx, 1
	mov rdi, 1
	mov rsi, str1
	mov rdx, 8;  lenght of the string
	syscall
	
	mov rax, str1

	call fnc_is_palindrome
	cmp rax, 1
	jne label1
	
	; the string is palindrome
	mov rax, 1
	mov rdi, 1
	mov rsi, str2
	mov rdx, 16 ;  lenght of " is palindrome.", 10
	jmp label2

label1:
	; the string is palindrome
	mov rax, 1
	mov rdi, 1
	mov rsi, str3
	mov rdx, 20 ;  lenght of " is not palindrome.", 10

label2:
	syscall

	mov rax, 60
	mov rdi, 0
	syscall

;**************************************************************************************************
; input: rax (pointer to a nonempty string)
; output: rax
; function: 
;		rax = 1,  if the string is palindrome
;		rax = 0,  otherwise
;**************************************************************************************************
fnc_is_palindrome:
	push rbx
	push rdx
	push rcx

	mov rbx, rax
	mov rdx, rax

	; rdx will point to the last character of the string
	fnc_is_palindrome_loop:
		inc rdx
		mov cl, [rdx]
		cmp cl, 0
		jne fnc_is_palindrome_loop
	dec rdx ; now rdx point to the last character of the string

	fnc_is_palindrome_loop1:
		mov al, [rbx]
		mov cl, [rdx]
		sub al, cl
		cmp al, 0
		jne fnc_is_palindrome_loop2 ; two mirror characters are not equal (the string is not a palindrome)
		inc rbx
		dec rdx
		mov rax, rdx
		sub rax, rbx
		cmp rax, 0
		jg fnc_is_palindrome_loop1

		mov rax, 1 ; the string is palindrome

		pop rcx
		pop rdx
		pop rbx

		ret
		
	
	fnc_is_palindrome_loop2:
		mov rax, 0 ; the string is not palindrome

		pop rcx
		pop rdx
		pop rbx

		ret

