#!/bin/bash
#NOTE - Print all other fields except column 1 & 3 
ls -l | awk '{
	$1="";
	$3="";
	print;
}'
