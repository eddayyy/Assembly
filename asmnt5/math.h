// Author: Eduardo Nunez
// Author email: eduardonunez@csu.fullerton.edu

#include <iostream>

void math_middle(float array[], int size){
    int startNum = (size / 2) - 5;
    int endNum = startNum + 9;
    std::cout << "\nHere are the middle 10 numbers:\n{";
    for(int i = startNum; i <= endNum; i++){
        std::cout << array[i];
        if (i < endNum){
            std::cout << ", ";
        }
    }
    std::cout << "}\n\n";
}

void math_ending(float array[], int size){
    int start_Num = size - 10;
    int end_Num = size;
    std::cout << "Here are the last 10 numbers:\n{";
    for(int i = start_Num; i < end_Num; i++){
        std::cout << array[i];
        if (i < end_Num){
            std::cout << ", ";
        }
    }
    std::cout << "}\n\n";
}

void sortedmath_middle(float array[], int size){
    int startNum = (size / 2) - 5;
    int endNum = startNum + 9;
    std::cout << "\nHere are the middle 10 numbers:\n{";
    for(int i = startNum; i <= endNum; i++){
        std::cout << array[i];
        if (i < endNum){
            std::cout << ", ";
        }
    }
    std::cout << "}\n\n";
}

void sortedmath_ending(float array[], int size){
    int start_Num = size - 10;
    int end_Num = size;
    std::cout << "Here are the last 10 numbers:\n{";
    for(int i = start_Num; i < end_Num; i++){
        std::cout << array[i];
        if (i < end_Num){
            std::cout << ", ";
        }
    }
    std::cout << "}\n\n";
}

