#!/usr/bin/env python3

import argparse, os

from context import algorithms
from algorithms.mergesort import MergeSort
from algorithms.bucketsort import BucketSort
from algorithms.timing import time_algo
from algorithms.threshold import *

algorithms = [
    BucketSort(),
    MergeSort(),
]

parser = argparse.ArgumentParser(
    description="Gather data on thresholds for the lab")
parser.add_argument("--results_dir", "-r", default="results",
                    help="the directory containing the results")
parser.add_argument("--amortize", "-m", type=int, default=1,
                    metavar="N",
                    help="amortize the timing overhead over N" \
                    " executions")

def main():
    args = parser.parse_args()
    
    if not os.path.isdir(args.results_dir):
        parser.print_usage()
        exit(1)

    for algo in algorithms:
        timings = ((i, timing_for_threshold(algo, i, loops=100,
                                            amort=args.amortize))
                   for i in range(300))
        outname = "threshold_{}.dat".format(algo.get_name())
        outname = os.path.join(args.results_dir, outname)
        with open(outname, "w") as out:
            for i, t in timings:
                print(i, t, sep='\t', file=out)


if __name__ == "__main__":
    main()
