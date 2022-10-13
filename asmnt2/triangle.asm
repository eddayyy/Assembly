;****************************************************************************************************************************
;Program name: "Pythorans Theorem Program".  This program receives the input of 2 float numbers and then creates a formula  *
; using Pythagoran's theorem to calculate the hypotenuse.                                                                   *
;                                                                                                                           *
;This file is part of the software program "Pythagoran's Theorem Program".                                                  *
;Drive and Compare Floats Program is free software: you can redistribute it and/or modify                                   *
;****************************************************************************************************************************
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Eduardo M. Nunez Gomez
;  Author email: eduardonunez@csu.fullerton.edu
;
;Program information
;  Program name: Pythorans Theorem Program
;  Programming languages: Driver modules in C and controller module in X86-64 Assembly using the NASM Compiler
;  Date program began: 2022-Sep-8 0800 PDT GMT-07:00
;  Date of last update: 2022-Sep-17 1800 PDT GMT-07:00
;  Date comments upgraded: 2022-Sep-017
;  Files in this program: pythagoras.c, triangle.asm, r.sh, gdb.sh
;  Status: Finished.
;  References consulted: Johnson Trong SI leader, x86-64 Assembly Language Programming With Ubuntu by Ed Jorgensen (Chapters 1-8 & 14-25),
;  Holliday Floyd During Section-01 Lab Hours, and the nasm.us/doc for information on the NASM Assembler, GDB Cheat Sheet
;
;Purpose
;  This program demonstrates how to receive, return, store, and calculate floats using Pythagoran's Theorem. It also respectfully asks for the user's name and title then returns it to them.
;  The intention is to teach readers the ins and outs of the program so they may recreate their  own.
;
;This file
;  File name: triangle.asm
;  Language: X86 using NASM Assembler and Syntax
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Compiling and Linking this program and file:
;File: r.sh
;All assembling, compiling, and linking has been condensed for the user into a single file the following is a user-tutorial.
;
;Instructions: Enter the following in your linux terminal
;
;chmod +x r.sh 
;./r.sh 
;
;GDB Compiler:
;
;chmod +x gdb.sh
;./gdb.sh
;
;More information regarding this file can be found in the header of r.sh.  
;
;===== Begin code area ========================================================================================================


extern printf

extern scanf

extern fgets

extern stdin

extern strlen

extern sqrtf

INPUT_LEN equ 256
LARGE_BOUNDARY equ 64
SMALL_BOUNDARY equ 16

global triangle

section .data
;   ************************* Aligning Data On A 16-Byte Boundary *************************
align SMALL_BOUNDARY

;   ************************* Messages To Be Printed *************************
    name_prompt db 10, "Please enter your last name: ", 0
    title_prompt db 10, "Please enter your title (Mr, Ms, Nurse, Engineer, etc): ", 0
    t_sides_prompt db 10, "Please enter the sides of your triangle separated by a ws: ", 0

;   ************************* Good-Bye Messages *************************
    hypotenuse_out db 10,"The length of the hypotenuse is %.8lf units", 10,10,0 
    bye_out db "Please enjoy your triangles ", 0

;   ************************* Special Use Characters (Inputs, Spaces, Outputs, etc.) *************************
    format: db "%s", 0 ; will format a null terminated string, c-string
    spc: db " ", 0
    two_float db "%lf %lf", 0
    ; name db "%s", 0
    ; title db "%s", 0

section .bss 
    title: resb INPUT_LEN
    name: resb INPUT_LEN


section .text 
triangle:
;   ************************* Backing up all 64 bit registers *************************
push       rbp                                              ;Save a copy of the stack base pointer
mov        rbp, rsp                                         ;We do this in order to be 100% compatible with C and C++.
push       rbx                                              ;Back up rbx
push       rcx                                              ;Back up rcx
push       rdx                                              ;Back up rdx
push       rsi                                              ;Back up rsi
push       rdi                                              ;Back up rdi
push       r8                                               ;Back up r8
push       r9                                               ;Back up r9
push       r10                                              ;Back up r10
push       r11                                              ;Back up r11
push       r12                                              ;Back up r12
push       r13                                              ;Back up r13
push       r14                                              ;Back up r14
push       r15                                              ;Back up r15
pushf                                                       ;Back up rflags


;************************* Prompt user for their name input *************************
mov rax, 0 
mov rdi, format
mov rsi, name_prompt
call printf 

;************************* Collect User Name Input *************************
mov rax, 0 
mov rdi, name
mov rsi, INPUT_LEN
mov rdx, [stdin]
call fgets

mov rax, 0
mov rdi, name
call strlen

sub rax, 1
mov byte [name + rax], 0 
; mov rax, 0 
; mov rdi, string_format
; push qword 0
; mov rsi, rsp
; call scanf
; mov r15, [rsp]
; pop rax

;************************* Promp For Title *************************
mov rax, 0
mov rdi, title_prompt
call printf 

;************************* Collect User Title Input *************************
mov rax, 0 
mov rdi, title
mov rsi, INPUT_LEN
mov rdx, [stdin]
call fgets
push qword 0 


mov rax, 0 
mov rdi, title 
call strlen
sub rax, 1
mov byte [title + rax], 0
; mov rax, 0 
; mov rdi, string_format
; push qword 0 
; mov rsi, rsp
; call scanf
; mov r14, [rsp]
; pop rax

; ************************* Prompt User Float Input ************************* 
mov rax, 0
mov rdi, t_sides_prompt
call printf 
pop rax

; ************************* Collect User Float Input ************************* 
mov rax, 0
mov rdi, two_float
mov rsi, rsp
mov rdx, rsp
call scanf 
movsd xmm10, [rsp]
movsd xmm11, [rsp]
mulsd xmm10, xmm10
mulsd xmm11, xmm11
addsd xmm10, xmm11
sqrtsd xmm14, xmm10

;************************* Print User Float Input ************************* 
mov rax, 1 
mov rdi, hypotenuse_out
movsd xmm0, xmm14
call printf 
pop rax
;************************* Print Bye Message ************************* 
mov rax, 0
mov rdi, bye_out
call printf
push qword 0

;************************* Print User Title ************************* 
mov rax, 0
mov rdi, format
mov rsi, title
call printf
;   ************************* Print a space *************************
mov rax, 0 
mov rdi, format
mov rsi, spc
call printf


;************************* Print User Name ************************* 
mov rax, 0
mov rdi, format
mov rsi, name
call printf 

end:
movsd xmm0, xmm14


;Restore the original values to the GPRs
popf                                                        ;Restore rflags
pop        r15                                              ;Restore r15
pop        r14                                              ;Restore r14
pop        r13                                              ;Restore r13
pop        r12                                              ;Restore r12
pop        r11                                              ;Restore r11
pop        r10                                              ;Restore r10
pop        r9                                               ;Restore r9
pop        r8                                               ;Restore r8
pop        rdi                                              ;Restore rdi
pop        rsi                                              ;Restore rsi
pop        rdx                                              ;Restore rdx
pop        rcx                                              ;Restore rcx
pop        rbx                                              ;Restore rbx
pop        rbp                                              ;Restore rbp

ret                                                         ;No parameter with this instruction.  This instruction will pop 8 bytes from
