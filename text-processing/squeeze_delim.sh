ls -ltr *.aa.fa | tr -s ' ' | cut -d ' ' -f 5,9 | sort -k 2,2 -d
