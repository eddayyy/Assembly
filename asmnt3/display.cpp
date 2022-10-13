// Author: Eduardo Nunez
// Author email: eduardonunez@csu.fullerton.edu

#include <iostream>

extern "C" void displaycpp(long int array[], int array_size);

void displaycpp(long int array[], int array_size)
{
    for (int i = 0; i < array_size; i++)
    {
        printf("%ld\n", array[i]);
    }
}
