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
;   File name: supervisor.asm
;   Language: i-series microprocessor assembly
;   Syntax: Intel
;   Max page width: 116 columns
;   Assemble: nasm -f elf64 -o super.o supervisor.asm -l super.lis
;   Link: gcc -m64 -no-pie -o arr.out -std=c17 director.o super.o input.o output.o 
;   Reference regarding -no-pie: Jorgensen, page 226.
;   Prototype of this function:  double manage_arrays();
;
;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2
;
;
;
;
;===== Begin code area ================================================================================================



;Declarations
newline equ 10
null equ 0
number_of_cells equ 5          ;<==To next open source developer: you may wish to change the size of the array

extern printf
extern input_array
extern showlumber

global manage_arrays


segment .data
welcome db "Welcome to Manage Arrays",newline,null
info db "The program will show how an array declared in manage_arrays can be passed to two different called functions",newline,null
array_address db "The address of the array plywood is %016lx",newline,null


segment .bss
align 16
plywood resq number_of_cells


segment .text
manage_arrays:

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

;Block that displays the welcome message
mov rax, 0
mov rdi,welcome
call printf

;Block that displays the informational details
mov rax, 0
mov rdi,info
call printf

;A block that will call function "input_array" and pass an array to that function.
mov rax,0
mov rdi,plywood
mov rsi,number_of_cells
call input_array
mov r13,rax     ;r13 holds the number of values stored in the array plywood.

;Teaching moment.  Notice that I do not create a pointer to a cell in order to store this integer.
;My scalar variables are registers, both general registers and xmm registers.  This is the culture
;of assembly programming.  Save data in registers until such time that all registers are in use.
;At that time you must push some data in order to re-use the registers occupied by those data.

;Set up the necessary parameter to show the address of the array.
mov rax, 0
mov rdi, array_address
mov rsi, plywood
call printf

;A block of statements that will setup a call to the function that displays all values in an array.
mov rax,0
mov rdi,plywood
mov rsi,r13
call showlumber

;Prepare to return execution to the caller.
xorpd xmm0,xmm0                         ;Return 0.0 to the caller

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

