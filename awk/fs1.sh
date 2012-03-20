#!/bin/bash
awk '{
	if ($1 == "#START") {
		FS=":";
	} else if ($1 == "#STOP") {
		FS=" ";
	} else {
		print $3;
	}
}' ./fs.txt
