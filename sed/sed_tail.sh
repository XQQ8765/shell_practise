#!/bin/bash
#print last 10 lines of file
# First argument is the filename
lines=`wc -l $1 | awk '{print $1}'`
start=`expr $lines - 10`
echo "-------start"$start
sed "1,$start d" $1
