#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <lex_file> <input_file>"
    exit 1
fi

lex_file="$1"
input_file="$2"

lex "$lex_file"
gcc lex.yy.c -o "${lex_file%.*}"
"./${lex_file%.*}" "$input_file"
