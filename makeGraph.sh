#!/bin/bash
python3 ./graphMaker.py
gnuplot -persist <<-EOFMarker
    set term png
    set output "bucket.png"
    set logscale xy
    plot "bucket.dat" using 1:2 title '1-9' with linespoints, "bucket.dat" using 1:3 title '10-19' with linespoints, "bucket.dat" using 1:4 title '20-29' with linespoints
    set output "bucketSeuil.png"
    plot "bucketSeuil.dat" using 1:2 title '1-9' with linespoints, "bucketSeuil.dat" using 1:3 title '10-19' with linespoints, "bucketSeuil.dat" using 1:4 title '20-29' with linespoints
    set output "merge.png"
    plot "merge.dat" using 1:2 title '1-9' with linespoints, "merge.dat" using 1:3 title '10-19' with linespoints, "merge.dat" using 1:4 title '20-29' with linespoints
    set output "mergeSeuil.png"
    plot "mergeSeuil.dat" using 1:2 title '1-9' with linespoints, "mergeSeuil.dat" using 1:3 title '10-19' with linespoints, "mergeSeuil.dat" using 1:4 title '20-29' with linespoints
    exit
EOFMarker