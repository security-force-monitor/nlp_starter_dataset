#!/bin/bash
#
# Pull out distinct unit names from SFM dataset on Nigeria
#
# tl@sfm 2019-10-24

# Safety and debug
set -eu
shopt -s failglob

# Get list, keep unit:name and unit:other_names distinct

csvcut -t -c 5,8 input/ng_orgs_20191024.tsv \
	| sed 1d \
	| sort -u \
	| csvformat -T \
	| awk 'BEGIN {print "unit:name\tunit:other_names"};{print}' \
	> output/ng_unit_names_distinct_20191024.tsv

# Get list, collapse unit:name and unit:other_names into single list
# clean out some whitespace, doubling of characters resulting from collapse of cols

csvcut -t -c 5,8 input/ng_orgs_20191024.tsv \
	| csvformat -T \
	| sed 1d \
	| tr ';' '\t' \
	| tr '\t' '\n' \
	| sort -u \
	| sed 's/^ \{1,10\}//g; s/ \{1,10\}$//g ; s/""/"/g ; s/"$//g ; s/^"//g' \
	| sort -u \
	| grep -v "^$" \
	| awk 'BEGIN {print "unit:name_and_other_names"} ; {print}' \
	> output/ng_unit_names_and_other_names_collapsed_20191024.tsv

	
