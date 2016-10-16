#!/usr/bin/env python3

import argparse, os

from context import algorithms
from algorithms.threshold import get_config, get_threshold_config

parser = argparse.ArgumentParser(
    description="Copy the thresholds used to results")
parser.add_argument("--results_dir", "-r", default="results",
                    help="the directory containing the results")

def main():
    args = parser.parse_args()

    if not os.path.isdir(args.results_dir):
        parser.print_usage()
        exit(1)

    config = get_config()

    outname = "thresholds.csv"
    outname = os.path.join(args.results_dir, outname)
    with open(outname, "w") as out:
        print("algorithme,seuil", file=out)
        sections = config.sections()
        if not sections:
            print("Warning: no threshold data. Using defaults.")
            sections = ["bucket", "merge"]
        for key in sections:
            print(key, get_threshold_config(key), sep=',', file=out)

if __name__ == "__main__":
    main()
