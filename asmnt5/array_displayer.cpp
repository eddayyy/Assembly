// Author: Eduardo Nunez
// Author email: eduardonunez@csu.fullerton.edu

#include <iostream>
#include <array>

extern "C" int test(int size);
int test(int size)
{

    std::cout << "\nPrinting the test function. Array size is: " << size << std::endl;
    return size;
}

extern "C" void array_displayer(double array[], int size);

void array_displayer(double array[], int size)
{
    std::cout << "\nYou have entered the array displayer. "
              << "The array size is: "
              << size
              << "\nThe 10th element in the array will now be printed: "
              << array[10]
              << std::endl;
}