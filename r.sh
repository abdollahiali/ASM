clear
# nasm -f elf64 $1.asm -o $1.o
# previously I used the above one
# to create the list file we can use the following command
nasm -f elf64 $1.asm -l $1.lst

ld $1.o -o $1

./$1
