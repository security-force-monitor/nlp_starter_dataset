#!/bin/bash
#
# Make list of URLs to grab 

# Get uuid and url lists

csvcut -c 1,14 input/ng_info_rich_sources.csv \
	| csvgrep -c 2 -i -r "^$" \
	| csvgrep -c 2 -i -r "No archive available" \
	| sed 1d \
	| sort -u \
	| grep -i -v ".pdf" \
	| sed 's/,/ /g' \
	> src/archive_urls
