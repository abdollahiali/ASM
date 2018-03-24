# ASM
This repository includes some practices for x86_64 assembly

You need to have NASM installed on your machine (refer to www.nasm.us)


Commands that are needed to assembling:

	nasm -f elf64 <file_name>.asm -o <file_name>.o

	ld <file_name>.o -o hello
