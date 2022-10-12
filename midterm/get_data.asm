;  Author: Eduardo Nunez
;  Author email: eduardonunez@csu.fullerton.edu
;  Today's date: October 12, 2022
;  Section ID: Section 01 M/W 12pm - 2pm

extern printf
extern scanf 
extern isFloat

global get_data

section .data   
    floatformat db "%lf", 0


section .bss ; reserved for data that hasn't been initialized


section .text
get_data:
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

push qword 0 

mov r15, rdi ; array / array ptr
mov r14, rsi ; array size

mov r13, 0 ; starting the indexer at 0 
loop_start:
    cmp r14, r13
    je loop_end
    mov rax, 0 
    mov rdi, floatformat
    push qword 0
    mov rsi, rsp
    call scanf 
    cdqe
    cmp rax, -1
    pop r12 
    je loop_end
    mov rax, 0 
    mov rdi, r12
    mov [r15 + 8*r13], r12
    inc r13
    jmp loop_start
loop_end:

pop rax
mov rax, r13






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

ret                                                        