#!/bin/bash
#
# Filter NG person data by presence of same UUID as source for four attributes
#
# tl 2019-05-01

# script safety

set -eu
shopt -s failglob

# Pare down NG persons data to the following columns

#  5: Name
#  6: Source: Name
#  8: Aliases or alternative spellings (semi-colon separated)
#  9: Source: Aliases or alternative spellings
# 12: Organization
# 13: Source: Organization
# 15: Role
# 16: Source: Role
# 18: Title (official title)
# 19: Source: Title
# 21: Rank
# 22: Source: Rank


echo "Chopping down ng_persons_20190501.csv and turning it into a .tsv"

csvcut -c 5,6,8,9,12,13,15,16,18,19,21,22 input/ng_persons_20190501.csv \
	| csvformat -T \
	> output/ng_persons_simple_20190501.tsv

# Show quick count of lines in input and output files

echo "Input file line count:"
wc -l input/ng_persons_20190501.csv

echo "Output file line count:"
wc -l output/ng_persons_simple_20190501.tsv

echo "All done!"

