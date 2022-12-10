// Author: Eduardo Nunez
// Author email: eduardonunez@csu.fullerton.edu

#include <iostream>
#include <array>

extern "C" void array_displayer(float array[], int size);

void array_displayer(float array[], int size)
{
    // std::cout << "\nYou have entered the array displayer. "
    //           << "The array size is: "
    //           << size
    //           << "\nThe 10th element in the array will now be printed: "
    //           << array[10]
    //           << std::endl
    //           << "[";
    if (size <= 10)
    {
        std::cout << "\nThe array size you determined is less than or equal to 10, here is the entire array:\n";
        for (int i = 0; i < size; i++)
        {
            std::cout << array[i] << "\n";
        }
        return;
    }
    std::cout << "Here are 10 numbers of the array at the beginning: \n";

    for (int i = 0; i < 10; i++)
    {
        std::cout << array[i] << ", ";
    }
    std::cout << "]" << std::endl;
}
