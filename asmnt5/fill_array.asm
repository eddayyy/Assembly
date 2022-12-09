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
    mov r13, [rdi] ; saving the array
    mov r12, rsi ; saving the array size here 

    ; Initialize array index to 0
    mov r14, 0

start_loop:
    ; Generate a random 64-bit floating point number using rdrand
    rdrand r15

    ; Convert the value in r15 to a floating-point number and store it in xmm0
    cvtsi2sd xmm0, r15

    ; Check for NaNs]
    ucomisd xmm0, xmm0
    jp skip

    ; Store the number in xmm0 in the current index of the array
    movsd [r13 + r12 * 8], xmm0

    ; Increment the indexing variable
    inc r14
    cmp r14, r12
    ; Repeat this loop until the array is filled 
    je end_loop
    jmp start_loop

    ; Check for NaNs and discard them
    skip:
        inc r14
        cmp r14, r12
        jg start_loop

    end_loop:
        ; Return the array to the caller
        mov rax, [rdi]
        ret