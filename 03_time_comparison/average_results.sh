#! /usr/bin/env bash

set -e
set -o pipefail
set -u

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(dirname $0)
readonly -a ARGS=("$@")
readonly NARGS="$#"

if [[ $NARGS -eq 0 ]]; then
	>&2 echo "usage: $PROGNAME mask"
	exit 1
fi


for x in $@; do
	y=${x##*/}
	z=$(echo "$y"| perl -pe 's/.*\.(.*)\.log/\1/g')
	printf "$z\t"
	cat "$x" \
		| grep -v max \
		| awk '{ sum += $1; n++ } END { if (n > 0) printf "%0.2f\n", sum / n; }'
done
