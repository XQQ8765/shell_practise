#!/bin/bash
#NOTE - this script can work! A default column value is contained!
#Usage - LS -L | Column2.sh 3
column=${1:-1} #${variable:-defaultvalue}
echo '{print $'$column'}'
awk '{print $'$column'}'
