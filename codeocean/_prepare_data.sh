#! /usr/bin/env bash

set -e
set -o pipefail
set -u

make -C ../01_data_preparation clean
make -C ../01_data_preparation

rm -fr _data
mkdir _data
cp ../01_data_preparation/*.fa _data

