#!/usr/bin/env python3

import argparse
from collections import OrderedDict
import time

from mergesort import *
from bucketsort import *

algorithms = [
    Bucketsort(),
    Bucketsort(10, "bucketSeuil"),
    Mergesort(),
    Mergesort(10, "mergeSeuil"),
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

    start = time.process_time()
    for i in range(args.amortize):
        sorted_items = algo.sort_fast(items)
    stop = time.process_time()

    elapsed = stop - start
    average = elapsed / args.amortize

    if args.time:
        print("Mean time: {} seconds".format(average))

    if args.print:
        print(sorted_items)

if __name__ == "__main__":
    main()
