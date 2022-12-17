// Author: Eduardo Nunez
// Author email: eduardonunez@csu.fullerton.edu

#include <iostream>

extern "C" double manager();

int main()
{
    std::cout << "Welcome to the array filler program by Eduardo Nunez.\n";
    double answer = manager();
    std::cout << "\n\nThe main program received: " << answer << std::endl;
}