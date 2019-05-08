#!/bin/bash
#
# Generate list of distinct source UUIDs used in SFM Nigeria Persons data 
#
# tl 2019-05-01

set -eu
shopt -s failglob

# Get numbered list of columns that have "Source" in the column heading

SCOL=$(csvcut -n input/ng_persons_20190501.csv \
	| grep -E "Source: " \
	| sed 's/\(^...\).*$/\1/g ; s/ //g' \
	| tr '\n' ',' \
	| sed 's/,$//g')

# Grab content of columns with sources (should be just semi-colon separated UUIDs)
# Flatten, sort and deduplicate

csvcut -c ${SCOL} input/ng_persons_20190501.csv \
	| sed '1d' \
	| tr ',' '\n' \
	| tr ';' '\n' \
	| sort -u \
	| sed '/^$/d' \
	| awk 'BEGIN {print "source_uuid"} ; {print}' \
	> output/source_uuids_ng_persons_20190501.csv
	
