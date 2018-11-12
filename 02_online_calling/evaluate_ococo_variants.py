#! /usr/bin/env python3

import argparse
import collections
import os
import re
import sys


def message(*args):
    print(*args, file=sys.stderr)


def parse_vcf_line(x):
    if len(x) == 0 or x[0] == "#":
        return None
    parts = x.split("\t")
    p = int(parts[1])
    l = parts[3]
    r = parts[4]

    return p, l, r


def load_dwgsim_mutations(dwgsim):
    mutations = {}
    insertions = 0
    deletions = 0

    for x in dwgsim:
        y = parse_vcf_line(x)
        if y is None:
            continue
        p, l, r = y
        l_l = len(l)
        l_r = len(r)
        if l_l == l_r:
            mutations[p] = (l, r)
        elif l_l < l_r:
            insertions += l_r - l_l
        else:
            deletions += l_l - l_r
    return mutations, insertions, deletions


def evaluate_ococo(dwgsim, ococo):
    muts, ins_dist, del_dist = load_dwgsim_mutations(dwgsim)

    ref_edits = {}
    cor = set()
    incor = set()

    i = 0
    print("#upd id", "del dist", "ins dist", "mut dist", "edit dist", sep="\t")
    for x in ococo:
        assert len(
            ref_edits) == len(cor) + len(incor), f"{ref_edits} {cor} {incor}"
        y = parse_vcf_line(x)
        if y is None:
            continue
        i += 1
        p, l_, r_ = y

        ## 1) UPDATE edits

        # update of an update
        try:
            l0, r0 = ref_edits[p]
            assert r0 == l_, f"{l0}->{r0}, {l_}->{r_}"
            ref_edits[p] = l0, r_

        # new update
        except KeyError:
            ref_edits[p] = (l_, r_)

        try:
            cor.remove(p)
        except KeyError:
            pass

        try:
            incor.remove(p)
        except KeyError:
            pass

        ## 2) EVALUATE AND ASSIGN CORRECTNESS
        l, r = ref_edits[p]
        if l == r:
            del ref_edits[p]
        else:
            if p in muts:
                l_, r_ = muts[p]
                assert l == l_
                if r == r_:
                    # corect update
                    cor.add(p)
                else:
                    # incorect update
                    incor.add(p)
            else:
                # incorect update
                incor.add(p)

        mut_dist = len(muts) + len(incor) - len(cor)
        print(
            i,
            ins_dist,
            del_dist,
            mut_dist,
            ins_dist + del_dist + mut_dist,
            sep="\t")


def main():
    parser = argparse.ArgumentParser(description="")

    parser.add_argument(
        'dwgsim',
        type=argparse.FileType('r'),
        metavar='dwgsim.vcf',
        help='DWGSIM VCF file',
    )

    parser.add_argument(
        'ococo',
        type=argparse.FileType('r'),
        metavar='ococo.vcf',
        help='OCOCO VCF file',
    )

    args = parser.parse_args()

    evaluate_ococo(args.dwgsim, args.ococo)


if __name__ == "__main__":
    main()
