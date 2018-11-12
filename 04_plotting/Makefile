.PHONY: all help clean cleanall view

SHELL=/usr/bin/env bash -eo pipefail

.SECONDARY:

.SUFFIXES:

D1=../01_prepare_data
D2=../02_online_calling
D3=../03_time_comparison

VPATH = $(D1):$(D2):$(D3)
SUMMARIES=$(wildcard $(D3)/*.summary.tsv)

$(info $(SUMMARIES))

T1=$(notdir $(patsubst %.summary.tsv, %.1.pdf, $(SUMMARIES)))
T2=$(notdir $(patsubst %.summary.tsv, %.2.pdf, $(SUMMARIES)))

$(info $(T1))
$(info $(T2))

all: $(T1) $(T2)

%.1.pdf: %.stats.tsv
	./plot_online_calling.R $< $@ $$(cat ../01_data_preparation/$*.fa.fai | cut -f 2)

%.2.pdf: %.summary.tsv
	./plot_time.R $< $@

help: ## Print help message
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s : | sort)"

clean: ## Clean
	rm -f *.pdf

cleanall: clean ## Clean all

view:
	open *.pdf

