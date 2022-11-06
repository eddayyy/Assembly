; Author: Eduardo Nunez
; Author email: eduardonunez@csu.fullerton.edu

extern printf, scanf

global manager

section .data
    inputPrompt db "Please input the count of number of data items to be placed into the array (maximum 10 million): ", 0
    arrayFilled db "The array has been filled with non-deterministic random 64-bit float numbers.", 10, 0
    


section .bss

section .text
manager:
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