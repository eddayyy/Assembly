nasm -f elf64 -o main.o -l main.lis main.asm
ld  -o code.out main.o
./code.out