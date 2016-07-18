#!/bin/bash

#This script converts an amount of files of any type to a single pdf file.
#The files must be named:
#	<NAME_OF_FILE><NUMBER>.<TYPE>
#This loop go over all the files converting its to .pdf in the /pdf folder using convert
#After merge all using pdfunite
#See convert man for more help about how to convert to pdf

START=1 #Start Number
END=12 #Final Number
NAME="Documento escaneado-" #File Name
OUT="out.pdf" #Output file Name
TYPE="jpg" #Type of image
NAMEWITH00=true #if the name of the first 10 are like name01 name02 it adds a 0 before variable


LIST=""

touch $OUT
mkdir pdf

while [ $START -le $END ]; do

	# Is the name of the 10 first doubled 0 ? 
	if [[ ${#START} -lt 2 && $NAMEWITH00 = true ]] ; then
		MOD="0${START}"
	else
		MOD=$START
	fi

	actual_file="$NAME$MOD.$TYPE"	
	pdf_name="pdf/$NAME$MOD.pdf"
	pdf_name=${pdf_name// /_}
	
	echo  "convert $actual_file $pdf_name"
	convert "$actual_file" "$pdf_name"
	
	LIST+=' '$pdf_name
	let START=START+1
done

echo pdfunite $LIST $OUT
pdfunite $LIST $OUT
