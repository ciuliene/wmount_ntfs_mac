#!/bin/bash

mkdir source

cd source

# Create 10 files
for ((i=1; i<=1; i++))
do
    touch file$i.txt
done

# Create 3 folders
for ((i=1; i<=2; i++))
do
    mkdir folder$i

    # Create 4 files in each folder
    for ((j=1; j<=2; j++))
    do
        touch folder$i/folder${i}_file$j.txt
    done
done

cd ..