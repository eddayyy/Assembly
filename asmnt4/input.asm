c```; Author: Eduardo Nunez
; Author email: eduardonunez@csu.fullerton.edu
; Program: Pure Assembly In 2022
; File: input.asm, assembly

extern input


global input 

section .data


section .bss


section .text
input:
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
