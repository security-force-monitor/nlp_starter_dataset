#!/bin/bash
#
# Deep clean: simple, common clean-up steps
#
# tl 2019-05-03


# Cleans up:
# - pound signs
# - escaped brackets
# - consecutive, leading and trailing spaces
# - rows with only spaces
# - turn consecutive empty rows to single empty row

while read -r f ; do
	cat in/${f} \
	| sed -e '{
			s/#//g
			s/\\(/(/g
			s/\\)/)/g
			s/ \{2,\}/ /g
			s/ $//g
			s/^ //g
			s/^ \{1,\}$//g
		}' \
	| perl -00pe 's/^$\n^$\n/\n/g' \
	> out/deep_${f}

	done < filelist
		
