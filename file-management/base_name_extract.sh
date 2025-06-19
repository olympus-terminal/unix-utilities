#!/bin/bash

for f in *.txt
do
 echo "${f%.txt}"
done
