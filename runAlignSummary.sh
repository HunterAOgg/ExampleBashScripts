outfile="AlignmentOutput.tsv"
rm $outfile
echo -e "Sample Name\tAlignmentRate\tAligned Once\tAligned >1\tDid Not Align" > ${outfile}

for FILE in *.log
do
  samp=$(grep "_R2_" $FILE | grep -v "/")
	overall=$(grep "overall alignment rate" $FILE | grep -o "[0-9]\+\.[0-9]\+")
	once=$(grep "aligned concordantly exactly 1 time" $FILE | grep -o "[0-9]\+\.[0-9]\+")
	zero=$(grep "aligned concordantly 0 times" $FILE | grep -o "[0-9]\+\.[0-9]\+")
	greater=$(grep "aligned concordantly >1 times" $FILE | grep -o "[0-9]\+\.[0-9]\+")

	#THIS ONLY CONSIDERS CONCORDANT ALIGNMENTS AS OTHERS ARE REMOVED

	write_line="${samp}\t${overall}\t${once}\t${greater}\t${zero}"

	echo -e ${write_line}

	echo -e ${write_line} >> ${outfile}
done
