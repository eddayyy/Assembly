;  Author: Eduardo Nunez
;  Author email: eduardonunez@csu.fullerton.edu
;  Today's date: October 12, 2022
;  Section ID: Section 01 M/W 12pm - 2pm

extern fgets
extern stdin 
extern printf
extern scanf 
extern strlen
extern get_data
extern displaycpp
extern max

INPUT_LEN equ 256
LARGE_BOUNDARY equ 64
SMALL_BOUNDARY equ 16


global manager


section .data 
align SMALL_BOUNDARY
    nameprompt db "Please enter your name: " , 0
    arrayprmpt db "Please enter floating point numbers separated by ws to be stored in an arry of size 6 cells.", 10,"After the last input press <enter> followed by <control+d>", 10, 0
    arrayout db "These numbers are stored in the array", 10 , 0
    largestval db "The largest value in the array is ", 0
;   ************************* Special use characters *************************
    format: db "%s", 0
    floatformat: db "%lf", 10 , 0
section .bss 
    name: resb INPUT_LEN
    arraysize resq 6
    myarray resq 6
    align 16

section .text
manager:
;   ************************* Backing up all 64 bit registers *************************
push       rbp                                              ;Save a copy of the stack base pointer
mov        rbp, rsp                                         ;We do this in order to be 100% compatible with C and C++.
push       rbx                                              ;Back up rbx
push       rcx                                              ;Back up rcx
push       rdx                                              ;Back up rdx
push       rsi                                              ;Back up rsi
push       rdi                                              ;Back up rdi
push       r8                                               ;Back up r8
push       r9                                               ;Back up r9
push       r10                                              ;Back up r10
push       r11                                              ;Back up r11
push       r12                                              ;Back up r12
push       r13                                              ;Back up r13
push       r14                                              ;Back up r14
push       r15                                              ;Back up r15
pushf                                                       ;Back up rflags

;   ************************* Prompting User For Input *************************
mov rax, 0 
mov rdi, format
mov rsi, nameprompt ; " Please enter your name: "
call printf 

;   ************************* Collecting User's Name *************************
mov rax, 0 
mov rdi, name
mov rsi, INPUT_LEN
mov rdx, [stdin]
call fgets

mov rax, 0 
mov rdi, name
call strlen

sub rax, 1
mov byte [name + rax], 0

;   ************************* Prompting User for Array *************************
mov rax, 0 
mov rdi, format
mov rsi, arrayprmpt
call printf

;   ************************* Collecting User's Array *************************
mov rax, 0 
mov rdi, myarray
mov rsi, arraysize
call get_data
mov r15, rax
; pop rax ?

;   ************************* Printing User's Array *************************
mov rax, 0 
mov rdi, format
mov rsi, arrayout
call printf

;   ************************* Calling Show_data *************************
mov rax, 0
mov rdi, myarray
mov rsi, r15
call displaycpp

;   ************************* Finding max in the array *************************
mov rax, 0 
mov rdi, format
mov rsi, largestval ; string prompt
call printf


mov rax, 0
mov rdi, myarray
mov rsi, r15
call max
movsd xmm9, xmm0

mov rax, 1 
mov rdi, floatformat
movsd xmm0, xmm10
call printf





end:
mov rax, name

;Restore the original values to the GPRs
popf                                                        ;Restore rflags
pop        r15                                              ;Restore r15
pop        r14                                              ;Restore r14
pop        r13                                              ;Restore r13
pop        r12                                              ;Restore r12
pop        r11                                              ;Restore r11
pop        r10                                              ;Restore r10
pop        r9                                               ;Restore r9
pop        r8                                               ;Restore r8
pop        rdi                                              ;Restore rdi
pop        rsi                                              ;Restore rsi
pop        rdx                                              ;Restore rdx
pop        rcx                                              ;Restore rcx
pop        rbx                                              ;Restore rbx
pop        rbp                                              ;Restore rbp

ret                                                         ;No parameter with this instruction.  This instruction will pop 8 bytes from
