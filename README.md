# Ococo: an online variant and consensus caller

This Code Ocean capsule contains data and code for reproducing the results
section of the manuscript [Ococo: an online variant and consensus
caller](https://arxiv.org/abs/1712.01146). For more information, see [Ococo on
Github](https://github.com/karel-brinda/ococo).

### Citation

> Břinda K, Boeva V, Kucherov G. **Ococo: an online variant and
> consensus caller**.
> arXiv:[1712.01146v2](https://arxiv.org/abs/1712.01146v2) \[q-bio.GN\], 2018.


## Abstract

**Motivation:** Identifying genomic variants is an essential step for
connecting genotype and phenotype. The usual approach consists of statistical
inference of variants from alignments of sequencing reads. State-of-the-art
variant callers can resolve a wide range of different variant types with high
accuracy. However, they require that all read alignments be available from the
beginning of variant calling and be sorted by coordinates. Sorting is
computationally expensive, both memory- and speed-wise, and the resulting
pipelines suffer from storing and retrieving large alignments files from
external memory. Therefore, there is interest in developing methods for
resource-efficient variant calling.

**Results:** We present Ococo, the first program capable of inferring variants
in a real-time, as read alignments are fed in. Ococo inputs unsorted alignments
from a stream and infers single-nucleotide variants, together with a genomic
consensus, using statistics stored in compact several-bit counters. Ococo
provides a fast and memory-efficient alternative to the usual variant calling.
It is particularly advantageous when reads are sequenced or mapped
progressively, or when available computational resources are at a premium.


## Code

The Code directory (`/code`) is structured in the following way:

* `01_data_preparation` – collecting and indexing reference sequences
* `02_online_calling` – experiment: online calling as a function of time (for
  Sup Figs a) )
* `03_time_comparison` - experiment: speed comparison (for Sup Figs b) )
* `04_plotting` - plotting


## Data

The Data directory (`/data`) contains the reference sequences used for
evaluating Ococo, namely:

* `Chlamydia_trachomatis.fa` - Chlamydia Trachomatis (1.046Mbp)
* `chr17.fa` – human chromosome 17 (78,775Mbp)


## Running the Code Ocean pipeline

The [run.sh](run.sh) script contains all the required steps. It first adds the
execution flag to all scripts in the code directory and then it invokes
individual pipelines (01-04).


## Results

The Results directory (`/results`) contains the supplementary plots and all the
data for reproducing them.

### Output files

#### Sup Figs a)

* `*.1.pdf` - Online variant calling as a function of time.
* `*.stats.tsv` - Number of updates, edit distance (#substitutions + total
  length of indels) as a function of the number of processed alignments.

#### Sup Figs b)

* `*.2.pdf` – Speed comparison.
* `*.summary.tsv` - Mean times of individual steps of the pipelines.
* `benchmarks/` – Raw Snakemake benchmark data.

**Note:** The time measurements from the Code Ocean cloud environment are even
more favorable for Ococo than the ones presented in the paper (measured on an
iMac).


## License

[MIT](LICENSE).


## Contact

[Karel Břinda](https://scholar.harvard.edu/brinda) (kbrinda@hsph.harvard.edu)

