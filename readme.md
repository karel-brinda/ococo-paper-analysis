# Ococo paper analysis

This repository contains all scripts used for the analysis in
the Ococo paper

> Brinda K, Boeva V, Kucherov G. **Ococo: an online variant and consensus
> caller.** arXiv:1712.01146 [q-bio.GN], 2018. https://arxiv.org/abs/1712.01146

and in the [Code Ocean capsule](https://codeocean.com/2018/11/14/ococo-colon-an-online-variant-and-consensus-caller).


## Dependencies & Bioconda environment

```
conda install --yes \
      --channel bioconda \
      --channel conda-forge \
      --channel defaults \
      htslib==1.8 \
      ococo==0.1.2.6 \
      r-base==3.3.2 \
      r-data.table==1.10.4 \
      r-optparse==1.3.2 \
      rnftools==0.3.1.3 \
      samtools==1.7 \
      snakemake-minimal==5.3.0 \
      varscan==2.4.3
```

## Running the analysis

```
make -C 01*
make -C 02*
make -C 03*
make -C 04*
```
