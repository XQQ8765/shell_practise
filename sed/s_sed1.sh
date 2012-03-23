###################################
echo "######## Arguments and invocation of sed########"

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
