#!/bin/bash

set -o verbose


#
# STEP 00
#

find /code -name '*.py' -or -name '*.sh' -or -name '*.R' | xargs chmod +x


#
# STEP 01
#

(
    cd 01_*
    for x in /data/*.fa; do
        ln -s "$x"
    done

    for x in *.fa; do
        touch "$x.complete"
    done


    make

    ls -alh * .*
)


#
# STEP 02
#

(
    cd 02_*
    for x in ../01*/*.fa; do
        ln -s $x
    done

    make
    cp *.stats.tsv /results

    ls -alh * .*
)


#
# STEP 03
#

(
    cd 03_*

    for x in ../01*/*.fa; do
        ln -s $x
    done

    for x in ../02*/*.sam; do
        ln -s $x
    done

    make

    cp *.summary.tsv /results

    mkdir -p /results/benchmarks
    cp benchmarks/* /results/benchmarks

    ls -alh * .*
)


#
# STEP 04
#

(
    cd 04_*

    make

    cp *.pdf /results

    ls -alh * .*
)

