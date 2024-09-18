#!/bin/bash
# Functions

# cd into dir and list contents
lc() {
    cd "$1" && la "$2"
}

# Make directory and cd into it
mcd() {
    mkdir -p -- "$1" && cd -P -- "$1"
}
