// Author: Eduardo Nunez
// Course: CPSC240-01
// Author email: eduardonunez@csu.fullerton.edu
// FINAL PROGRAM TEST


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
