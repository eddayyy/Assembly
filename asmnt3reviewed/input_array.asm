; Author: Eduardo Nunez
; Author email: eduardonunez@csu.fullerton.edu

extern printf

extern scanf

global input_array

; INPUT_LEN equ 256

section .data
    intIN db "%ld", 0

section .bss
    ; dataArray resb INPUT_LEN

section .text
input_array:
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

push qword 0 

;************************* Collect User Array ************************* 
mov r15, rdi ; place the array into r15 
; mov r14, rsi ; r14 holds the size of the array

mov r13, 0 ; r13 is the condition for this input loop
Loop_Start:
    ; cmp r14, r13 ; comparing that the size of the array does not equal the capacity
    ; je outofloop
    mov rax, 0 
    mov rdi, intIN
    push qword 0
    mov rsi, rsp
    call scanf 
    cdqe
    cmp rax, -1 
    pop r12
    je outofloop
    mov [r15 + 8*r13], r12 
    inc r13 
    jmp Loop_Start
outofloop:


pop rax
mov rax, r13 
; mov rsi, r12

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