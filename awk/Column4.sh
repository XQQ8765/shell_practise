#!/bin/bash
#NOTE - this script can work! A default column value is contained!
#Save a single line by combinning these tow steps
#Usage - LS -L | Column4.sh 3
awk '{print $'${1:-1}'}'
