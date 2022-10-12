// Author: Eduardo Nunez
// Author email: eduardonunez@csu.fullerton.edu
// Today's date: October 12, 2022
// Section ID: Section 01 M/W 12pm - 2pm

// using namespace std is not used in this program 

#include <iostream> 

extern "C" char *manager();

int main(int argc, char* argv[]){
    std::cout << "Welcome to maximum Authored by Eduardo Nunez\n";
    char *name = manager();
    printf("Thank you for using this software, ");
    printf("%s", name);
    std::cout << " \nBye.\nA zero was returned to the operating system.\n";
}