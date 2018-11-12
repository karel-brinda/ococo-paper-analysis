#! /usr/bin/env bash

set -e

#############
#############

s=Chlamydia_trachomatis.stats.tsv
d=Chlamydia_trachomatis.stats_extracted.tsv

printf '' > $d
head -n 2 $s >> $d
cat $s | grep -E '^5\d{4}' | head -n 1 >> $d
cat $s | tail -n 1 >> $d

#############
#############

s=chr17.stats.tsv
d=chr17.stats_extracted.tsv

printf '' > $d
head -n 2 $s >> $d
cat $s | grep -E '^375\d{4}'| head -n 1 >> $d
cat $s | tail -n 1 >> $d

#############
#############

