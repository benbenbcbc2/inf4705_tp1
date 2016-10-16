#!/bin/bash

SCRIPTS=./script
RES=./results
AMORT=10
DATA=$1

$SCRIPTS/save_hardware.sh $RES/hardware.txt
$SCRIPTS/save_thresh.py -r $RES
$SCRIPTS/time_all.py -r $RES -d $DATA -m $AMORT
$SCRIPTS/time_thresh.py -r $RES -m $AMORT
