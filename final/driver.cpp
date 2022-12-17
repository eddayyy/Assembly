// Author: Eduardo Nunez
// Course: CPSC240-01
// Author email: eduardonunez@csu.fullerton.edu
// FINAL PROGRAM TEST

#include <iostream>

extern "C" double supervisor();

int main(){
    std::cout << "Welcome to Harmonic mean by Eduardo Nunez\n"
              << "This program will compute the harmonic mean of your numbers.\n";
    double answer = supervisor();
    printf("\nThe main function received this number "); 
    printf("%1.100lf", answer);
    printf(" and will keep it for a while.\n");
    std::cout << "\nThank you for an amazing semester and have a great winter break professor!!!" << std::endl;      
    return 0;
}