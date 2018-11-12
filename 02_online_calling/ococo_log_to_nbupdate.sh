#! /usr/bin/env bash

set -e
set -o pipefail
set -u
#set -f

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(dirname $0)
readonly -a ARGS=("$@")
readonly NARGS="$#"

if [[ $NARGS -ne 1 ]]; then
	>&2 echo "usage: $PROGNAME ococo_log.txt"
	exit 1
fi

echo "#n_aln	n_upd"
cat "$1" \
	| uniq \
	| awk '{sum+=$3; print 1+$1, sum}' \
	| sed 's/\ /	/g'
