#!/bin/bash
#Compare the output
echo "One Two:Three:4 Five" | awk 'BEGIN {FS=":"}\
{
	print $2;
}'

echo "One Two:Three:4 Five" | awk '{
	FS=":";
	print $2;
}'

echo "One Two:Three:4 Five" | awk '{
	if ($0 ~ /:/) {
		FS=":";
		echo "FS:$FS"
	} else {
		FS=" ";
	}
	print $2;
}'
