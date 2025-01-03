#!/bin/bash

if [[ $# -ne 3 ]] ; then
    echo Usage: $0 '<oddpages.pdf> <evenpages.pdf> <merged.pdf>'
    echo
    echo '<oddpages.pdf>' are front to back.
    echo '<evenpages.pdf>' are back to front.
    echo 
    exit 1
fi

pdftk A=$1 B=$2 shuffle A Bend-1 output $3