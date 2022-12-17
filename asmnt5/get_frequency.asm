; Author: Eduardo Nunez
; Author email: eduardonunez@csu.fullerton.edu

extern printf, clock_speed, scanf, sortFloats, sortedarray_displayer

global get_frequency
section .data
  text2 db "The time is now %lu tics. Sorting will begin.", 10, 0
  text5 db "The time is now %lu tics. Sorting has finished.", 10, 10, 0
  text6 db "Total sort time is %lu tics.", 10, 10, 0
  text7 db "Your processor frequency in GHz is %.2lf.", 10, 10, 0
  text8 db "The elapsed time equals %.9lf seconds.", 10, 10, 0
  text9 db "The sum will be returned to the caller module.", 10, 10, 0
  frequency db "An AMD processor was detected. Please enter your processor frequency in GHz: ", 0

  ld db "%ld", 0
  lf db "%lf", 0

section .bss

section .text
get_frequency:

  ; Store the array and array size:
  mov r15, rdi ; save the array
  mov r12, rsi ; save the array size

; get tics and store in r14.
  mov rax, 0
  mov rdx, 0

  ; stop system and read clock time.
  cpuid
  rdtsc

  ; shift all the bits of rax 32 bits to the left.
  shl rdx, 32
  ; our number of tics.
  add rdx, rax
  ; store the number of tics in r14.
  mov r14, rdx

  ; Print the number of tics.
  push qword 0
  mov rax, 0
  mov rdi, text2
  mov rsi, r14
  call printf
  pop rax


  ; get tics and store in r13.
  mov rax, 0
  mov rdx, 0

  ; stop system processes and
  ; read clock time stamp
  cpuid
  rdtsc

  ; shift all the bits of rax 32 bits to the left
  shl rdx, 32

  ; our complete number of tics
  add rdx, rax

  ; move tics elapsed to r14
  mov r13, rdx

  ; Call sort function 
  mov rdi, r15
  mov rsi, r12
  call sortFloats
  mov r15, rax

  ; Print out start time tics elapsed
  push qword 0
  mov rax, 0
  mov rdi, text5
  mov rsi, r13
  call printf
  pop rax

  ; Calculate elapsed time.
  mov rax, 0
  mov r12, r13
  sub r12, r14  ; r12 holds elapsed time in tics

  ; Print elapsed time.
  push qword 0
  mov rax, 0
  mov rdi, text6
  mov rsi, r12
  call printf
  pop rax

  ; Get the frequency and store it in xmm11.
  mov rax, 1
  call clock_speed
  movsd xmm11, xmm0

  ; Print the frequency of the user's machine.
  push qword 0
  mov rax, 1
  mov rdi, text7
  movsd xmm0, xmm11
  call printf
  pop rax

  ; Check for AMD processor.
  mov rax, 0
  cvtsi2sd xmm9, rax

  comisd xmm11, xmm9
  je AMD

calculate_time:
  ; Convert tics to floats.
  cvtsi2sd xmm14, r14 ; start time
  cvtsi2sd xmm13, r13 ; end time

  ; End - start
  subsd xmm13, xmm14

  ; Move  elapsed time into xmm12.
  movsd xmm12, xmm13

  ; Elapsed time / GHz and store it in xmm12.
  divsd xmm12, xmm11

  ; Get value of 1 billion and store it in xmm10.
  mov rax, 0x41cdcd6500000000
  push rax
  movsd xmm10, [rsp]
  pop rax

  ; Convert the nanosecs into seconds.
  divsd xmm12, xmm10

  ; Print the elapsed time in seconds.
  push qword 0
  mov rax, 1
  mov rdi, text8
  movsd xmm0, xmm12
  call printf
  pop rax

  push qword 0
  mov rax, 0
  mov rdi, text9
  call printf
  pop rax

  jmp end_pops

AMD:
  ; Ask user for their processor's frequency.
  push qword 0
  mov rax, 0
  mov rdi, frequency
  call printf
  pop rax

  ; Store the input in xmm11.
  push qword 0
  mov rax, 1
  mov rdi, lf
  mov rsi, rsp
  call scanf
  movsd xmm11, [rsp]
  pop rax

  jmp calculate_time

end_pops:
  pop rax
  ; Return sort time to manager then to driver
  movsd xmm0, xmm15
  ; pop registers.
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