; Author: Eduardo Nunez
; Author email: eduardonunez@csu.fullerton.edu

extern scanf                       ; Necessary to be able to access the scanf function

global fill_array                  ; Make "fill_array" callable by any function in this program

section .data
    intFormat db "%ld", 0          ; Format for Integers to pass into Scanf

section .bss
    arr_size resq 10000000         ; Reserve space for the array size variable

section .text
fill_array:
mov r15, rdi                       ; Saving the array

;************************* Prompt User For Array Size ************************* 
mov rax, 0 
mov rdi, intFormat                 ; Passing in the integer format size
mov rsi, arr_size                  ; Storing input in the arra_size variable
call scanf                         ; Calling scanf 
mov r14, [arr_size]                ; Store the array size in r14 for indexing

mov r13, 0                         ; Initialize array index to 0
start_loop:
    cmp r14, r13                   ; Checking if the array is filled
    je end_loop 
    rdrand r12                     ; Generate a random 64-bit floating point number using rdrand
    cvtsi2sd xmm0, r12             ; Convert the value in r15 to a floating-point number and store it in xmm0
    ucomisd xmm0, xmm0             ; Check for NaNs     
    jp skip                        ; If NaN then skip and don't place in array
    movsd [r15 + 8 * r13], xmm0    ; Store the number in xmm0 in the current index of the array
    inc r13                        ; Increment the indexing variable
    jmp start_loop

skip:                              ; Check for NaNs and discard them
    mov r13, 0                     ; Restart indexing if a NaN is generated
    jmp start_loop                 ; Go back to start_loop & repeat the process

end_loop:
mov rax, r13                       ; Return the Array size to Manager()
ret                                ; Going back into Manager()                       