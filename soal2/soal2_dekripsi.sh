#!/bin/bash
a="$1"
#printf "Nama File adalah $a ";
jam=`awk -v a=$a -F ";" 'FNR>1 {if(match($1, a))print $2}' tmp.csv`
#printf "$jam";
#alphabet1=`expr $jam + 97`
#echo $alphabet1
#alphabet2=`expr $alphabet1 - 97`
#echo $alphabet2
#alphabet3=`expr $alphabet2 % 26`
#echo $alphabet3
alphabetAwalValue=`expr $jam + 97`
#echo $alphabet
alphabetAwal=`awk -v a=$alphabetAwalValue 'BEGIN{printf "%c", a}'`
echo $alphabetAwal
alphabetAkhirValue=`expr $alphabetAwalValue - 1`
alphabetAkhir=`awk -v a=$alphabetAkhirValue 'BEGIN{printf "%c", a}'`
echo $alphabetAkhir
echo $a
newName=`echo $a | tr '['$alphabetAwal'-za-'$alphabetAkhir']' '[a-z]'`
echo "$newName"
mv "$a".txt "$newName.txt"
