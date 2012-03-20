#!/bin/bash
#NOTE - this script can work!
#Usage - LS -L | Column2.sh 3
column=$1
echo '{print $'$column'}'
awk '{print $'$column'}'
