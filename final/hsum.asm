; Author: Eduardo Nunez
; Course: CPSC240-01
; Author: eduardonunez@csu.fullerton.edu
; FINAL PROGRAM TEST


; This function returns the sum to the supervisor 
; the supervisor then divides the count by the sum and gets the mean


extern printf

global hsum

section .data
    floatFormat db "%1.8lf", 0
    hSumDisplay db "The harmonic sum is %1.10lf", 10 ,0

section .bss

section .text
hsum:

push qword 0
    mov r15, rdi ; store the array in r15
    mov r14, rsi ; store the array size in r14


    mov rax, __float64__(0.0) 
    movq xmm12, rax   ; initializing this as our place holder for the sum

    mov r13, 0   ; initialize the indexing variable
    
    ; Begin the loop
sum_loop: 
    cmp r13, r14        ; Check if the array has been parsed through
    jge end_sum         ; if it has then jump to the end

    mov rax, __float64__(1.0) ; this will be the numerator
    movq xmm0, rax            ; place the numerator in xmm0 for later math
    movq xmm3, [r15 + 8 * r13] ; place the nth element into xmm3
    divsd xmm0, xmm3            ; calculate the recipicol
    addsd xmm12, xmm0          ; add the recipricol to xmm14 and so on

    inc r13  
    jmp sum_loop

end_sum:
    movsd xmm0, xmm12
    mov rax, r14
    pop rax
    ret