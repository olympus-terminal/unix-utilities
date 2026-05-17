#!/bin/bash

for f in *.csv
do 
 sort -u -t, -k1,1 $f>"$f".unique.csv
done
