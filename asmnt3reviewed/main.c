// Author: Eduardo Nunez
// Author email: eduardununez@csu.fullerton.edu
// File: main.c, c

#include <stdio.h>

extern char *manager();

int main(int argc, char *argv[])
{
    printf("Welcome to the Arrays of Integers program.\nDeveloped for you by Eduardo Nunez\n");
    char *name = manager();
    printf("\nI hope you liked your arrays ");
    printf("%s", name);
    printf("%s", "\nMain will return 0 to the operating system. Adios. \n");
}