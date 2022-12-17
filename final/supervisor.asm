; Author: Eduardo Nunez
; Course: CPSC240-01
; Author: eduardonunez@csu.fullerton.edu
; FINAL PROGRAM TEST

extern scanf, printf
extern random_fill_array, hsum, display_array

global supervisor


INPUT_LEN equ 256
max_size equ 1000000

section .data
    inputPrompt db "Please input the count of number of data items to be placed into the array (with maximum 1 million): ", 10,10, 0
    inputConfirm db 10, "The array has been filled with non-deterministic random 64-bit float numbers.", 10, 0
    valuesDisplay db 10, "Here are the values in the array: ",10 ,0
    hSumDisplay db "The harmonic sum is %1.100lf", 10 ,0
    hMeanDisplay db "The harmonic mean is %1.100lf", 10, 0
    ld db "%ld", 0
    lf db "%lf", 0

section .bss
    arr resq max_size

section .text
supervisor:

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

;************************* Call random_fill_array And Pass In The Array ************************* 
push qword 0
mov rax, 0
mov rdi, arr        ; array 
call random_fill_array
mov r13, rax        ; Placing the amount of times fill_array iterated "arr" into r13 

;************************* Confirmation line ************************* 
mov rax, 0
mov rdi, inputConfirm
call printf

;************************* Confirmation line ************************* 
mov rax, 0 
mov rdi, valuesDisplay
call printf

;************************* Displaying The Array ************************* 
push qword 0
mov rax, 0
mov rdi, arr
mov rsi, r13
call display_array 

pop rax
pop rax

;************************* Calculating the harmonic sum ************************* 
mov rax, 0
mov rdi, arr
mov rsi, r13
call hsum
movsd xmm12, xmm0
mov r12, rax
;************************* Display the harmonic sum ************************* 
mov rax, 1
mov rdi, hSumDisplay
movsd xmm0, xmm12
call printf

;************************* Display the harmonic mean *************************
movq xmm8, r12
divsd xmm8, xmm8

mov rax, 1
mov rdi, hMeanDisplay
movsd xmm0, xmm12
call printf 

end:
movsd xmm0, xmm12


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