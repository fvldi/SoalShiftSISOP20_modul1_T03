# SoalShiftSISOP20_modul1_T03
Oleh:
1. Muhamad Rifaldi - 05311840000022
2. Dimas Pramudya H. - 05311840000037

# Soal 01

Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum
untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”.
Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :

a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
sedikit <br>
b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
sedikit berdasarkan hasil poin a <br>
c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
sedikit berdasarkan 2 negara bagian (state) hasil poin b



## Source Code:

Berikut merupakan source code dari `soal1.sh` :

```bash

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

```

## 01A.

`awk -F '\t' -f 1a.awk Sample-Superstore.tsv`

Dimana isi dari source code `1a.awk` sendiri yaitu:

```awk

{
	if($13 == "South"){
	jmlsouth+=$21;
	}

	if($13 == "West"){
	jmlwest+=$21;		
	}

	if($13 == "Central"){
	jmlcentral+=$21;		
	}

	if($13 == "East"){
	jmleast+=$21		
	}
}

END {
minA = 0;
minB = 0;

if(jmlsouth < jmlwest){
	minA = jmlsouth;
	namaRegionA = "South";
}
else if(jmlsouth > jmlwest){
	minA = jmlwest;
	namaRegionA = "West";
}

if(jmlcentral < jmleast){
	minB = jmlcentral;
	namaRegionB = "Central";
}
else if(jmlcentral > jmleast){
	minB = jmleast;
	namaRegionB = "East";
}

if(minA < minB){
	min = minA;
	nama = namaRegionA;
}
else if(minA > minB){
	min = minB;
	nama = namaRegionB;
}

print "Wilayah Bagian: " nama,"\nDengan Profit : " min
}

```

### Keterangan:

* `{ if($13 == "South"){jmlsouth+=$21;} if($13 == "West"jmlwest+=$21;} if($13 == "Central"){jmlcentral+=$21;} if($13 == "East"){jmleast+=$21}}` Pada line 57-73 berfungsi untuk menjumlahkan *profit* dari setiap *region* kemudian dimasukkan ke dalam variabel *sum*.
*



