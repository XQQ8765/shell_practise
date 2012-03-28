#!/bin/bash
###################################
echo "######## Section 1: delimiter ########"
#Use "/" as a delimiter
echo "/usr/local/bin" | sed 's/\/usr\/local\/bin/\/common\/sbin/'
#Use ":" as a delimiter
echo "/usr/local/bin" | sed 's:/usr/local/bin:/common/sbin:'

###################################
echo "######## Section 2: Using & as the matched string ########"
echo "abc 123 def" | sed 's/[a-z]*/(&)/g'
echo "abc 123 def" | sed 's/[a-z][a-z]*/(&)/g'
echo "123 abc" | sed 's/[0-9]*/& &/'
echo "abc 123" | sed 's/[0-9]*/& &/' #Noticed this line
echo "abc 123" | sed 's/[0-9][0-9]*/& &/'
echo "123 abc" | sed 's/[0-9]+/& &/' #Not be supported except GNU sed

###################################
echo "######## Using \1 to keep part of the pattern ########"
echo abcd123 | sed 's:\([a-z]*\).*:\1:'
echo abc def | sed 's:\([a-z]*\) \([a-z]*\):\2 \1:'
echo abc def | sed 's:\([a-z][a-z]*\) \([a-z][a-z]*\):\2 \1:'
echo abc def | sed 's:\([a-z]*\) \1:\1:' #No effect
echo abc abc | sed 's:\([a-z]*\) \1:\1:' #Eliminate duplicated words
echo abc abc | sed -n '/\([a-z][a-z]*\) \1/p'
echo "abc def" | sed 's:^\(.\)\(.\)\(.\):\3\2\1:' #Reverse the first three characters

###################################
echo "######## Substitute Flags########"
echo "######## /g - Global replacement########"
echo abc def | sed 's/[^ ]*/(&)/'
echo '' | sed 's/[^ ]*/(&)/'
echo abc def | sed 's/[^ ][^ ]*/(&)/g'

###################################
echo "######## /1, /2, etc. Specifying which occurrence########"
echo abc def ghi| sed 's/\([a-zA-Z]*\) \([a-zA-Z]*\)/\1 /'
echo abc def ghi| sed 's/[a-zA-Z]* //2'
echo 'abc def ghi '| sed 's/[a-zA-Z]* /DELETED /2g'
echo 'abc def ghi '| sed 's/[^ ]*//2'
echo 'abcdefghijklmn' | sed 's/./&:/10'

###################################
echo "######## /p - print########"
sed -n 's/pattern/&/p' < pattern_test.txt #Duplicate the function of grep

###################################
echo "######## Write to a file with /w filename########"
sed -n 's/a/A/2pw new1.txt' <old1.txt >new1.txt | cat new1.txt


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
#read value
value=3
sed 's/XXX/'$value'/' <<EOF
The value is XXX
EOF

###################################
echo "######## Restriction command########"
echo "######## Restricting to a line number########"
sed '3 s/[0-9][0-9]*//' < restriction1.txt
echo "######## Patterns ########"
sed '/^#/ s/[0-9][0-9]*//' < restriction1.txt
sed '\,^#, s/[0-9][0-9]*//' < restriction1.txt
echo "The file is in /usr/local/bin" | sed '/\/usr\/local\/bin/ s/\/usr\/local/\/common\/all/'
echo "The file is in /usr/local/bin" | sed '\_/usr/local/bin_ s_/usr/local_/common/all_'
sed '/^g/s/g/s/g' < restriction1.txt
sed '/^g/ s_g_s_g' < restriction1.txt
echo "######## Ranges by line number########"
sed '1,3 s/a/A/g' < restriction1.txt
sed '3,$ s/a/A/g' < restriction1.txt
sed '3,$ s/a/A/g' restriction1.txt pattern_test.txt
cat restriction1.txt pattern_test.txt | sed '3,$ s/a/A/g'
echo "######## Ranges by patterns########"
sed '/start/,/stop/ s/#.*//' < restriction2.txt
sed '1,/start/ s/#.*//' < restriction2.txt
sed -e '1,/start/ s/#.*//' -e '/stop/,$ s/#.*//' < restriction2.txt
###################################
echo "######## Delete with d########"
sed '3,$ d' < restriction2.txt
sed '1,/^$/ d' < restriction2.txt
echo "----------sed tail----------"
./sed_tail.sh restriction2.txt
echo "----------Delete all the lines that start with a \"#\"----------"
sed '/^#/ d' < restriction2.txt
echo "----------Delete comments and blank lines----------"
sed -e '/^#/ d' -e '/^$/ d' < restriction2.txt
echo "----------Delete comments and blank lines and tabs immediately before the end of line----------"
sed -e '/^#/ d' -e '/^$/ d' -e 's/[ ^I]*$//'  < restriction2.txt
###################################
echo "######## Printing with p########"
echo "----------Double every empty line----------"
sed '/^$/ p' < restriction2.txt
echo "----------head 10 lines----------"
sed -n '1,10 p' < restriction2.txt
echo "----------sed like grep----------"
sed -n '/start/ p' < restriction2.txt
###################################
echo "######## Reversing the restriction with !########"
sed -n '/start/ !p' < restriction2.txt
###################################
echo "######## The q or quit command########"
###################################
echo "######## Grouping with { and }########"
echo "---remove all the comment and empty lines between /start/, /stop/ in file restriction2.txt---"
sed -n '
	/start/, /stop/ {
		s/#.*//
		/^$/ d
		p
	}
' < restriction2.txt
echo "---remove all the comment and empty lines between /start/, /stop/ in the first 10 lines of file restriction2.txt---"
sed -n '1, 10 {
		/start/, /stop/ {
			s/#.*//
			/^$/ d
			p
		}
	}
' < restriction2.txt
###################################
echo "######## Writing a file with the 'w' command########"
sed -n 's/^[0-9]*[02468] /&/w even' < t0.txt | cat even
###################################
echo "######## Reading in a file with the 'r' command########"
echo "---append the file \"t0.txt\" at the end of file \"restriction2.txt\"---"
sed '$r t0.txt' < restriction2.txt
echo "---append the file \"t0.txt\" after the line which matches /start/ in file \"restriction2.txt\"---"
sed '/start/ r t0.txt' < restriction2.txt
echo "---delete the matched line and append the file \"t0.txt\" after the line which matches /start/ in file \"restriction2.txt\"---"
sed '/start/ {
	r t0.txt
	d
}' < restriction2.txt
echo '---include the specified file f1---'
./sed_include1.sh f1 < include1.txt
echo '---include the specified file f2---'
./sed_include1.sh f2 < include1.txt
###################################
echo "######## SunOS and the # Comment Command########"
###################################
echo "######## Adding, Changing, Inserting new lines########"
echo "######## Append a line with \'a\'########"
sed '/start/ a\
Add this line after every line with start' < restriction2.txt
echo "######## Insert a line with \'i\'########"
sed '/start/ i\
Add this line before every line with start' < restriction2.txt
echo "######## Change a line with \'c\'########"
sed '/start/ c\
Replace the current line with the line' < restriction2.txt
echo "---Combine \'a\',\'i\',\'c\' together---"
sed '
/start/ {
i\
Add the line before /start/
a\
Add the line after /start/
c\
Change the line to this one 
}' < restriction2.txt
###################################
echo "######## Leading tabs and spaces in a sed script########"
sed '/start/ a\
	Add this line after every line with start' < restriction2.txt
echo "---This line is the same as the above line in ubuntu---"
sed '/start/ a\
\	Add this line after every line with start' < restriction2.txt
###################################
echo "######## Address ranges and the above commands########"
sed '
/start/, /stop/ c\
***DELETED***
' < restriction2.txt
echo "---add a blank line after every line---"
sed '1,$ {
a\

}' < restriction2.txt
###################################
echo "######## Multi-Line Patterns########"
echo "--- Print line number with =---"
sed -n '/start/ =' restriction2.txt
echo "--- Print the number of lines with a file=---"
sed -n '$=' restriction2.txt
echo "--- Print the line number of lines which are between /start/ and /stop/---"
sed -n '/start/, /stop/ {
=
d
}' restriction2.txt
echo "######## Transform with y########"
sed 'y/abcdef/ABCDEF/' restriction2.txt
echo "0x9b8d 0x9b9d" | sed '/0x[0-9a-zA-Z]*/ y/abcdef/ABCDEF/'
echo "######## Working with Multiple Lines########"
echo "---search for a line that ended with \'#\' and append the next line to it---"
sed '
/#$/ {
	N
	s/#\n//
}
' restriction2.txt
echo "---search for two lines containing \'ONE\' and \'TWO\'---"
sed -n '
/ONE/ {
	N
	/\n.*TWO/ p 
}
' restriction2.txt
echo "---delete everything between /ONE/ and /TWO/---"
sed '
/ONE/ {
	N
	/\n.*TWO/ {
		s/ONE.*\n.*TWO/ONE TWO/
	}
}' restriction2.txt
echo "---search for a particular pattern on two consecutive lines---"
sed '
/ONE/ {
	N
	s/ONE TWO/TWO/
	s/ONE\nTWO/TWO/
}' restriction2.txt
echo "---use the \'D\' command to delete the first line if we find a line containing \'TWO\' immediately after a line containing \'ONE\'---"
sed '
/ONE/ {
	N
	/\n.*TWO/ D
}' restriction2.txt
echo "---print the first line, and not print every other line if we find a line containing \'TWO\' immediately after a line containing \'ONE\'---"
sed -n '
/ONE/ {
	N
	/\n.*TWO/ P 
}' restriction2.txt
echo "---Delete everything between \'ONE\' and \'TWO\' if they are on one or two consecutive lines---"
sed '
/ONE/ {
	N
	/ONE.*TWO/ {
		s/ONE.*TWO/ONE TWO/
		P
		D	
	}
}' restriction2.txt
echo "---add line numbers to a file by merging two lines"
sed '=' restriction2.txt | sed '{
	N
	s/\n/ /
}'
