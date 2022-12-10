; Author: Eduardo Nunez
; Author email: eduardonunez@csu.fullerton.edu

extern printf
extern srand
extern rand

global fill_array

section .data

section .bss

section .text
fill_array:

mov r15, rdi ; saving the array
mov r14, rsi ; saving the array size here 
mov r13, 0   ; Initialize array index to 0

start_loop:
    cmp r14, r13 ; Checking if the array is filled
    je end_loop
    ; Generate a random 64-bit floating point number using rdrand
    rdrand r12
    ; Convert the value in r15 to a floating-point number and store it in xmm0
    cvtsi2sd xmm0, r12

    ; Check for NaNs
    ucomisd xmm0, xmm0
    jp skip

    ; Store the number in xmm0 in the current index of the array
    movsd [r15 + 8 * r13], xmm0
    ; Increment the indexing variable
    inc r13
    jmp start_loop

; Check for NaNs and discard them
skip:
    mov r13, 0
    jmp start_loop

end_loop:
mov rax, r13

ret                                                        