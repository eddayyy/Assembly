; Author: Eduardo Nunez
; Author email: eduardonunez@csu.fullerton.edu

extern strlen
extern fgets
extern stdin 
extern printf
extern scanf 
extern input_array
extern displaycpp
extern sum_array

global manager

input_LEN equ 256


section .data
    welcomeprompt db "Please enter your name: " , 0
    intOUT db "%ld", 0
    sformat db "%s", 0
    arrayprmpt db "This program will sum your array of integers", 10, "Enter a sequence of long integers separated by white space.", 10, "After the last input press enter followed by CTRL+D: ", 10 , 0
    arrout db "These numbers were received and placed into the array: ", 10 , 0
    sumsizeOut db 10, 10,"The sum of the ", 0
    sum2sizeOut db " numbers in this array is ", 0
    returnex db 10, 10, "This program will return execution to the main function. ", 10, 0


section .bss
    name resb input_LEN
    num_array resq 6
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

;   ************************* Prompting For Input *************************

mov rax, 0
mov rdi, sformat
mov rdi, welcomeprompt
call printf 

;   ************************* Collecting & Printing Input *************************

mov rax, 0 
mov rdi, name
mov rsi, input_LEN
mov rdx, [stdin]
call fgets

mov rax, 0 
mov rdi, name
call strlen

sub rax, 1
mov byte [name + rax], 0

;   ************************* Second Print *************************
mov rax, 0 
mov rdi, sformat
mov rsi, arrayprmpt
call printf

;   ************************* Calling Input Array module *************************
mov rax, 0 
mov rdi, num_array
call input_array
mov r15, rax
; mov r12, rsi
pop rax

;   ************************* Confirming Status *************************
mov rax, 0 
mov rdi, arrout
call printf 
push rax

;   ************************* Calling display.cpp to Display The Array *************************
push qword 0 
mov rax, 0 
mov rdi, num_array
mov rsi, r15
call displaycpp
pop rax

;   ************************* Printing out the sum ****************
mov rax, 0 
mov rdi, sumsizeOut
call printf 
; ; print array size 
push qword 0

; Printing array size i.e sum of the "6" numbers, etc.
mov rax, 0
mov rdi, intOUT ; formating an integer output 
mov rsi, r15 ; placing the array size into rsi
call printf ; printing out the # of elements in the array

; Prints "numbers in this array is: "
mov rax, 0 
mov rdi, sum2sizeOut ; placing message into rdi register
call printf ; printing 
pop rax

;   ************************* Calculating Sum & Storing it ****************
mov rax, 0 
mov rdi, num_array ; moving the array into rdi so it goes into sum_array
mov rsi, r15 ; moving sum of array into rsi so it goes into sum_array
call sum_array ; calculating the sum 
mov rdi, intOUT
mov rsi, rax
call printf 
push qword 0 
pop rax

;   ************************* Returning execution to driver *************************
mov rax, 0 
mov rdi, returnex
call printf 


end:
pop rax
push qword 0 
mov rax, name

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