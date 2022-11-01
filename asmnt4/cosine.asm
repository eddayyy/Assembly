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
;  File name: cosine.asm
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

global cosine

extern strlen

sys_write equ 1
sys_read equ 0
stdout equ 1
stdin equ 0

segment .data
hello db "Hello world", 10, 0

segment .bss

segment .text

cosine:

push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

; double cosine(double)
; save the user input into a less volatile register ( this is X in the summation )
movsd xmm15, xmm0






; The relation between every term k, k+1 is:
; -1 * x^2
;-------------
;(2k+2)(2k+1)
; Start the term from 1.0 and multiply the recurrance relation against it until terminal

; Remember k is what iteration we are on
; x is the user inputted number

; Current (first) term of maclaurin series is 1.0 ( plug in k = 0 )
mov rax, 1
cvtsi2sd xmm14, rax
; we'll need the numbers 2.0, -1.0, and 1.0 to multiply floats
; (from 2k+1 and 2k+2)
mov rax, 1
cvtsi2sd xmm13, rax
mov rax, 2
cvtsi2sd xmm12, rax
mov rax, -1
cvtsi2sd xmm5, rax
; start k at 0, since we already have the first term of the sequence
mov r15, 0
cvtsi2sd xmm11, r15
; stop at 10,000,000
mov r14, 10000000
; Total sum so far
xorpd xmm10, xmm10
beginloop:
; Check if r15 (k) has hit r14 (10000000)
cmp r15, r14
je end
; Otherwise, add the current term of the sequence
addsd xmm10, xmm14
; Then, compute the next term of the sequence (place into xmm14)
; 2k+1 - xmm12 * xmm11 + xmm13
; creating temporary register for calculations xmm9
movsd xmm9, xmm12
mulsd xmm9, xmm11
addsd xmm9, xmm13

; 2k+2 - xmm12 * xmm11 + xmm12
; creating temporary register for calculations xmm8
movsd xmm8, xmm12
mulsd xmm8, xmm11
addsd xmm8, xmm12

; (2k+1) * (2k+2) - xmm8 * xmm9
mulsd xmm8, xmm9

; X^2 - user input at xmm15
; creating temporary register for calculations xmm7
movsd xmm7, xmm15
mulsd xmm7, xmm7

; X^2
; ----
; (2k+1) (2k+2) - result will be in xmm7
divsd xmm7, xmm8
; multiply -1 against this relation
mulsd xmm7, xmm5
; multiply the recurrance relation against the current term and set the current term to result
mulsd xmm14, xmm7
inc r15
cvtsi2sd xmm11, r15
jmp beginloop

end:
movsd xmm0, xmm10


popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret