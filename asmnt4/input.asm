; Author: Eduardo Nunez
; Author email: eduardonunez@csu.fullerton.edu
; Program: Pure Assembly In 2022
; File: input.asm, assembly
global input

extern main

section .data
;========================= Initializing constants =========================
stdin equ 0 
stdout equ 1
SYS_time equ 201 ; get time 
NULL equ 0

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


;========================= Loop to Count String Length =========================

push rbx
mov rdx, 0
strCountLoop:
cmp byte[rbx], NULL 
je strCountDone
inc rdx
inc rbx 
jmp strCountLoop
strCountDone:
cmp rdx, 0 
je prtDone






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