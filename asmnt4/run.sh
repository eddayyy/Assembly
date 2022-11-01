#****************************************************************************************************************************
#Program name: "Pure Assembly in 2022 Program".  This program demonstrates the input of a float number, the output of time, *
#radians, and the cosine of the inputted float                                                                              *
#                                                                                                                           *
#This file is part of the software program "Pure Assembly in 2022 Program".                                                 *
#Pure Assembly in 2022 Program is free software: you can redistribute it and/or modify                                      *
#****************************************************************************************************************************
#========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
#
#Author information
#  Author name: Eduardo M. Nunez Gomez
#  Author email: eduardonunez@csu.fullerton.edu
#
#Program information
#  Program name: Pure Assembly In 2022 Program
#  Programming languages: All modules in X86-64 Assembly using the NASM Compiler with Intel Syntax, 1 Shell file to compile & link.
#  Date program began: 2022-Oct-24 0800 PDT GMT-07:00
#  Date of last update: 2022-Oct-31 1800 PDT GMT-07:00
#  Date comments upgraded: 2022-Oct-31 
#  Files in this program: _start.asm , cosine.asm , ftoa.asm , input.asm , io.asm , itoa.asm , stringtof.asm , r.sh
#  Status: Finished.
#  References consulted: Johnson Trong SI leader, x86-64 Assembly Language Programming With Ubuntu by Ed Jorgensen (Chapters 1-8 & 14-25),
#  Holliday Floyd During Section-01 Lab Hours, and the nasm.us/doc for information on the NASM Assembler
#
#Purpose
#  This program demonstrates how to receive, return, store, and floats, tics, and radians.
#  The intention is to teach readers the ins and outs of pure assembly so that they may recreate their own software.
#
#This file
#  File name: run.sh
#  Language: Shell / Bash
#========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
#Compiling and Linking this program and file:
#File: run.sh
#All assembling, compiling, and linking has been condensed for the user into a single file the following is a user-tutorial.
#
#Instructions: Enter the following in your linux terminal
#
#chmod +x run.sh 
#./run.sh 
#  
#
#===== Begin code area ========================================================================================================

#! /usr/bin/bash
set -e
rm -r -f *.o *.lis *.out

glob() {
    # https://stackoverflow.com/a/15515152/5041327
    [ -e "$1" ] && echo "$@"
}

filter() {
    for f in "${@:3}"; do
        [ "$f" $1 "$2" ] && echo "$f"
    done
}

globcode() {
    filter != '_*' $(glob "$@")
}

CFLAGS="-g -m64 -Wall -Wextra -Wpedantic -fsanitize=address -fstack-protector -fno-pie -no-pie"
CXXFLAGS="$CFLAGS -std=c++17"

hasC=
out="$(basename "$PWD").out"

for f in $(globcode *.asm); do
    nasm -f elf64 -o "$f.o" "$f"
done

for f in $(globcode *.cpp); do
    hasC=1
    g++ -c $CXXFLAGS -o "$f.o" "$f"
done

for f in $(globcode *.c); do
    hasC=1
    gcc -c $CFLAGS -o "$f.o" "$f"    
done

[ -n "$hasC" ] \
    && gcc $CXXFLAGS -o $out *.o \
    || ld -o $out *.o

rm -r -f  *.o *.lis