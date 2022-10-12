; Author: Eduardo Nunez
; Author email: eduardonunez@csu.fullerton.edu

extern printf
global sum_array


sum_array:

section .data
intOUT db "%ld", 0 

section .bss

section .text
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

mov rax, 0 
; Placing info in the parameters
mov r15, rdi ; holds the array
mov r14, rsi ; holds the # of elements in the array


mov rdx, 0
mov r10, rdx
mov r13, 0 
sumstart:
    cmp r14, r13 ; comparing the elements in array to the size of array (6)
    je sumend
    add r10, [r15 + 8*r13]
    inc r13
    jmp sumstart
sumend:
pop rax
push qword 0
mov rax, r10
; mov rax, 0
; mov rdi, intOUT
; mov rsi, r10
; call printf


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