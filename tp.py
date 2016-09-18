#!/usr/bin/env python3

import argparse
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

algomap = {a.get_name(): a for a in algorithms}

parser = argparse.ArgumentParser(
    description="Lancer et chronométrer les algorithmes du lab")
parser.add_argument("--algorithme", "-a", choices=algomap.keys(),
                    required=True)
parser.add_argument("--exemplaire", "-e", type=argparse.FileType('r'),
                    required=True,
                    help="Le fichier contenant les nombres à trier.")
parser.add_argument("--print", "-p", action='store_true',
                    help="Afficher les nombres triés.")
parser.add_argument("--temps", "-t", action='store_true',
                    help="Afficher le temps chronométré.")
parser.add_argument("--amortissement", "-m", type=int, default=1,
                    metavar="N",
                    help="Amortir le surcoût de chronométrage sur N" \
                    " exécutions.")

def main():
    args = parser.parse_args()

    with args.exemplaire as f:
        items = [int(l) for l in f]

    start = time.process_time()
    for i in range(args.amortissement):
        sorted_items = algomap[args.algorithme].sort_fast(items)
    stop = time.process_time()

    elapsed = stop - start
    average = elapsed / args.amortissement

    if args.temps:
        print("Temps moyen: {} secondes".format(average))

    if args.print:
        print(sorted_items)

if __name__ == "__main__":
    main()
