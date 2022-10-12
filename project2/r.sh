# ****************************************************************************************************************************
# Program name: "Pythorans Theorem Program".  This program receives the input of 2 float numbers and then creates a formula  *
#  using Pythagoran's theorem to calculate the hypotenuse.                                                                   *
#                                                                                                                            *
# This file is part of the software program "Pythagoran's Theorem Program".                                                  *
# Drive and Compare Floats Program is free software: you can redistribute it and/or modify                                   *
# ****************************************************************************************************************************
# ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

# Author information
#   Author name: Eduardo M. Nunez Gomez
#   Author email: eduardonunez@csu.fullerton.edu

# Program information
#   Program name: Pythorans Theorem Program
#   Programming languages: Driver modules in C and controller module in X86-64 Assembly using the NASM Compiler
#   Date program began: 2022-Sep-8 0800 PDT GMT-07:00
#   Date of last update: 2022-Sep-17 1800 PDT GMT-07:00
#   Date comments upgraded: 2022-Sep-017
#   Files in this program: pythagoras.c, triangle.asm, r.sh, gdb.sh
#   Status: Finished.
#   References consulted: Johnson Trong SI leader, x86-64 Assembly Language Programming With Ubuntu by Ed Jorgensen (Chapters 1-8 & 14-25),
#   Holliday Floyd During Section-01 Lab Hours, and the nasm.us/doc for information on the NASM Assembler, GDB Cheat Sheet

# Purpose
#   This program demonstrates how to receive, return, store, and calculate floats using Pythagoran's Theorem. It also respectfully asks for the user's name and title then returns it to them.
#   The intention is to teach readers the ins and outs of the program so they may recreate their  own.

# This file
#   File name: r.sh
#   Language: Bash
# ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
# Compiling and Linking this program and file:
# File: r.sh
# All assembling, compiling, and linking has been condensed for the user into a single file the following is a user-tutorial.

# Instructions: Enter the following in your linux terminal

# chmod +x r.sh 
# ./r.sh 

# GDB Compiler:

# chmod +x gdb.sh
# ./gdb.sh

# More information regarding this file can be found in the header of r.sh.  

# ===== Begin code area ========================================================================================================



#!/usr/bin/env bash
set -e
rm -f -- *.o *.lis *.out

glob() {
    # https://stackoverflow.com/a/15515152/5041327
    [ -e "$1" ] && echo "$@"
}

CFLAGS+="-g -m64 -fsanitize=address -fstack-protector -fno-pie -no-pie "
CXXFLAGS+="$CFLAGS "
CXXFLAGS+="-std=c++17 "

for f in $(glob *.asm); do
    nasm -f elf64 -o "$f.o" "$f" -gdwarf
done

for f in $(glob *.cpp); do
    g++ -c -Wall $CXXFLAGS -o "$f.o" "$f" -g
done

for f in $(glob *.c); do
    gcc -c -Wall $CFLAGS -o "$f.o" "$f" -g 
done

g++ $CXXFLAGS -o "$(basename "$PWD").out" ./*.o