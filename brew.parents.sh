#!/usr/bin/env bash

# List all installed formulae that have no reverse dependencies

for f in $(brew list --formula); do
    # Find anything that depends on this formula
    parents=$(brew uses --installed "$f")

    # If nothing depends on it, print it
    if [ -z "$parents" ]; then
        echo "$f"
    fi
done
