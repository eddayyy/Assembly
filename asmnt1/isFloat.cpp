// Comments From Eduardo Nunez: 
// This was downloaded and used with Johnson Trong's Consent.
// The information of the original developer has been preserved. 
// This file's function is to verify the float status of user inputs. In the Drive and Compare Floats Program
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//Author information
//  Author name: Johnson Tong
//  Author email: jt28@csu.fullerton.edu
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//This file
//   File name: isFloat.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: g++ -c -Wall -no-pie -m64 -std=c++17 -o isFloat.o isFloat.cpp
//   Link: g++ -m64 -no-pie -o finalQuadratic.out quadratic.o quad.o isFloat.o second_degree.o -std=c++17
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
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
//===== Begin code area ===========================================================================================================

#include <iostream>

extern "C" bool isFloat(char [ ]);

bool isFloat(char w[ ])
{   bool result = true;
    bool onepoint = false;
    int start = 0;
    if (w[0] == '-' || w[0] == '+') start = 1;
    unsigned long int k = start;
    while (!(w[k] == '\0') && result )
    {    if (w[k] == '.' && !onepoint)
               onepoint = true;
         else
               result = result && isdigit(w[k]) ;
         k++;
     }
     return result && onepoint;
}