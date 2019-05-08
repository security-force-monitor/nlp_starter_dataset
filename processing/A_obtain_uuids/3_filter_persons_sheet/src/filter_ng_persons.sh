#!/bin/bash
#
# Find data rich sources where
# UUID is used to evidence name or alias, then all of org, role, title, rank
#
# tl 2019-05-01

# Script safety

set -eu
shopt -s failglob

# Set up tab-separated output file

awk 'BEGIN {FS=OFS="\t"; print "source\tmatched_on\tperson:name\tperson:alias\tperson:org\tperson:role\tperson:title\tperson:rank" }' > output/ng_persons_match_20190501.tsv


# Main loop
# Check each uuid against name and four subsequent biographical values
# Check each uuid against alias and four subsequent biographical values
# Append data of matches to output file, flagging the type of match (name, alias)

while read -r uuid; do

echo "Checking source ${uuid} for matches"
	
awk -v uuid="${uuid}" \
	'BEGIN {FS=OFS="\t" } \
	{if ( \
		$2 ~ uuid && \
		$6 ~ uuid && \
		$8 ~ uuid && \
		$10 ~ uuid && \
		$12 ~ uuid ) \
		print uuid"\tname\t"$1"\t"$3"\t"$5"\t"$7"\t"$9"\t"$11 \
	}' input/ng_persons_simple_20190501.tsv \
	>> output/ng_persons_match_20190501.tsv 

awk -v uuid="${uuid}" \
	'BEGIN {FS=OFS="\t" } \
	{if ( \
		$4 ~ uuid && \
		$6 ~ uuid && \
		$8 ~ uuid && \
		$10 ~ uuid && \
		$12 ~ uuid ) \
		print uuid"\talias\t"$1"\t"$3"\t"$5"\t"$7"\t"$9"\t"$11 \
	}' input/ng_persons_simple_20190501.tsv \
	>> output/ng_persons_match_20190501.tsv 
	
		done < src/uuids


# To do
# tlongers: could  probably refactor the awk conditionals to avoid making two runs

# Some reference stuff: keep in until we're done

#  1: Name
#  2: Source: Name
#  3: Aliases or alternative spellings (semi-colon separated)
#  4: Source: Aliases or alternative spellings
#  5: Organization
#  6: Source: Organization
#  7: Role
#  8: Source: Role
#  9: Title (official title)
# 10: Source: Title
# 11: Rank
# 12: Source: Rank
#

