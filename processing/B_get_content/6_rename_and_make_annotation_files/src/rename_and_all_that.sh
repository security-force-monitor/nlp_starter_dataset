#!/bin/bash
#
# Rename source files and create .ann files for use in BRAT
#
# TL 2019-05-07

# Script safety

set -eu
shopt -s failglob

# Using the failname as input, set a variable to get just the UUID
# Strip off the leading matter and file extension
# Copy the file to a simplied filename
# Use touch to createa .ann files that are needed for BRAT's standoff format

while read -r f; do
		i="$(echo "${f}" | sed 's/^2text_//g ; s/\.md//g ')"
		cp input/${f} output/${i}.txt
		touch output/${i}.ann
	
	done < src/filelist
