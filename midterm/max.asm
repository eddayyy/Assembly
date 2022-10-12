;  Author: Eduardo Nunez
;  Author email: eduardonunez@csu.fullerton.edu
;  Today's date: October 12, 2022
;  Section ID: Section 01 M/W 12pm - 2pm

extern isFloat

global max

section .data

section .bss

section .text
max:
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

;   ************************* Find the largest value in the array *************************

mov r15, rdi ; first argument: the array
mov r14, rsi ; second argument: the array size 
mov rax, 1
mov rdx, 0
cvtsi2sd xmm15, rdx
mov r13, 0 ; starting r13

loop_array:
    cmp r13, r14 ; making sure we iterate through the array
    je end_looparray
    ucomisd xmm15, [r15 + 8*r13]
    jg store
    movsd xmm9, [r15 +8*r13]
    inc r13
    jmp loop_array
    store:
        movsd xmm9, xmm15
end_looparray:

movsd xmm0, xmm9

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
