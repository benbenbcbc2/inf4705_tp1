#!/usr/bin/env python3

import argparse
from collections import OrderedDict

from context import algorithms
from algorithms.mergesort import MergeSort
from algorithms.bucketsort import BucketSort
from algorithms.algorithm import InsertionSort, PythonSort
from algorithms.timing import time_algo
from algorithms.threshold import get_threshold_config

bucket_thresh = get_threshold_config("bucketsort")
merge_thresh = get_threshold_config("mergesort")

algorithms = [
    BucketSort(),
    BucketSort(bucket_thresh, "bucketSeuil"),
    MergeSort(),
    MergeSort(merge_thresh, "mergeSeuil"),
    InsertionSort(),
    PythonSort(),
]

algomap = OrderedDict((a.get_name(), a) for a in algorithms)

parser = argparse.ArgumentParser(
    description="Start and time sorting algorithms for the lab")
parser.add_argument("--algorithm", "-a", choices=algomap.keys(),
                    required=True)
parser.add_argument("--ex_path", "-e", type=argparse.FileType('r'),
                    required=True,
                    help="the file containing the numbers to sort")
parser.add_argument("--print", "-p", action='store_true',
                    help="print the sorted list")
parser.add_argument("--time", "-t", action='store_true',
                    help="show the mean time of execution")
parser.add_argument("--amortize", "-m", type=int, default=1,
                    metavar="N",
                    help="amortize the timing overhead over N" \
                    " executions")

def main():
    args = parser.parse_args()

    algo = algomap[args.algorithm]
    with args.ex_path as f:
        items = [int(l) for l in f]

    average, sorted_items = time_algo(algo, items, args.amortize)

    if args.time:
        print("Mean time: {} seconds".format(average))

    if args.print:
        print(sorted_items)

if __name__ == "__main__":
    main()
