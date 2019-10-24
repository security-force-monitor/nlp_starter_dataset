#!/bin/bash
#
# Pull down list of unique Nigeria units in US Department of Stat Training data
#
# tl@sfm 2019-10-24

uet -eu
shopt -s failglob

# grab data from SFM's database
# curl to output file

curl -o output/dos_fmtrpt_nigeria_units.tsv "https://trainingdata.securityforcemonitor.org/state-department-data.csv?sql=select++distinct%28student_unit%29+from+training_data+where+%22iso_3166_1%22+%3D+%3Ap0+order+by+student_unit+ASC&p0=NGA&_size=max"
