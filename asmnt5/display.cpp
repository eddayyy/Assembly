// Author: Eduardo Nunez
// Author email: eduardonunez@csu.fullerton.edu

#include <iostream>

extern "C" void display_array(double array[], unsigned long int array_size);

void display_array(double array[], unsigned long int array_size)
{
    std::cout << "\nYou are entering the display array function.\n";
    for (unsigned long int i = 0; i < array_size; i++)
    {
        std::cout << array[i] << " ";
    }
}