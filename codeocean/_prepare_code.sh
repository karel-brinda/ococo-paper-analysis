#! /usr/bin/env bash

set -e
set -o pipefail
set -u

rm -fr _code
mkdir _code

make -C ../01* clean
make -C ../02* clean
make -C ../03* clean
make -C ../04* clean

cp -av ../??_* _code

cp run.sh ../LICENSE README.md _code

find _code -name '.gitignore' | xargs rm
