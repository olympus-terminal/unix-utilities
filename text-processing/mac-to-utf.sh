#!/bin/bash

for f in FPKM.txt
do
  tr '\r' '\n' < $f > "$f"track.txt
done
