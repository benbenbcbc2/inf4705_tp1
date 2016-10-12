#!/usr/bin/env python3

import argparse
import time

import tp
from context import algorithms
from algorithms.mergesort import MergeSort
from algorithms.bucketsort import BucketSort

# TODO
# add argument parsing
#  - where are the datafiles
#  - where to put the results
#  - one algorithm at a time maybe


def main():
    sizes = [1000, 5000, 10000, 50000, 100000, 500000]
    sets = [range(0,10), range(10, 20), range(20,30)]
    algorithms = [
        BucketSort(),
        BucketSort(tp.bucket_thresh, "bucketSeuil"),
        MergeSort(),
        MergeSort(tp.merge_thresh, "mergeSeuil"),
    ]

    for algorithm in algorithms:
        data = open(algorithm.name + ".dat", 'w')
        print("Making " + algorithm.name + ".dat")
        for size in sizes :
            data.write(str(size) + "\t")
            for subset in sets :
                total = 0
                for series in subset :
                    filename = "testset_{}_{}.txt".format(size, series)
                    with open(filename, 'r') as testset:
                        items = [int(l) for l in testset]
                    timed, _ = tp.time_algo(algorithm, items,
                                            amortization)
                    total += timed
                average = total / len(subset)
                data.write("%.20f\t" % average)
            data.write('\n')
        data.close()

if __name__ == "__main__":
    main()
