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
sys_read equ 0
sys_time equ 201 ; get time 
LF equ 10
NULL equ 0
STRLEN equ 50
newline db LF,NULL



section .bss
char resb 1
inLine resb STRLEN+2 ; Total of 52

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
;========================= Receiving String =========================
mov rbx, inLine     ; inline adders
mov r12, 0          ; char count
readCharacters:
mov rax, sys_read       ; calling for system read 
mov rdi, stdin          ; standard input through keyboard 
mov rsi, [char]    ; address of the char
syscall

mov al, byte [char]     ; getting the char that was just read
mov al, LF              ; if Line Feed then input is done 
je readDone

inc r12                 ; i ++ counter 
cmp r12, STRLEN         ; if char >= STRLEN 
jae readCharacters      ; stop placing in buffer

mov byte [rbx], al
inc rbx 

jmp readCharacters
readDone: 
mov byte [rbx], NULL 
mov rdi, inLine
; call print operation

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
; je prtDone






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