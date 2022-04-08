for f in *.fa; do cat rename_list_unix.txt | while read l; do ./sed123.sh $l $f; done ; done

##sed123=sed -i "s/$1/$2/g" $3
