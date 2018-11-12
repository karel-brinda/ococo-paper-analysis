.PHONY: all help clean cleanall

SHELL=/usr/bin/env bash -eo pipefail

.SECONDARY:

.SUFFIXES:

all: \
	chr17.fa.fai.complete \
	Chlamydia_trachomatis.fa.fai.complete


%.fai.complete: %.complete
	samtools faidx $*
	touch $@

chr17.fa.complete:
	curl http://hgdownload.cse.ucsc.edu/goldenpath/hg18/chromosomes/chr17.fa.gz \
		| gunzip -c - \
		> chr17.fa
	touch $@

Chlamydia_trachomatis.fa.complete:
	curl -L "http://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?tool=portal&sendto=on&log$=seqview&db=nuccore&dopt=fasta&val=NC_021897&extrafeat=0&maxplex=1" \
		> Chlamydia_trachomatis.fa
	touch $@

help: ## Print help message
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s : | sort)"

clean: ## Clean
	rm -f *.fa *.fai .*.complete *.complete

cleanall: clean ## Clean all

