// Author: Eduardo Nunez
// Author email: eduardonunez@csu.fullerton.edu
// Today's date: October 12, 2022
// Section ID: Section 01 M/W 12pm - 2pm

#include <iostream>

extern "C" void displaycpp(double array[], int array_size);

void displaycpp(double array[], int array_size)
{
    for (int i = 0; i < array_size; i++)
    {
        printf("%.16lf", array[i]);
        printf("\n");
    }
}