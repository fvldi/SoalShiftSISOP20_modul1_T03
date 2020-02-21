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

	
