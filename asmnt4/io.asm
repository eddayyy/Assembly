;****************************************************************************************************************************
;Program name: "Pure Assembly in 2022 Program".  This program demonstrates the input of a float number, the output of time, *
;radians, and the cosine of the inputted float                                                                              *
;                                                                                                                           *
;This file is part of the software program "Pure Assembly in 2022 Program".                                                 *
;Pure Assembly in 2022 Program is free software: you can redistribute it and/or modify                                      *
;****************************************************************************************************************************
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Eduardo M. Nunez Gomez
;  Author email: eduardonunez@csu.fullerton.edu
;
;Program information
;  Program name: Pure Assembly In 2022 Program
;  Programming languages: All modules in X86-64 Assembly using the NASM Compiler with Intel Syntax, 1 Shell file to compile & link.
;  Date program began: 2022-Oct-24 0800 PDT GMT-07:00
;  Date of last update: 2022-Oct-31 1800 PDT GMT-07:00
;  Date comments upgraded: 2022-Oct-31 
;  Files in this program: _start.asm , cosine.asm , ftoa.asm , input.asm , io.asm , itoa.asm , stringtof.asm , r.sh
;  Status: Finished.
;  References consulted: Johnson Trong SI leader, x86-64 Assembly Language Programming With Ubuntu by Ed Jorgensen (Chapters 1-8 & 14-25),
;  Holliday Floyd During Section-01 Lab Hours, and the nasm.us/doc for information on the NASM Assembler
;
;Purpose
;  This program demonstrates how to receive, return, store, and floats, tics, and radians.
;  The intention is to teach readers the ins and outs of pure assembly so that they may recreate their own software.
;
;This file
;  File name: io.asm
;  Language: X86 using NASM Assembler and Intel syntax
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Compiling and Linking this program and file:
;File: run.sh
;All assembling, compiling, and linking has been condensed for the user into a single file the following is a user-tutorial.
;
;Instructions: Enter the following in your linux terminal
;
;chmod +x run.sh 
;./run.sh 
;  
;
;===== Begin code area ========================================================================================================




;===== Subprogram (or function) strlen ====================================================================================================================================
;Author information
;   Author name: Floyd Holliday
;   Author emai: holliday@fullerton.edu or activeprofessor@yahoo.com
;   Author location: Room 104
;Course information
;   Course number CPSC240
;   Assignment number: To be entered soon
;   Due date: To be entered soon
;Project information
;   Project title: String length function
;   Purpose: Make a utility function to be save in the software library.
;   Date project began: 20150212
;   Date of latest update: 20150212
;   Status: This project is in development.  
;   Future development: This function will do only one simple task which is compute the length of a string.
;Module information
;   Language: X86-64
;   Syntax: Intel
;   Purpose: Count the number of characters in a null terminated string without counting the null itself.
;   Date project began: 20150212
;   File name: Not applicable
;   Status: Finished.  Released for use in other projects.
;   Future: No more development work.  This module is very focused on doing one specific task.
;System requirements
;   This program uses 64-bit GPRs (general purpose registers).  A 64-bit X86 processor is required.
;   During development the project was tested in a Linux environment.
;Translator information
;   Does not a apply because this module is included in the same file that uses it.  This module is not currently assembled separately.
;References
;   Some essential ideas were obtain from sample programs posted at www.stackoverflow.com.  Those ideas were then expanded based on the programmer's general knowledge of
;   standard parameter passing in a C or C++ environment
;Format information
;   This source code is best viewed on a monitor supporting 172 columns of width, or on paper in landscape orientation using 7 point monospaced font.
;   All comments begin in column 61.
;Preconditions
;   rdi holds the starting address of the string of which the length will be computed
;Postconditions
;   rax will hold the computed length
;Side effects
;   None: When this function returns to a caller all registers will contain original values except possibly rax.
;===== Begin program area =================================================================================================================================================
;
global strlen, showstring
section .data
;This section is empty.

section .bss
;This section is empty.

section .text
strlen:

;===== Backup segment =====================================================================================================================================================
;No floating point data are used in this program.  Therefore, state components FPU, SSE, AVX are not backed up.

;=========== Back up all the GPR registers except rax, rsp, and rip =======================================================================================================

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

;===== Application strlen begins here =====================================================================================================================================

;Set up registers needed by the repnz instruction.
;dri already holds the starting address of the array of char (the string).
xor        rcx, rcx                                         ;This is a fast technique that zeros out rcx
not        rcx                                              ;This is a fast instruction that flips all bits in rcx.  rcx now holds 0xFFFFFFFFFFFFFFFF, which is both -1 and 
;                                                           ;the largest unsigned integer.  The same result could have been obtained by "mov rcx, 0xFFFFFFFFFFFFFFFF", but 
;                                                           ;that is a slower operation.
xor        al, al                                           ;Set the lowest 8 bits (1 byte) of rax to zero.  There is no need to use extra machine time to zero out all of 
;                                                           ;rax because repnz only uses the lowest 8 bits of rax.
cld                                                         ;Clear the direction flag, which is a single bit inside of rflags register.  The term "clear" means "give it a
;                                                           ;value of 0.  When the direction bit is zero the register rdi will increment by 1 in each iteration of the 
;                                                           ;loop; otherwise, rdi will decrement in each iteration.
repnz      scasb                                            ;This is a compact loop construction.  In pseudocode it does the following::
;                                                           ;repeat
;                                                           ;    {rcx--;
;                                                           ;     rdx++;
;                                                           ;    }
;                                                           ;until (rcx == 0 || [rdi] == al);
;Since it is very unlikely that rcx will decement to zero the loop effectively continues until [rdi] equals null (the value in the lowest 1 byte or rax).  Notice that the
;null character is counted in the number of iterations of the loop.  In the next statements the count will be adjusted to compensate for the extra iteration.

not        rcx                                              ;Invert all the bits in rcx.  The result is the number of iterations of the loop
dec        rcx                                              ;Decrement rcx by one in order to avoid counting the null character.
mov        rax, rcx                                         ;Copy the count into rax, which is the standard register for returning integers to a caller.

;=========== Restore GPR values and return to the caller ==================================================================================================================

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
;Notice that rax is not restored because it holds the value to be returned to the caller.

ret;                                                        ;ret will pop the system stack into rip.  The value obtained is an address where the next instruction to be 
                                                            ;executed is stored.
;===== End of subprogram strlen ===========================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**










;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;===== Subprogram showstring ===============================================================================================================================================
;Author information
;   Author name: Floyd Holliday
;   Author emai: holliday@fullerton.edu or activeprofessor@yahoo.com
;   Author location: Room 104
;Course information
;   Course number CPSC240
;   Assignment number: To be entered soon
;   Due date: To be entered soon
;Project information
;   Project title: Show string function
;   Purpose: Make a utility function to be save in the software library.
;   Date project began: 20150212
;   Date of latest update: 20150212
;   Status: This project is in development.  
;   Future development: This function will do only one simple task which is to output a null terminated string.
;Module information
;   Language: X86-64
;   Syntax: Intel
;   Purpose: Given a string (array of char) and a non-negative integer n output to stdout the string starting at character number n without the use of printf.
;   Date project began: 20150212
;   File name: Not applicable
;   Status: Finished.  Released for use in other projects.
;   Future: No more development work.  This module is planned to have one functionality only, namely: output a string.
;System requirements
;   This program uses 64-bit GPRs (general purpose registers).  A 64-bit X86 processor is required.
;   During development the project was extensively tested in a Linux environment.
;Translator information
;   Does not a apply because this module is included in the same file that uses it.  This module is not currently assembled separately.
;References
;   Some essential ideas were obtain from sample programs posted at www.stackoverflow.com.  Those ideas were then expanded based on the programmer's general knowledge of
;   standard parameter passing in a C or C++ environment
;Format information
;   This source code is best viewed on a monitor supporting 172 columns of width, or on paper in landscape orientation using 7 point monospaced font.
;   All comments begin in column 61.
;Preconditions
;   rdi holds the starting address of the string of which the length will be computed.
;   rsi holds the position in the array where output will begin.
;Postconditions
;   rax will hold 0 if 1 or more characters were displayed, and will hold a non-zero integer (usually 1) if no characters were displayed.
;Side effects
;   None: When this function returns to a caller all registers will contain original values except possibly rax.
;===== Begin program area =================================================================================================================================================
;global showstring                                           ;This global declaration is needed if a program outside this file wants to call this subprogram.
;
section .data
;This section is empty.

section .bss
;This section is empty.

section .text
showstring:

;===== Backup segment =====================================================================================================================================================
;No floating point data is used in this program.  Therefore, state components FPU, SSE, AVX are not backed up.

;=========== Back up all the GPR registers except rax, rsp, and rip =======================================================================================================

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

;===== Application showstring begins here =================================================================================================================================

;First obtain the length of the incoming string and store the result in r15
;Preconditions:
   ;rdi holds the starting address of the string to be printed to stdout.
   ;rsi holds the position number where printing will begin.

call strlen                                                 ;The subprogram strlen will place the length in rax

;Postconditions:
   ;rax holds the length
mov        rdx, rax                                         ;Place a copy of the length in a safe place.
cmp        rsi, rdx                                         ;Compare (starting position > string length)?
jg         nothingtooutput                                  ;If (starting position > string length) then continue execution below.

;If the starting position is negative set it to zero.
cmp        rsi, 0                                           ;If (starting position >= 0) then proceed to output the string.
jge        outputstring                                     ;Skip ahead to the setup for string output.
mov        rsi, 0                                           ;Make the starting position zero.

outputstring:                                               ;Prepare parameters to send the string to stdout.
add       rdi, rsi                                          ;rdi = address inside the array where printing will begin
sub       rdx, rsi                                          ;rdx = number of characters to be printed
mov       rsi, rdi                                          ;rsi = number of characters to be printed
mov       rax, 1                                            ;1 = number of the syscall subfunction write()
mov       rdi, 1                                            ;1 = code number of stdout.  The fact that rax and rdi received the same value is coincidental.
syscall                                                     ;Call the kernel to do the work specified in parameter rax, rdi, rsi, rdx

mov       rax, 0                                            ;Return this value to the caller.  Zero indicates an expected result.

jmp       restore                                           ;rax already has the value to be returned to the caller.

nothingtooutput:
mov       rax, 1                                            ;Any nonzero value could have been place in rax.  Nonzero indicates an unexpected result.

restore:                                                    ;Begin section to restore backed up GPRs.
;=========== Restore GPR values and return to the caller ==================================================================================================================

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
;Notice that rax is not restored because it holds the value to be returned to the caller.

ret;                                                        ;ret will pop the system stack into rip.  The value obtained is an address where the next instruction to be 
                                                            ;executed is stored.
;===== End of subprogram showstring ========================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
