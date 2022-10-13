//****************************************************************************************************************************
//Program name: "Drive and Compare Floats Program".  This program demonstrates the input and output of a float number and re *
//turns the largest, smallest and sometimes -1 for invalid inputs.                                                           *
//                                                                                                                           *
//This file is part of the software program "Drive and Compare Floats Program".                                              *
//Drive and Compare Floats Program is free software: you can redistribute it and/or modify.                                  *
//****************************************************************************************************************************
//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**S
//Author information
//  Author name: Eduardo M. Nunez Gomez
//  Author email: eduardonunez@csu.fullerton.edu
//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//Program information
//  Program name: Drive and Compare Floats Program
//  Programming languages: Driver module and isFloat module in C++ and one module in X86-64 Assembly using the NASM Compiler
//  Date program began: 2022-Aug-17 0900 PDT GMT-07:00
//  Date of last update: 2022-Sep-04 1800 PDT GMT-07:00
//  Date comments upgraded: 2022-Sep-04 
//  Files in this program: driver.cpp, compare.asm, isFloat.cpp, run.sh
//  Status: Finished.
//  References consulted: Johnson Trong SI leader, x86-64 Assembly Language Programming With Ubuntu by Ed Jorgensen (Chapters 1-8 & 14-25),
//  Holliday Floyd During Section-01 Lab Hours, the nasm.us/doc for information on the NASM Assembler, and "Creel" on youtube for his x86 asm tutorials
//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//Purpose:
//  This program demonstrates how to receive, return, store, and identify errors in inputs from users.
//  The intention is to teach readers the ins and outs of the program so they may recreate their own. 
//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//This file
//  File name: driver.cpp
//  Language: C++
//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//Compiling and Linking this program and file:
//  All assembling, compiling, and linking has been condensed for the user into a single bash script file named "run.sh" 
//  The following is a user-tutorial:
//  Enter the following in your linux terminal
//
//  chmod +x run.sh 
//  ./run.sh 
//
//  More information regarding this file can be found in the header of run.sh.  
//
//===== Begin code area ========================================================================================================

#include <iostream> 
#include <stdio.h>
#include <cstdio> 


using namespace std;
extern "C" double compare();
extern "C" double isFloat();

int main(int argc, char *argv[])
{
    printf("%s", "Welcome to FLoating Points Numbers programmed by Eduardo Nunez.\n" "Mr. Nunez has been working for the Longstreet Software Company for the last two years.\n\n");
    double answer = compare();
    printf("The driver module received this float number %.16lf and will keep it.\n", answer);
    cout << "The driver module will return integer 0 to the operating system.\nHave a nice day. Good-bye.\n";
    return 0;
}   