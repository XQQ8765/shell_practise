#!/bin/bash
#NOTE - this script does not work!
#Usage - LS -L | Column1.sh 3
column=$1
#echo '{print $column}'
awk '{print $column}'
