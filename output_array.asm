;******************************************************************************************************************
;Program name: "Array Management".  This program demonstrates how to pass an array to a called subprogram.        *
;Copyright (C) 2020 Floyd Holliday                                                                                *
;                                                                                                                 *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public*
;License version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it *
;will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A  *
;PARTICULAR PURPOSE.  See the GNU General Public License for more details.  A copy of the GNU General Public      *
;License v3 is available here:  <https://www.gnu.org/licenses/>.                                                  *
;******************************************************************************************************************

;The blank line separates the notice of copyright (rights reserved to the author) from the notice of license 
;(rights reserved to the people).  The actual license itself never appears in source code but is type found in an
;accompanying text file.

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2
;
;Author information
;  Author name: Floyd Holliday
;  Author email: holliday@fullerton.edu
;
;Program information
;  Program name: Array Management
;  Programming languages: Two modules in C, two modules in X86
;  Date program began:     2022-Mar-04
;  Date program completed: 2022-Mar-06
;  Date comments upgraded: 2022-Mar-06
;  Files in this program: director.c, supervisor.asm, output_array.asm, input_array.c, director.c 
;  Status: Complete.  Alpha testing is finished.  Extreme cases were tested and errors resolved.
;
;References for this program
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
;
;Purpose (academic)
;  Show how to pass an array from a caller function to a called function.
;
;This file
;   File name: output_array.asm
;   Language: i-series microprocessor assembly
;   Syntax: Intel
;   Max page width: 116 columns
;   Assemble: nasm -f elf64 -o super.o supervisor.asm -l super.lis
;   Link: gcc -m64 -no-pie -o arr.out -std=c17 director.o super.o input.o output.o 
;   Reference regarding -no-pie: Jorgensen, page 226.
;   Prototype of this function:  long showlumber(double * trees, long count);
;
;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2
;
;
;
;
;===== Begin code area ================================================================================================

;Declarations are collected together in this area
null equ 0
newline equ 10

extern printf
global showlumber


segment .data

header db "Cell#   Address (aligned)      Data decimal     Data hex (IEEE)",newline,null
dataline db "%3ld   0x%016lx   %16.8lf   0x%016lx",newline,null

segment .bss
;This segment is empty.

segment .text
showlumber:

;Back up the general purpose registers for the sole purpose of protecting the data of the caller.
push rbp                                          ;Backup rbp
mov  rbp,rsp                                      ;The base pointer now points to top of stack
push rdi                                          ;Backup rdi
push rsi                                          ;Backup rsi
push rdx                                          ;Backup rdx
push rcx                                          ;Backup rcx
push r8                                           ;Backup r8
push r9                                           ;Backup r9
push r10                                          ;Backup r10
push r11                                          ;Backup r11
push r12                                          ;Backup r12
push r13                                          ;Backup r13
push r14                                          ;Backup r14
push r15                                          ;Backup r15
push rbx                                          ;Backup rbx
pushf                                             ;Backup rflags

;Registers rax, rip, and rsp are usually not backed up.

;Back up the incoming parameter
mov r13, rdi  ;r13 is the array
mov r14, rsi  ;r14 is the count of valid numbers in the array

;Block that displays the header
mov rax, 0
mov rdi, header
call printf

;Block to create a loop
xor r15,r15   ;r15 is the loop counter
begin_loop:
cmp r15,r14
jge done
mov rax,1
mov rdi,dataline       ;First parameter
mov rsi,r15            ;Second paramter
mov r12,r15
shl r12,3              ;<==Fast multiplication by 8
add r12,r13
mov rdx,r12            ;Third parameter
movsd xmm0,[r13+8*r15] ;Fourth parameter
mov rcx,[r13+8*r15]    ;Fifth parameter
call printf
inc r15
jmp begin_loop
done:

;return 0 which is the traditional signal of success
xor rax,rax

;Restore all the previously pushed registers.
popf                                    ;Restore rflags
pop rbx                                 ;Restore rbx
pop r15                                 ;Restore r15
pop r14                                 ;Restore r14
pop r13                                 ;Restore r13
pop r12                                 ;Restore r12
pop r11                                 ;Restore r11
pop r10                                 ;Restore r10
pop r9                                  ;Restore r9
pop r8                                  ;Restore r8
pop rcx                                 ;Restore rcx
pop rdx                                 ;Restore rdx
pop rsi                                 ;Restore rsi
pop rdi                                 ;Restore rdi
pop rbp                                 ;Restore rbp

ret                                     ;Pop the integer stack and jump to the address equal to the popped value.
