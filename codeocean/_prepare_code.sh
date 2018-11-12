#! /usr/bin/env bash

set -e
set -o pipefail
set -u

rm -fr _code
mkdir _code

cp -av ../??_* _code

make -C _code/01_* clean
make -C _code/02_* clean
make -C _code/03_* clean
make -C _code/04_* clean

cp run.sh ../LICENSE README.md _code

find _code -name '.gitignore' | xargs rm
