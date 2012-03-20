#!/bin/bash
awk '{
	if (NR < 17) {
		if (NR==1) {
			print "------------------------------------------------------------"
			print "Follwing fields are missing in \"HitQueryModel\":\n"
		}
		print $0;
	} else if (NR >= 18){
		FS="|"
		gsub("\t", " ")
		if (NR == 18) {
			print "------------------------------------------------------------"
			print "Follwing fields are existing in \"HitQueryModel\":"
			printf "||%-30s||%-30s||%-30s\n",$1,$2,$3
		}
		else {
			printf "|%-30s|%-30s|%-30s\n",$1,$2,$3
		}
			
	}
}' ./search_hits_match_condition.txt > ./wiki_search_hits_match_condition.txt
cat ./wiki_search_hits_match_condition.txt
