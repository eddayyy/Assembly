#! /usr/bin/bash
set -e
rm -r -f *.o *.lis *.out

glob() {
    # https://stackoverflow.com/a/15515152/5041327
    [ -e "$1" ] && echo "$@"
}

filter() {
    for f in "${@:3}"; do
        [ "$f" $1 "$2" ] && echo "$f"
    done
}

globcode() {
    filter != '_*' $(glob "$@")
}

CFLAGS="-g -m64 -Wall -Wextra -Wpedantic -fsanitize=address -fstack-protector -fno-pie -no-pie"
CXXFLAGS="$CFLAGS -std=c++17"

hasC=
out="$(basename "$PWD").out"

for f in $(globcode *.asm); do
    nasm -f elf64 -o "$f.o" "$f"
done

for f in $(globcode *.cpp); do
    hasC=1
    g++ -c $CXXFLAGS -o "$f.o" "$f"
done

for f in $(globcode *.c); do
    hasC=1
    gcc -c $CFLAGS -o "$f.o" "$f"    
done

[ -n "$hasC" ] \
    && gcc $CXXFLAGS -o $out *.o \
    || ld -o $out *.o

rm -r -f  *.o *.lis