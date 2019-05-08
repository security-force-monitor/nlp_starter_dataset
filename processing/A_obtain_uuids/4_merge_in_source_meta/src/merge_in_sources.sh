#!/bin/bash
#
# Merge source metadata in

# Script safety

set -eu
shopt -s failglob

# inner join on sources filtered out
# Disable sniffing and type inference on csvjoin to avoid dumb errors

csvformat -t input/ng_persons_match_20190501.tsv \
	| csvjoin --snifflimit=0 -I -c 1 - input/sources_20190501.csv \
	> output/ng_info_rich_sources.csv

# Create list of unique uuids in use (technically these are called access points)

csvformat -t input/ng_persons_match_20190501.tsv \
	| csvjoin --snifflimit=0 -I -c 1 - input/sources_20190501.csv \
	| csvcut -C 2,3,4,5,6,7,8 \
	| sed '1d' \
	| sort -u \
	| awk 'BEGIN {print "source,title,page,published_on,access_date,source_url,archive_url,archive_timestamp,source_id,alias_source_id,country,key,publication_title,new_pub_id"} ; {print}' \
	> output/access_points_uuids.csv

# Create list of actual distinct documents ("sources")
# Grouped by key (country, publication)

csvformat -t input/ng_persons_match_20190501.tsv \
	| csvjoin --snifflimit=0 -I -c 1 - input/sources_20190501.csv \
	| csvcut -C  1,2,3,4,5,6,7,8,12,16,17 \
	| sed '1d' \
	| sort -u \
	| awk 'BEGIN {print "title,page,published_on,source_url,archive_url,archive_timestamp,country,key,publication_title,new_pub_id"} ; {print}' \
	| csvsort --snifflimit=0 -I -c 8 \
	> output/sources_by_titles.csv


