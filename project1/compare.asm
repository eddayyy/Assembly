;****************************************************************************************************************************
;Program name: "Drive and Compare Floats Program".  This program demonstrates the input and output of a float number and re *
;turns the largest, smallest and sometimes -1 for invalid inputs.                                                           *
;                                                                                                                           *
;This file is part of the software program "Drive and Compare Floats Program".                                              *
;Drive and Compare Floats Program is free software: you can redistribute it and/or modify                                   *
;****************************************************************************************************************************
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Eduardo M. Nunez Gomez
;  Author email: eduardonunez@csu.fullerton.edu
;
;Program information
;  Program name: Drive and Compare Floats Program
;  Programming languages: One modules in C++ and one module in X86-64 Assembly using the NASM Compiler
;  Date program began: 2022-Aug-17 0800 PDT GMT-07:00
;  Date of last update: 2022-Sep-04 1800 PDT GMT-07:00
;  Date comments upgraded: 2022-Sep-04 
;  Files in this program: driver.cpp, compare.asm, isFloat.cpp, run.sh
;  Status: Finished.
;  References consulted: Johnson Trong SI leader, x86-64 Assembly Language Programming With Ubuntu by Ed Jorgensen (Chapters 1-8 & 14-25),
;  Holliday Floyd During Section-01 Lab Hours, and the nasm.us/doc for information on the NASM Assembler
;
;Purpose
;  This program demonstrates how to receive, return, store, and identify errors in inputs from users.
;  The intention is to teach readers the ins and outs of the program so they may recreate their own. 
;
;This file
;  File name: compare.asm
;  Language: X86 using NASM Assembler and syntax
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
;More information regarding this file can be found in the header of run.sh.  
;
;===== Begin code area ========================================================================================================

extern printf
extern scanf 
extern atof
extern isFloat

global compare

;   ************************* Declaring Variables *************************
section .data

    inputmessage db "Please enter two float numbers separated by a white space. Press enter after the second input",10,10,0
    mynumber db "The larger number is %1.16lf",10,0
    stringform db "%s", 0 
    two_stringform db "%s%s",0
    bad_message db 10,"An invalid input was detected. You may run this program again",10, 10, 0
    two_float_format db 10,"These numbers were entered:",10, "%.16lf",10, "%.16lf", 10,10, 0
    returnexecution db 10, "This assembly module will now return execution to the driver module.", 10 ,"The smaller number will be returned to the driver.",10,10,0

section .text
compare:

;   ************************* Backing up all 64 bit registers *************************
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

;   ************************* Prompt user for their float input *************************
    mov rax, 0
    mov rdi, inputmessage
    call printf
;   ************************* Making space in rsp for 2 strings *************************
    sub rsp, 2048
    mov rax, 0
;   ************************* Storing two_stringform into rdi to give inputs a location *************************
    mov rdi, two_stringform
    mov rsi, rsp
    mov rdx, rsp
    add rdx, 1024
;   ************************* Move the string locations to more stable registers in the stack *************************
    mov r15, rsp 
    mov r14, rdx
    call scanf

;   ************************* Validate the inputs as floats by calling isFloat.cpp using "call isFloat" *************************
    mov rax, 0
    mov rdi, r15
    call isFloat 
    cmp rax, 0 ; Comparing 
    je BadMessage ; If not floats then we jump to BadMessage: where the error is given

    mov rax, 0 
    mov rdi, r14
    call isFloat
    cmp rax, 0
    je BadMessage ; If not floats then we jump to BadMessage: where the error is given


;   ************************* Convert to floats using "call atof" and store them into xmm registers ************************* 
    mov rax, 0
    mov rdi, r14
    call atof
    movsd xmm14, xmm0

    mov rax, 0
    mov rdi, r15
    call atof
    movsd xmm15, xmm0

;   ************************* Print out 2 floats *************************
    mov rax, 2
    mov rdi, two_float_format
    movsd xmm0, xmm15
    movsd xmm1, xmm14
    call printf 


;   ************************* Find largest and move it to xmm9 *************************
    mov rax, 0
    ucomisd xmm14, xmm15
    movsd xmm9, xmm14  ; store larger num into xmm9 for consistency 
    movsd xmm10, xmm15 ; store smaller num into xmm10 for consistency 
    ja continue
    movsd xmm9, xmm15  ; store larger num into xmm9 for consistency 
    movsd xmm10, xmm14 ; store smaller num into xmm10 for consistency 
    continue: 

;   ************************* Printing larger number *************************
    mov rax, 1
    mov rdi, mynumber
    movsd xmm0, xmm9
    call printf
;   ************************* Return execution to the driver module *************************
    mov rdi, returnexecution 
    call printf
    jmp  end

;   ************************* Print invalid input / bad message *************************
    BadMessage:
    mov rax, -1 ;   return -1 to the driver module for invalid floats 
    cvtsi2sd xmm10, rax
    mov rdi, bad_message
    call printf
;   ************************* Return smallest float to driver module *************************
    end:
    add rsp, 2048
    movsd xmm0, xmm10

;   ************************* Restoring all 64 bit registers for stability and peace among the stack *************************
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