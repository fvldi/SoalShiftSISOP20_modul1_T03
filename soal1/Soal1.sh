#!/bin/bash
echo "1A"
echo "Region dengan profit paling sedikit yaitu: "
#soal 1a
awk -F '\t' -f 1a.awk Sample-Superstore.tsv 

echo " "
echo "1B."
echo "2 state dengan  profit paling sedikit berdasarkan hasil poin a yaitu: "
#soal 1b
awk -F '\t' '$13 ~ /Central/ {profit[$11]+=$21;} END{for(state in profit){print profit[state],state;}}' Sample-Superstore.tsv | sort -n | awk '{print $2}' | head -2

echo ""
echo "1C."
echo "10 product yang memiliki profit paling sedikit berdasarkan 2 state hasil poin b yaitu: "
#soal 1c
awk -F '\t' '($11 ~ /Texas/ || $11 ~ /Illinois/) && $13 ~ /Central/ {profit[$17] += $21} END{for(produk in profit){print profit[produk],produk;}}' Sample-Superstore.tsv > produk.txt

sort -g produk.txt | cut -f2- -d ' '| head -10
