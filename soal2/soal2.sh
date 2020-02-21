#!/bin/bash
a=$(echo $1 | tr -d [:digit:])
< /dev/urandom tr -dc A-Za-z0-9 | head -c28  > $a.txt
b=`date +%H`
echo "$a;$b" >> tmp.csv
