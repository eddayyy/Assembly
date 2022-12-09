//******************************************************************************************************************
//Program name: "Array Management".  This program demonstrates how to pass an array to a called subprogram.        *
//Copyright (C) 2020 Floyd Holliday                                                                                *
//
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public*
//License version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it *
//will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A  *
//PARTICULAR PURPOSE.  See the GNU General Public License for more details.  A copy of the GNU General Public      *
//License v3 is available here:  <https://www.gnu.org/licenses/>.                                                  *
//******************************************************************************************************************


//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2
//
//Author information
//  Author name: Floyd Holliday
//  Author email: holliday@fullerton.edu
//
//Program information
//  Program name: Array Management
//  Programming languages: Two modules in C, two modules in X86
//  Date program began:     2022-Mar-04
//  Date program completed: 2022-Mar-06
//  Date comments upgraded: 2022-Mar-06
//  Files in this program: director.c, supervisor.asm, output_array.asm, input_array.c, director.c 
//  Status: Complete.  Alpha testing is finished.  Extreme cases were tested and errors resolved.
//
//References for this program
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
//
//Purpose (academic)
//  Show how to pass an array from a caller function to a called function.
//
//This file
//   File name: input_array.c
//   Language: C
//   Max page width: 116 columns
//   Compile: gcc -c -m64 -Wall -fno-pie -no-pie -o input.o input_array.c -std=c17
//   Link: gcc -m64 -no-pie -o arr.out -std=c17 director.o super.o input.o output.o #-fno-pie -no-pie    
//   Reference regarding -no-pie: Jorgensen, page 226.
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2
//
//
//
//
//===== Begin code area ================================================================================================

#include "stdio.h"

extern long input_array(double *, long );

long input_array(double * arr, long size)
{printf("Input a sequence of long integers separated by ws.  Enter <enter><cntl+d> to terminate. ");
 long index = 0;
 while (index<size && scanf("%lf",&arr[index]) != EOF)
 {index++;
 }//End of while
 //Note: scanf returns 0 if a value was successfully inputted and returns EOF in other cases.
 printf("%1ld data have been successfully stored in the array\n",index); 
 return index;
}
