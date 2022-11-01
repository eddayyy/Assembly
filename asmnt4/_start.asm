;****************************************************************************************************************************
;Program name: "Pure Assembly in 2022 Program".  This program demonstrates the input of a float number, the output of time, *
;radians, and the cosine of the inputted float                                                                              *
;                                                                                                                           *
;This file is part of the software program "Pure Assembly in 2022 Program".                                                 *
;Pure Assembly in 2022 Program is free software: you can redistribute it and/or modify                                      *
;****************************************************************************************************************************
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Eduardo M. Nunez Gomez
;  Author email: eduardonunez@csu.fullerton.edu
;
;Program information
;  Program name: Pure Assembly In 2022 Program
;  Programming languages: All modules in X86-64 Assembly using the NASM Compiler with Intel Syntax, 1 Shell file to compile & link.
;  Date program began: 2022-Oct-24 0800 PDT GMT-07:00
;  Date of last update: 2022-Oct-31 1800 PDT GMT-07:00
;  Date comments upgraded: 2022-Oct-31 
;  Files in this program: _start.asm , cosine.asm , ftoa.asm , input.asm , io.asm , itoa.asm , stringtof.asm , r.sh
;  Status: Finished.
;  References consulted: Johnson Trong SI leader, x86-64 Assembly Language Programming With Ubuntu by Ed Jorgensen (Chapters 1-8 & 14-25),
;  Holliday Floyd During Section-01 Lab Hours, and the nasm.us/doc for information on the NASM Assembler
;
;Purpose
;  This program demonstrates how to receive, return, store, and floats, tics, and radians.
;  The intention is to teach readers the ins and outs of pure assembly so that they may recreate their own software.
;
;This file
;  File name: _start.asm
;  Language: X86 using NASM Assembler and Intel syntax
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Compiling and Linking this program and file:
;File: run.sh
;All assembling, compiling, and linking has been condensed for the user into a single file the following is a user-tutorial.
;
;Instructions: Enter the following in your linux terminal
;
;chmod +x run.sh 
;./run.sh 
;  
;
;===== Begin code area ========================================================================================================


extern input, showstring, strlen, input, stringtof, ftoa, itoa, cosine

global _start
section .data
    
    newline db 0xa, 0xa, 0xa, 0xa, 0xa, 0xa, 0xa, 0xa, 0        ;Declare an array of 8 bytes where each byte is initialize with ascii value 10 (newline)                                   
    tab db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0    ;Declare an array of 8 bytes where each byte is initialize with 32 (blank space).  Thus, this array equals 
                                                                ;one standard tab.
    radians db "The equivalent radians is ", 0
    cosine_prompt db "The cosine of those degrees is ", 0
    welcomePhrase db "Welcome to the Accurate Cosines by Eduardo Nunez", 10, 0 
    timePhrase db "The time is now ", 0
    timePhrase2 db " tics", 10, 0
    enteredPhrase db "You entered ", 0
    equivalentPhrase db "The equivalent radians is ", 0
    cosinePhrase db "The cosine of those degrees is ", 0
    secondsPhrase db "The time is now ", 0 
    secondsPhrase2 db " seconds", 0
    byePhrase db "Have a nice day, bye.", 10, 0

section .bss
    stdout equ 1
    stdin equ 0
    sys_write equ 1 
    sys_read equ 0
    tic resb 50
    tic2 resb 50
    float_in_string resb 30
    cos_string resb 30

section .text
_start:
;========================= Backing up all 64 bit registers =========================
push rbp
mov  rbp,rsp
push rdi                                                    
push rsi                                                    
push rdx                                                   
push rcx                                                    
push r8                                                     
push r9                                                     
push r10                                                    
push r11                                                  
push r12                                                   
push r13                                                   
push r14                                                   
push r15                                                    
push rbx                                                    
pushf   

;======================== Printing out the welcome prompt ========================
mov rdi, welcomePhrase
mov rsi, 0
call showstring

;======================== Time Module Part 1 ========================
mov rax, 0 
mov rdi, timePhrase
mov rsi, 0
call showstring

;get time
cpuid
rdtsc
shl rdx, 32
or rdx, rax
mov r14, rdx

;call itoa
mov rax, 0
mov rdi, r14
mov rsi, tic
call itoa
mov r13, tic

;get strlen of the time
mov rax, 0
mov rdi, r13
call strlen
mov r15, rax

;output the time
mov rax, sys_write
mov rdi, stdout
mov rsi, r13
mov rdx, r15
syscall

mov rax, 0
mov rdi, timePhrase2
mov rsi, 0
call showstring

;======================== Receive the input ========================
call input
mov r12, rax ; string
mov r13, rdi ; string length

;======================== Convert the input into a float ========================
mov rax, 0
mov rdi, r12
call stringtof
movsd xmm8, xmm0

;======================== Radians Output Section ========================
mov rax, 0
mov rdi, radians
mov rsi, 0
call showstring

;======================== Convert the Input into Radians ========================
mov rbx, 180
cvtsi2sd xmm10, rbx
mov rax, 0x400921FB54442D18
push rax
movsd xmm9, [rsp]
pop rax
mulsd xmm8, xmm9
divsd xmm8, xmm10

; ftoa will get us the radian value
mov rax, 1
movsd xmm0, xmm8
mov rdi, float_in_string
mov rsi, 30
call ftoa
mov r12, rax

;======================== Radians Output Section ========================
mov rax, sys_write
mov rdi, stdout
mov rsi, float_in_string
mov rdx, r12
syscall

;output newline
mov rax, sys_write
mov rdi, stdout
mov rsi, newline
mov rdx, 1
syscall

;======================== Cosine Of The Radians ========================
;call cosine
mov rax, 1
movsd xmm0, xmm8
call cosine
movsd xmm9, xmm0

;get strlen of cosine_prompt
mov rax, 0
mov rdi, cosine_prompt
call strlen
mov r15, rax

;output cosine_prompt
mov rax, sys_write
mov rdi, stdout
mov rsi, cosine_prompt
mov rdx, r15
syscall


mov rax, 1
movsd xmm0, xmm9
mov rdi, cos_string
mov rsi, 30
call ftoa
mov r12, rax

;output float_string
mov rax, sys_write
mov rdi, stdout
mov rsi, cos_string
mov rdx, r12
syscall

;output newline
mov rax, sys_write
mov rdi, stdout
mov rsi, newline
mov rdx, 1
syscall

;======================== Time Module Part 2 ========================
mov rax, 0 
mov rdi, timePhrase
mov rsi, 0
call showstring

;get time
cpuid
rdtsc
shl rdx, 32
or rdx, rax
mov r14, rdx

;call itoa
mov rax, 0
mov rdi, r14
mov rsi, tic2
call itoa
mov r13, tic2

;output the time
mov rax, sys_write
mov rdi, stdout
mov rsi, r13
mov rdx, r15
syscall

mov rax, 0
mov rdi, timePhrase2
mov rsi, 0
call showstring

;======================== Ending this program ========================
mov rax, 0
mov rdi, byePhrase
mov rsi, 0
call showstring

;======================== Ending this program ========================
mov rax, 60 ; exit
mov rdi, 0 ; success
syscall


;========================= Restoring all 64 bit registers for stability and peace among the stack =========================
popf                                                        
pop rbx                                                    
pop r15                                                    
pop r14                                                    
pop r13                                                   
pop r12                                                     
pop r11                                                   
pop r10                                                     
pop r9                                                     
pop r8                                                     
pop rcx                                                     
pop rdx                                                   
pop rsi                                                    
pop rdi                                                     
pop rbp                                                     

ret 