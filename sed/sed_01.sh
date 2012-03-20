#!/bin/bash
echo ------------------------------------
echo "--Write to a file with /w filename--"
sed -n 's/^[0-9]*[02468] /&/w even' < t0.txt
echo "--Combining substitution flags--"
sed -n 's/a/A/2pw a_file.txt' <old.txt >a_new.txt
echo "--Arguments and invocation of sed--"
#sed 's/BEGIN/begin/' <old | sed 's/END/end/' >new
echo "BEGIN END" | sed 's/BEGIN/begin/'  | sed 's/END/end/'
echo "--Multiple commands with -e command--"
echo "I am busy now, how about you?" | sed -e 's/a/A/' -e 's/b/B/'
echo "--Filenames on the command line--"
sed -e 's/^#.*//' f1 f2 f3 | grep -v '^$' | xargs echo 
sed -e 's/^#.*//' f1 f2 f3 | grep -v '^$' | wc -l
echo "--sed -n: no printing--"
sed 's/PATTERN/&/p' f1
sed -n 's/PATTERN/&/p' f1
echo "--sed -n: no printing--"
sed -f sedscript <old.txt
echo "--A sed interpreter script--"
#CapVowel <old.txt
echo "--Passing arguments into a sed script--"
param1="Hello world"
#echo "Hello world" | sed -n 's/'$param1'/& &/p'
echo "Hello world" | sed -n 's/'"$param1"'/& &/p'
# Using sed in a shell here-is document
echo -n 'what is the value?'
read value
sed 's/XXX/'$value'/' <<EOF
The value is XXX
EOF
