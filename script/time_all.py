#!/usr/bin/env python3

import argparse, os

from context import algorithms
from algorithms.mergesort import MergeSort
from algorithms.bucketsort import BucketSort
from algorithms.timing import time_algo
from algorithms.threshold import get_threshold_config

bucket_thresh = get_threshold_config("bucketsort")
merge_thresh = get_threshold_config("mergesort")

algorithms = [
    BucketSort(),
    BucketSort(bucket_thresh, "bucketSeuil"),
    MergeSort(),
    MergeSort(merge_thresh, "mergeSeuil"),
]

parser = argparse.ArgumentParser(
    description="Gather data for the lab")
parser.add_argument("--data_dir", "-d", required=True,
                    help="the directory containing the datasets")
parser.add_argument("--results_dir", "-r", default="results",
                    help="the directory containing the results")
parser.add_argument("--amortize", "-m", type=int, default=1,
                    metavar="N",
                    help="amortize the timing overhead over N" \
                    " executions")

def main():
    args = parser.parse_args()

    if not (os.path.isdir(args.data_dir) and
            os.path.isdir(args.results_dir)):
        parser.print_usage()
        exit(1)
    
    sizes = [1000, 5000, 10000, 50000, 100000, 500000]
    sets = [range(0,10), range(10, 20), range(20,30)]

    for algorithm in algorithms:
        result_name = "{}.dat".format(algorithm.get_name())
        result_name = os.path.join(args.results_dir, result_name)
        result = open(result_name, 'w')
        print("Making {}".format(result_name))
        result.write("# Taille [00-09]  \t[10-19]  \t[20-29]\n")
        for size in sizes :
            result.write(str(size) + "\t")
            for subset in sets :
                total = 0
                for series in subset :
                    data_name = "testset_{}_{}.txt".format(size, series)
                    data_name = os.path.join(args.data_dir, data_name)
                    print("Reading {}".format(data_name))
                    with open(data_name, 'r') as testset:
                        items = [int(l) for l in testset]
                    timed, _ = time_algo(algorithm, items,
                                         args.amortize)
                    total += timed
                average = total / len(subset)
                result.write("%.6f\t" % average)
            result.write('\n')
        result.close()

if __name__ == "__main__":
    main()
