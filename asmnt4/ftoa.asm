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
;  File name: ftoa.asm
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

global ftoa

extern itoa

section .text

ftoa:

        xor     eax, eax
        test    rsi, rsi
        je      .019
        push    rbp
        mov     rbp, rsp
        push    r15
        mov     r15, rdi
        push    r14
        push    r13
        mov     r13, rsi
        push    r12
        push    rbx
        sub     rsp, 40
        ucomisd xmm0, xmm0
        jpo     .001
        cmp     rsi, 3
        jle     .018
        mov     dword [rdi], 5136718
        mov     eax, 3
        jmp     .018

.001:
        xorps  xmm1, xmm1
        comisd xmm1, xmm0
        jbe    .004
        cmp    rsi, 1
        jg     .003
.002:
        mov byte [r15], 0
        jmp .007

.003:
        mov   byte [rdi], 45
        xorps xmm0, oword [rel .LC1]
        mov   ebx, 1
        jmp   .005

.004:
        xor ebx, ebx
.005:
        cvttsd2si r12, xmm0
        lea       rsi, [r15+rbx]
        mov       rdx, r13
        movsd     qword [rbp-48H], xmm0
        mov       rdi, r12
        call      itoa
        test      rax, rax
        jz        .002
        cvtsi2sd  xmm1, r12
        movsd     xmm0, qword [rbp-48H]
        add       rax, rbx
        subsd     xmm0, xmm1
        xorps     xmm1, xmm1
        comisd    xmm0, xmm1
        jbe       .018
        lea       rdx, [rax+2H]
        mov       r12, rsp
        cmp       rdx, r13
        jle       .008
.006:
        mov byte [r15], 0
        mov rsp, r12
.007:
        xor eax, eax
        jmp .018

.008:
        mulsd     xmm0, [rel .LC2]
        mov       byte [r15+rax], 46
        lea       r13, [rbp-37H]
        mov       edx, 7
        mov       rsi, r13
        lea       rbx, [rax+1H]
        cvttsd2si r14, xmm0
        mov       rdi, r14
        call      itoa
        mov       rdx, rax
        test      rax, rax
        jz        .006
        xor       ecx, ecx
        test      r14, r14
        jle       .014
.009:
        cmp  r14, 99999
        jg   .010
        imul r14, r14, 10
        inc  rcx
        jmp  .009

.010:
        dec rdx
        lea rax, [r13+rcx]
.011:
        test rdx, rdx
        js   .012
        mov  sil, byte [r13+rdx]
        mov  byte [rax+rdx], sil
        dec  rdx
        jmp  .011

.012:
        xor   eax, eax
        test  rcx, rcx
        mov   rdi, r13
        mov   edx, 6
        cmovs rcx, rax
        mov   al, 48
        rep   stosb
        jmp   .014

.013:
        cmp byte [r13+rdx-1H], 48
        lea rax, [rdx-1H]
        jnz .015
        mov rdx, rax
.014:
        cmp rdx, 1
        jg  .013
.015:
        mov rax, rbx
.016:
        mov    ecx, eax
        mov    rsi, r15
        sub    ecx, ebx
        add    rsi, rax
        movsxd rcx, ecx
        cmp    rcx, rdx
        jge    .017
        mov    cl, byte [rbp+rcx-37H]
        mov    byte [r15+rax], cl
        inc    rax
        jmp    .016

.017:
        mov byte [rsi], 0
        mov rsp, r12
.018:
        lea rsp, [rbp-28H]
        pop rbx
        pop r12
        pop r13
        pop r14
        pop r15
        pop rbp
        ret 

.019:

        ret 

section .data

section .bss

section .rodata

        ALIGN 16
.LC1:

 dd 00000000H, 80000000H
 dd 00000000H, 00000000H

section .rodata

.LC2:
 dq 412E848000000000H

section .note

 db 04H, 00H, 00H, 00H, 20H, 00H, 00H, 00H
 db 05H, 00H, 00H, 00H, 47H, 4EH, 55H, 00H
 db 02H, 00H, 01H, 0C0H, 04H, 00H, 00H, 00H
 db 01H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
 db 01H, 00H, 01H, 0C0H, 04H, 00H, 00H, 00H
 db 09H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
