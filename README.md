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

Code:<br> 
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

* `END {minA = 0;minB = 0;` Pada line 75-77 merupakan bagian darin *end* block, dimana kemudian dikenalkan variabel minA dan minB terlebih dahulu.

* `if(jmlsouth < jmlwest){minA = jmlsouth;namaRegionA ="South";} else if(jmlsouth > jmlwest){minA = jmlwest;
namaRegionA = "West";} if(jmlcentral < jmleast){minB =jmlcentral;namaRegionB = "Central";} else if(jmlcentral >jmleast){minB = jmleast;namaRegionB = "East";} if(minA < minB){ min = minA; nama = namaRegionA;} else if(minA > minB{min = minB;nama = namaRegionB;}` pada line 79-104 jumlah antar *region* dibandingkan. Dimana region dengan *provit* paling rendah akan masuk ke dalam variabel minA dan minB untuk kemudian dibandingkan lagi.

* `print "Wilayah Bagian: " nama,"\nDengan Profit : " min}` Pada line 106-107 akan menampilkan (print) *region* dengan jumlah provit terkecil.



## 01B.

Code:<br>
`awk -F '\t' '$13 ~ /Central/ {profit[$11]+=$21;} END{for(state in profit){print profit[state],state;}}' Sample-Superstore.tsv | sort -n | awk '{print $2}' | head -2` 

### Keterangan:

* Fungsi `awk -F '\t'` yaitu menerangkan bahwa field separatornya berupa Tab.

* Fungsi `$13 ~ /Central/ {profit[$11]+=$21;}` yaitu apabila *Region*-nya adalah *Central*, maka *profit* dari masing-masing *State* pada *region* tersebut dijumlahkan, dimana *profit*[$11] adalah array untuk menyimpan jumlah *profit* kedalam *State*-nya masing-masing.

* Fungsi *end* block`END{for(state in profit){print profit[state],state;}}' Sample-Superstore.tsv` yaitu menampilkan jumlah *state* dan nama *state* yang terdapat pada array *profit*[state].

* Fungsi `sort -n | awk '{print $2}' | head -2` yaitu sebagai pengurut jumlah *state* dari kecil ke besar kemudian menampilkan kolum ke dua pada dua baris teratas nama dan jumlah *state* tadi.



## 01C

Code:<br>
`awk -F '\t' '($11 ~ /Texas/ || $11 ~ /Illinois/) && $13 ~ /Central/ {profit[$17] += $21} END{for(produk in profit){print profit[produk],produk;}}' Sample-Superstore.tsv > produk.txt sort -g produk.txt | cut -f2- -d ' '| head -10`

### Keterangan:

* Fungsi `awk -F '\t' '($11 ~ /Texas/ || $11 ~ /Illinois/) && $13 ~ /Central/ {profit[$17] += $21}` yaitu apabila *State*-nya adalah Texas atau Illinois dan *Region*-nya adalah Central, maka *Profit* dari *produk*nya dijumlahkan, kemudian *profit*[$17] merupakan array yang digunakan untuk menyimpan jumlah *profit* ke dalam *produk*nya masing-masing.

* Fungsi `END{for(produk in profit){print profit[produk],produk;}}' Sample-Superstore.tsv > produk.txt` yaitu Untuk setiap *produk*, dicetak jumlah *profit*nya dan nama *produk*nya lalu dimasukkan kedalam sebuah file bernama produk.txt.

* Fungsi `sort -g op3.txt | cut -f2- -d ' '| head -10` yaitu sebagai pengurut jumlah *profit* pada file `produk.txt` dari yang terkecil. kemudian menampilkan 10 nama *produk* terkecil.



## Output Soal 01:

```bash

root@kali:/media/sf_shared/soal1# ./soal1.sh
1A
Region dengan profit paling sedikit yaitu: 
Wilayah Bagian: Central 
Dengan Profit : 39706.4
 
1B.
2 state dengan  profit paling sedikit berdasarkan hasil poin a yaitu: 
Texas
Illinois

1C.
10 product yang memiliki profit paling sedikit berdasarkan 2 state hasil poin b yaitu: 
GBC DocuBind P400 Electric Binding System
Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind
Ibico EPK-21 Electric Binding System
Lexmark MX611dhe Monochrome Laser Printer
Ibico Hi-Tech Manual Binding System
GBC DocuBind TL300 Electric Binding System
3.6 Cubic Foot Counter Height Office Refrigerator
Hoover Upright Vacuum With Dirt Cup
GBC ProClick 150 Presentation Binding System
GBC Ibimaster 500 Manual ProClick Binding System

```



## Soal 02.

Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan
data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka
meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide.
Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide
tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang
dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf
besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi
.txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.
(c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di
enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan
dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal:
password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt
dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan
file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28,
maka akan menjadi huruf b.) dan (d) jangan lupa untuk membuat dekripsinya supaya
nama file bisa kembali.
HINT: enkripsi yang digunakan adalah caesar cipher.
*Gunakan Bash Script


## 02A & 02B:

a. `soal2.sh`<br>
```bash

#!/bin/bash
a=$(echo $1 | tr -d [:digit:])
< /dev/urandom tr -dc A-Za-z0-9 | head -c28  > $a.txt
b=`date +%H`
echo "$a;$b" >> tmp.csv

```

### Keterangan:

* Fungsi `a=$(echo $1 | tr -d [:digit:])` yaitu mendeklarasikan Variable a yang berisikan `echo` `$1` yang telah dihapuskan digit dengan function `-tr(translate) -d [:digit:]`

* Fungsi `< /dev/urandom tr -dc A-Za-z0-9 | head -c28 > $a.txt` yaitu function random dengan parameter sebanyak 28 karakter dan dimasukan ke file $a.txt

* Fungsi `b = date +%H` yaitu berisi Variable b untuk mengetahui keterangan waktu file itu dibuat

* Fungsi `echo "$a;$b" >> tmp.csv` yaitgu untuk memasukkan nama File `($a)` dan `($b)` kedalam suatu file csv yaitu `tmp.csv` (sebagai database seluruh file yang dibentuk dan jamnnya) DENGAN Separator `";"`


## 02C.

```bash

#!/bin/bash
a="$1"
#printf "Nama File adalah $a ";
jam=`awk -v a=$a -F ";" 'FNR>1 {if(match($1, a))print $2}' tmp.csv`
##printf "$jam";
alphabet1=`expr $jam + 97`
##echo $alphabet1
#alphabet2=`expr $alphabet1 - 97`
#echo $alphabet2
#alphabet3=`expr $alphabet2 % 26`
#echo $alphabet3
alphabetAwalValue=`expr $jam + 97`
#echo $alphabet
alphabetAwal=`awk -v a=$alphabetAwalValue 'BEGIN{printf "%c", a}'`
##echo $alphabetAwal
alphabetAkhirValue=`expr $alphabetAwalValue - 1`
alphabetAkhir=`awk -v a=$alphabetAkhirValue 'BEGIN{printf "%c", a}'`
##echo $alphabetAkhir
##echo $a
newName=`echo $a | tr '[a-z]' '['$alphabetAwal'-za-'$alphabetAkhir']'`
##echo "$newName"
echo "$newName;$jam" >> tmp.csv
mv $a.txt $newName.txt

```

### Keterangan:

* Fungsi `a="$1"` yaitu variabel sebagai Argumen yang diinputkan`

* Fungsi `alphabetAwalValue= expr $jam + 97` yaitu untuk mendeklarsikan variable awal yang merupakan huruf ascii 'a' + jam

* Fungsi ``` newName= echo $a | tr '[a-z]' '['$alphabetAwal'-za-'$alphabetAkhir']' ``` yaitu Proses Enkripsi, nama file yang tersimpan dalam $a akan digantikan, Contoh : jam = 3, maka tr '[a-z]' '[d-za-c]' dimana ascii value dari d = a + 3

* Fungsi `echo "$newName;$jam" >> tmp.csv` Untuk membantu proses dekripsi kembali maka disimpan nama file yang telah diencrypt beserta jamnya (jam file dibuat)

* Fungsi `mv $a.txt $newName.txt` yaitu merename file.


## 02D.

```bash

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


```

### Keterangan:

* Fungsi `a="$1"` Utuk menginputkan pada variabel `a`

* Fungsi ``` jam=awk -v a=$a -F ";" 'FNR>1 {if(match($1, a))print $2}' tmp.csv ``` untuk mengambil Variable Jam dari database (tmp.csv) dengan key yaitu nama file itu sendiri

* Fugnsi `alphabetAwalValue= expr $jam + 97` yaitu mendeklarasikan variable awal, dimana merupakan huruf ascii 'a' + jam

* Fungsi `alphabetAwal=awk -v a=$alphabetAwalValue 'BEGIN{printf "%c", a}'` yaitu untuk mendapatkan karakter dari value ascii

* Fungsi `alphabetAkhirValue= expr $alphabetAwalValue - 1` yaitu Mendapatkan Value dari karakter Ascii, satu huruf sebelum alphabet alphabetAwal

* Fungsi `alphabetAkhir= awk -v a=$alphabetAkhirValue 'BEGIN{printf "%c", a}'` yaitu untuk mendapatkan karakter tersebut

* Fugsi `newName= echo $a | tr '['$alphabetAwal'-za-'$alphabetAkhir']' ['a-z']` sebagai Proses Dekripsi, nama file yang tersimpan dalam $a akan digantikan, Contoh : jam = 3, maka tr '[d-za-c]' '[a-z]' dimana ascii value dari d = a + 3

* Fungsi `echo "$newName;$jam" >> tmp.csv` Untuk membantu proses dekripsi kembali maka disimpan nama file yang telah diencrypt beserta jamnya (jam file dibuat)

* Fungsi `mv $a.txt $newName.txt` yaitu untuk merename file





## Soal 03.

1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati
kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang
sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma,
kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. [a] Maka dari
itu, kalian mencoba membuat script untuk mendownload 28 gambar dari
"https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file
dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2,
pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam
sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk
menjalankan script download gambar tersebut. Namun, script download tersebut hanya
berjalan[b] setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena
gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan
gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma
sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar
identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda
antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke
Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan
selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan
kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. [c] Maka dari
itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan
gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka
sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate
dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201).
Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan
dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253).
Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi
ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya
merupakan hasil dari grep "Location".
*Gunakan Bash, Awk dan Crontab

## 03A.

```bash

#!/bin/bash
for n in $(seq 1 28)
do
wget -O pdkt_kusuma_$n https://loremflickr.com/320/240/cat -a wget.log
done

```

### Keterangan:

* Fungsi `#!/bin/bash` yaitu sebagai command untuk menggunakan bash script

* Fungsi `for n in $(seq 1 28) do` yaitu sebagai command looping

* `wget -O pdkt_kusuma_$n https://loremflickr.com/320/240/cat -a wget.log done` yaitu pada fungsi -wget untuk mendownload picture dari alamat web yang telah dicantumkan dan fungsi -o untuk mengubah nama file yang didownload dan fungsi -a untuk menambahkan file dari web yang udah dicantumkan.

## 03B.

```bash

Crontab :
5 6-23/8 * * 0-5 /home/dimas/Documents/sisop/soal3a.sh

```

### Keterangan:

```
5 6-23/8 * * 0-5
```

5 artinya menit ke-5.<rb>
6-23/8 artinya setiap 8 jam sekali dari jam 06.00-23.00.
0-5 artinya setiap hari kecuali hari sabtu. Jadi kesimpulannya adalah crontab akan berjalan setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu
/home/dimas/Documents/sisop/soal3a.sh : direktori untuk menjalankan perintah crontab pada soal3a.sh yang berada di directory /Documents/sisop


## 03C.

```bash

#!/bin/bash
cat wget.log | grep Location: > location.log

mkdir duplicate
mkdir kenangan

awk '{ i++
        print i ";" $2
}' location.log | awk -F ';' '{
counter[$2]++
if (counter[$2] > 1) {
 aws = "mv pdkt_kusuma_"$1 " duplicate/duplicate_"$1
}

else {
 aws = "mv pdkt_kusuma_"$1 " kenangan/kenangan_"$1
}
system(aws)

}'
ls *.log | awk '{
        aws  = "cp " $0 " $0 ".bak"
        system(aws)
}'


```

## keterangan:

Dibuat program location.log yang berguna untuk menyimpan gambar yang telah di download, dan selanjutnya akan dihitung apakah ada gambar yang lebih dari satu, jika terdapat duplicate / gambar yang sama maka akan dipindah ke directory duplicate dan selanjutnya memindah kan gambar lainya ke direktori kenangan lalu proses selanjutnya membuat backup tiap copyan file dengan list nama .log .