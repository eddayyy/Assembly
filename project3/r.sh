
rm *.o
rm *.out

echo "Assemble the X86 file manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble the X86 file input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble the X86 file sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo "Compile the C++ file display.cpp"
g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o display.o display.cpp

echo "Compile the C file main.c"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=gnu11 -lm

echo "Link the three files display.o driver2.o compute_time.o"
g++ -m64 -std=c++17 -fno-pie -no-pie -o output.out display.o manager.o input_array.o main.o sum.o

#gcc -m64 -no-pie -std=11 -o output.out display.o assessor.o manager.o input_array.o main.o

echo "Next the program ""String I/O"" will run"
./output.out

rm *.lis
rm *.o
rm *.out