#!/bin/bash
#
# Simple automated text cleanup step



sed -E '{
		s/#//g
		s/\(/(/g
		s/\)/)/g
		s/ {2,}/ /g
		s/\(/(/g
		s/ $//g
		s/^ //g
	}'
		
