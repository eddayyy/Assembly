// Author: Eduardo Nunez
// Author email: eduardonunez@csu.fullerton.edu

#include <iostream>
#include <array>
#include "math.h"

extern "C" void array_displayer(float array[], int size);

void array_displayer(float array[], int size)
{
    if (size <= 10)
    {
        std::cout << "\nThe array size you determined is less than or equal to 10.\nHere is the beginning of array:\n";
        for (int i = 0; i < size; i++)
        {
            std::cout << array[i] << "\n";
        }
        std::cout << "\nHere is the middle of array:\n";
        for (int i = 0; i < size; i++)
        {
            std::cout << array[i] << "\n";
        }
        std::cout << "\nHere is the end of array:\n";
        for (int i = 0; i < size; i++)
        {
            std::cout << array[i] << "\n";
        }
        return;
    }

    std::cout << "\nHere are 10 numbers of the array at the beginning:\n{";
    for (int i = 0; i < 10; i++)
    {
        std::cout << array[i] << ", ";
    }
    std::cout << "}" << std::endl;
    math_middle(array, size);
    math_ending(array, size);
}


extern "C" void sortedarray_displayer(float array[], int size);

void sortedarray_displayer(float array[], int size)
{
    if (size <= 10)
    {
        std::cout << "\nThe array size you determined is less than or equal to 10.\nHere is the beginning of array:\n";
        for (int i = 0; i < size; i++)
        {
            std::cout << array[i] << "\n";
        }
        std::cout << "\nHere is the middle of array:\n";
        for (int i = 0; i < size; i++)
        {
            std::cout << array[i] << "\n";
        }
        std::cout << "\nHere is the end of array:\n";
        for (int i = 0; i < size; i++)
        {
            std::cout << array[i] << "\n";
        }
        return;
    }

    std::cout << "\nHere are 10 numbers of the array at the beginning:\n{";
    for (int i = 0; i < 10; i++)
    {
        std::cout << array[i] << ", ";
    }
    std::cout << "}" << std::endl;
    sortedmath_middle(array, size);
    sortedmath_ending(array, size);
}