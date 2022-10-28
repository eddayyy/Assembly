; Author: Eduardo Nunez
; Author email: eduardonunez@csu.fullerton.edu
; Program: Pure Assembly In 2022
; File: main.asm, assembly
; Requirements: 
; 1) welcome msg, 2) time in tics, 3) inputs a float in degrees
; outputs same # for confirmation, 4) converts degree # to radian
; computes cosine of the radian, 5) shows # of tics, 6) says goodbye 

extern input, tics, goodbye, conversion, confirm, computes 
extern strlen

global _start
section .data
    welcomePhrase db "Welcome to the Accurate Cosines by EN", 10, 0 
    timePhrase db "The time is now ", 0
    timePhrase2 db " tics", 10, 0
    enteredPhrase db "You entered ", 0
    equivalentPhrase db "The equivalent radians is ", 0
    cosinePhrase db "The cosine of those degrees is ", 0
    secondsPhrase db "The time is now ", 0 
    secondsPhrase2 db " seconds", 0


section .bss
    stdout equ 1
    sys_write equ 1 
    welcome equ 39
    time1 equ 16

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
;======================== Loop to get the string lenth ========================
; mov rax, 0 
; mov rdi, welcome
; call strlen
; mov r15, rax

;======================== Printing out the welcome prompt ========================
mov rax, sys_write
mov rdi, stdout 
mov rsi, welcomePhrase
mov rdx, r15 
syscall 
; end block 

;======================== Holding off with the time module ========================
; mov rax, sys_write
; mov rdi, stdout 
; mov rsi, timePhrase
; mov rdx, time1 ; This prints "The time is now " without a newline at the end 
; syscall
; end block

;======================== Receive the input ========================
call input



;======================== Ending this dumb program ========================
mov rax, 60
mov rdi, 0
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

 