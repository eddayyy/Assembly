#!/bin/bash
# Comments From Eduardo Nunez: 
# This was downloaded and used with Johnson Trong's Consent.
# The information of the original developer has been preserved. 
# This file's function is to compile, link, and run the Drive and Compare Floats program with just 1 command to the terminal. 
#=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
# Original Comments: 
# This file
#   File name: run.sh
#   Language: Bash
#Author: Johnson Tong
# End Original Comments. 
#=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
#Compiling and Linking this program and file:
#  All assembling, compiling, and linking has been condensed for the user into a single bash script file named "run.sh" 
#  The following is a user-tutorial:
#  Enter the following in your linux terminal
#
#  chmod +x run.sh 
#  ./run.sh 
#=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
# Additional Comments: 
#   echo commands have been commented out to maintain a clean terminal. They may be uncommented out to understand what file
#   is producing an error when running ./run.sh .
#   The echo commands also provide further clarity for compiling the individual files feel free to test them out. 
#===== Begin code area ===========================================================================================================

# echo "compile driver.cpp using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o driver.o driver.cpp

# echo "compile isFloat.cpp using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o isFloat.o isFloat.cpp

# echo "Assemble compare.asm"
nasm -f elf64 -l compare.lis -o compare.o compare.asm

# echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o final.out compare.o driver.o isFloat.o -std=c++17

./final.out
# echo "Script file has terminated."
rm *.o
rm *.lis
rm *.out