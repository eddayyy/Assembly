#!/usr/bin/env bash
set -e
rm -f -- *.o *.lis *.out

for f in *.asm; do
    nasm -f elf64 -o "$f.o" "$f"
done
for f in *.cpp; do
    g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o "$f.o" "$f"
done

g++ -m64 -std=c++14 -fno-pie -no-pie -o "$(basename "$PWD").out" ./*.o