#!/bin/bash

cat TPM_matrix_for_conversion.txt | while read l; 
do echo "$l" > 1 ; 
cut -f 1 1 > 2; 
sed -i.bak 's/\..*//g' 2; 
fgrep -f 2 converted_transcripts.txt > 3; 
paste 3 1 >> 4; 
done
