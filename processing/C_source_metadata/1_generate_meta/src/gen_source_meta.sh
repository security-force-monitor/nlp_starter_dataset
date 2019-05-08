#!/bin/bash
#
# Generate metadata headers for sources used in NLP starter dataset
#
# TL 2019-05-07

# Script safety 

set -eu
shopt -s failglob

# Get uuid and url lists
# Output to tsv, which is much better to work with than csv
# Ensure there are no empty values, otherwise later processes fail

csvcut -C 2,3,4,5,6,7,8,10,12,15,16,17,19,21 input/ng_info_rich_sources.csv \
	| csvgrep -c 5 -i -r "^$" \
	| csvgrep -c 5 -i -r "No archive available" \
	| sed 1d \
	| sort -u \
	| grep -i -v ".pdf" \
	| csvformat -U 0 -T \
	| awk -F '\t' -v OFS='\t' '{if ($3 ~ "^$") $3 = "Not specified"; print $0 }' \
	> src/meta.tsv

# Generate metadata for each source
# Using read, set delimiter as tab, read content into array
# Echo sequential values of array into a line, appending to output file
# Name of output file is zero position of array, which is source uuid

while IFS=$'\t' read -r -a s; do
	
		echo "Source UUID: ${s[0]}" >> output/"${s[0]}_meta.txt"
		echo "Title: ${s[1]}" >> output/"${s[0]}_meta.txt"
		echo "Publication date: ${s[2]}" >> output/"${s[0]}_meta.txt"
		echo "Source URL: ${s[3]}" >> output/"${s[0]}_meta.txt"
		echo "Internet Archive URL: ${s[4]}" >> output/"${s[0]}_meta.txt"
		echo "Country: ${s[5]}" >> output/"${s[0]}_meta.txt"
		echo "Publication name: ${s[6]}" >> output/"${s[0]}_meta.txt"
	
	done < src/meta.tsv

# To Do

# 1. Encode output to TEI-C 1.0 if needed; it's fairly simple for now.
# 2. Add in a data when the metadata and file was generated (perhaps some kind of corpus versioning?)
