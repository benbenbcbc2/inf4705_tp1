#!/usr/bin/env python3

import argparse
from collections import OrderedDict
import time

from mergesort import *
from bucketsort import *

def main():
    allNbOfNumbers = [1000, 5000, 10000, 50000, 100000, 500000]
    sets = [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9], [10, 11, 12, 13, 14, 15, 16, 17, 18, 19], [20, 21, 22, 23, 24, 25, 26, 27, 28, 29]]
    algorithms = [
        Bucketsort(),
        Bucketsort(10, "bucketSeuil"),
        Mergesort(),
        Mergesort(10, "mergeSeuil"),
    ]

    for algorithm in algorithms:
        data = open(algorithm.name + ".dat", 'w')
        print("Making " + algorithm.name + ".dat")
        for nbOfNumbers in allNbOfNumbers :
            data.write(str(nbOfNumbers) + "\t")
            for subset in sets :
                elapsed = 0
                for set in subset :
                    testset = open("testset_" + str(nbOfNumbers) + '_' + str(set) + ".txt", 'r')
                    items = [int(l) for l in testset]
                    start = time.process_time()
                    sorted_items = algorithm.sort_fast(items)
                    stop = time.process_time()
                    elapsed += stop - start
                average = elapsed / len(subset)
                data.write("%.20f\t" % average)
            data.write('\n')
        data.close()

if __name__ == "__main__":
    main()
