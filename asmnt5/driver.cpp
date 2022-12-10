// Author: Eduardo Nunez
// Author email: eduardonunez@csu.fullerton.edu

#include <iostream>

extern "C" int manager();

int main()
{
    std::cout << "Welcome to the array filler program by Eduardo Nunez.\n";
    int answer = manager();
    // std::cout << " " << answer << std::endl;
}