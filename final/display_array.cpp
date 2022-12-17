// Author: Eduardo Nunez
// Course: CPSC240-01
// Author email: eduardonunez@csu.fullerton.edu
// FINAL PROGRAM TEST

// Authors Note: I've never taken a "C" course at CSUF,
// nor did we go over any "C" so im going to write this in C++.

#include <iostream>
#include <array>
#include "math.h"

extern "C" void display_array(float array[], int size);

void display_array(float array[], int size)
{
    for (int i = 0; i < size; i++)
    {
        std::cout << array[i] << "\n";
    }
    std::cout << std::endl;
}
