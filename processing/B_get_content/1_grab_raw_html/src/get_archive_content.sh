#!/bin/bash
#
# Retrieve content from Internet Archive

# Get uuid and url lists

# Set locale

LC_CTYPE=en_US.utf8

# loopy loop

while read -r f u; do

	echo "Processing ${f}"

	curl -L --url ${u} --output output/$f.html

	done < src/archive_urls
