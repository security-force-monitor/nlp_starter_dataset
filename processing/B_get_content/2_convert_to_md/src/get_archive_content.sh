#!/bin/bash
#
# Turn material from Internet Archive from HTML to Markdown text
#
# tl 2019-05-02

# script safety measures (fail at first fail, don't expand unset variables)

set -eu
shopt -s failglob

# Set locale

LC_CTYPE=en_US.utf8

# Using the same uuid list from the pervious step
# Convert from HTML to markdown using html2text
# various settings reduce the clutter we'll later have to remove
# e.g. ignore links, formatting, images

while read -r f u; do

	html2text	-b 0 \
			--ignore-tables \
			--ignore-emphasis \
			--unicode-snob \
			--decode-errors=ignore \
			--escape-all \
			--ignore-links \
			--reference-links \
			--ignore-images \
			input/$f.html > output/2text_$f.md

	done < src/archive_urls
