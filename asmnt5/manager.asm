; Author: Eduardo Nunez
; Author email: eduardonunez@csu.fullerton.edu

extern printf
extern scanf

global manager

manager:

section .data
    inputPrompt db "Please input the count of number of data items to be placed into the array (with maximum 10 million): ", 10, 0
    inputConfirm db "The array has been filled with non-deterministic random 64-bit float numbers.", 10, 0
    tenBeginning db "Here are 10 numbers of the array at the beginning: ", 10, 0
    intFormat db "%d", 0

section .bss
    userInput: db 0

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

;************************* Print Out Input Prompt ************************* 
mov rax, 0
mov rdi, inputPrompt
call printf

;************************* Collect User Array Amount ************************* 
mov rax, 0
mov rdi, intFormat
mov rsi, userInput
call scanf


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