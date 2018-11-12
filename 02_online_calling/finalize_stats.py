#! /usr/bin/env python3

import argparse
import collections
import os
import re
import sys

def load_cumul(cumul):
    """
    upd -> aln
    """
    cumul_d={}
    last_u=-1
    for x in cumul:
        if len(x)==0 or x[0]=="#":
            continue
        aln, upd=map(int, x.strip().split("\t"))
        if upd>last_u:
            cumul_d[upd]=aln
            last_u=upd
    cumul_d[upd+0.001]=aln
    return cumul_d

def load_ed(ed):
    """
    upd -> ed
    """
    d_dels={}
    d_ins={}
    d_muts={}
    d_ed={}
    for x in ed:
        if len(x)==0 or x[0]=="#":
            continue
        upd, dels, ins, muts, ed=map(int, x.strip().split("\t"))
        d_dels[upd]=dels
        d_ins[upd]=ins
        d_muts[upd]=muts
        d_ed[upd]=ed

    d_dels[upd+0.001]=dels
    d_ins[upd+0.001]=ins
    d_muts[upd+0.001]=muts
    d_ed[upd+0.001]=ed

    return d_dels, d_ins, d_muts, d_ed

def create_stats(ed, cumul):
    d, i, m, e = load_ed(ed)
    c = load_cumul(cumul)


    print("aln", "upd", "dels", "ins", "muts", "ed_dist", sep="\t")
    for j in sorted(e.keys()):
        try:
            print(c[j], int(j), d[j], i[j], m[j], e[j], sep="\t")
        except KeyError:
            pass


def main():
    parser = argparse.ArgumentParser(description="")

    parser.add_argument(
        'ed',
        type=argparse.FileType('r'),
        metavar='edit_dist.tsv',
        help='',
    )

    parser.add_argument(
        'cumul',
        type=argparse.FileType('r'),
        metavar='ococo_log_cumul.tsv',
        help='',
    )

    args = parser.parse_args()

    create_stats(args.ed, args.cumul)


if __name__ == "__main__":
    main()
