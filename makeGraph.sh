#!/bin/bash

# First, let's run the algorithms
python3 ./graphMaker.py

# Delete last log files from the previous Gnuplot fit
rm -f bucket.log bucketSeuil.log merge.log mergeSeuil.log

# Open Gnuplot
gnuplot -persist <<-EOFMarker

    # Set the default parameters of the plots
    set term png
    set grid
    set xlabel "log(nombres à trier)"
    set ylabel "log(temps d'exécution)"
    set fit quiet
    set logscale xy
    f(x) = 10**b*x**m

    # Plot 1.1 : Bucket sort with threshold of 1, power test
    set title "Bucket sort avec seuil de 1 : test de puissance"
    set output "bucket_power.png"
    set fit logfile "bucket.log"
    fit f(x) 'bucket.dat' using 1:2 via m,b
    fit f(x) 'bucket.dat' using 1:3 via m,b
    fit f(x) 'bucket.dat' using 1:4 via m,b
    plot "bucket.dat" using 1:2 title '1-9' with linespoints, "bucket.dat" using 1:3 title '10-19' with linespoints, "bucket.dat" using 1:4 title '20-29' with linespoints

    # Plot 1.2.1 : Bucket sort with threshold of 1, ratio test, best case and average case
    set title "Bucket sort avec seuil de 1 : test du rapport avec f(x)=x"
    set output "bucket_ratio_bestCase_AvgCase.png"
    unset logscale y
    g(x) = x
    set ylabel "y/x"
    plot "bucket.dat" using 1:(\$2/g(\$1)) title '1-9' with linespoints, "bucket.dat" using 1:(\$3/g(\$1)) title '10-19' with linespoints, "bucket.dat" using 1:(\$4/g(\$1)) title '20-29' with linespoints

    # Plot 1.2.2 : Bucket sort with threshold of 1, ratio test, worst case
    set title "Bucket sort avec seuil de 1 : test du rapport avec f(x)=x^2"
    set output "bucket_ratio_worstCase.png"
    g(x) = x**2
    set ylabel "y/x^2"
    plot "bucket.dat" using 1:(\$2/g(\$1)) title '1-9' with linespoints, "bucket.dat" using 1:(\$3/g(\$1)) title '10-19' with linespoints, "bucket.dat" using 1:(\$4/g(\$1)) title '20-29' with linespoints

    set logscale y
    set ylabel "log(temps d'exécution)"

    # Plot 2.1 : Bucket sort with threshold of 10, power test
    set title "Bucket sort avec seuil de 10 : test de puissance"
    set output "bucketSeuil_power.png"
    set fit logfile "bucketSeuil.log"
    fit f(x) 'bucketSeuil.dat' using 1:2 via m,b
    fit f(x) 'bucketSeuil.dat' using 1:3 via m,b
    fit f(x) 'bucketSeuil.dat' using 1:4 via m,b
    plot "bucketSeuil.dat" using 1:2 title '1-9' with linespoints, "bucketSeuil.dat" using 1:3 title '10-19' with linespoints, "bucketSeuil.dat" using 1:4 title '20-29' with linespoints

    # Plot 2.2.1 : Bucket sort with threshold of 10, ratio test, best case and average case
    set title "Bucket sort avec seuil de 1 : test du rapport avec f(x)=x"
    set output "bucketSeuil_ratio_bestCase_AvgCase.png"
    unset logscale y
    g(x) = x
    set ylabel "y/x"
    plot "bucketSeuil.dat" using 1:(\$2/g(\$1)) title '1-9' with linespoints, "bucketSeuil.dat" using 1:(\$3/g(\$1)) title '10-19' with linespoints, "bucketSeuil.dat" using 1:(\$4/g(\$1)) title '20-29' with linespoints

    # Plot 2.2.2 : Bucket sort with threshold of 10, ratio test, worst case
    set title "Bucket sort avec seuil de 1 : test du rapport avec f(x)=x^2"
    set output "bucketSeuil_ratio_worstCase.png"
    g(x) = x**2
    set ylabel "y/x^2"
    plot "bucketSeuil.dat" using 1:(\$2/g(\$1)) title '1-9' with linespoints, "bucketSeuil.dat" using 1:(\$3/g(\$1)) title '10-19' with linespoints, "bucketSeuil.dat" using 1:(\$4/g(\$1)) title '20-29' with linespoints

    set logscale y
    set ylabel "log(temps d'exécution)"

    # Plot 3.1 : Merge sort with threshold of 1, power test
    set title "Merge sort avec seuil de 1 : test de puissance"
    set output "merge_power.png"
    set fit logfile "merge.log"
    fit f(x) 'merge.dat' using 1:2 via m,b
    fit f(x) 'merge.dat' using 1:3 via m,b
    fit f(x) 'merge.dat' using 1:4 via m,b
    plot "merge.dat" using 1:2 title '1-9' with linespoints, "merge.dat" using 1:3 title '10-19' with linespoints, "merge.dat" using 1:4 title '20-29' with linespoints

    # Plot 3.2 : Merge sort with threshold of 1, ratio test
    set title "Merge sort avec seuil de 1 : test du rapport avec f(x)=x*log(x)"
    set output "merge_ratio.png"
    unset logscale y
    g(x) = x*log(x)
    set ylabel "y/(x*log(x))"
    plot "merge.dat" using 1:(\$2/g(\$1)) title '1-9' with linespoints, "merge.dat" using 1:(\$3/g(\$1)) title '10-19' with linespoints, "merge.dat" using 1:(\$4/g(\$1)) title '20-29' with linespoints

    set logscale y
    set ylabel "log(temps d'exécution)"

    # Plot 4.1 : Merge sort with threshold of 10, power test
    set title "Merge sort avec seuil de 10 : test de puissamce"
    set output "mergeSeuil_power.png"
    set fit logfile "mergeSeuil.log"
    fit f(x) 'mergeSeuil.dat' using 1:2 via m,b
    fit f(x) 'mergeSeuil.dat' using 1:3 via m,b
    fit f(x) 'mergeSeuil.dat' using 1:4 via m,b
    plot "mergeSeuil.dat" using 1:2 title '1-9' with linespoints, "mergeSeuil.dat" using 1:3 title '10-19' with linespoints, "mergeSeuil.dat" using 1:4 title '20-29' with linespoints

    # Plot 4.2 : Merge sort with threshold of 10, ratio test
    set title "Merge sort avec seuil de 10 : test du rapport avec f(x)=x*log(x)"
    set output "mergeSeuil_ratio.png"
    unset logscale y
    g(x) = x*log(x)
    set ylabel "y/(x*log(x))"
    plot "mergeSeuil.dat" using 1:(\$2/g(\$1)) title '1-9' with linespoints, "mergeSeuil.dat" using 1:(\$3/g(\$1)) title '10-19' with linespoints, "mergeSeuil.dat" using 1:(\$4/g(\$1)) title '20-29' with linespoints

    set logscale y
    set ylabel "log(temps d'exécution)"

    exit
EOFMarker