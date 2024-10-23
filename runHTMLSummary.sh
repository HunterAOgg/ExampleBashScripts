outfile="HTMLOutput.tsv"
echo -e "Sample Name\tDuplication Rate\tReads Passed\tTotal\tQ20 Bases\tQ30 Bases" > ${outfile}

for FILE in *.html
do

	dup=$(grep "duplication rate:" $FILE | grep -o "[0-9]\+\.[0-9]\+%")

	reads_pass=$(grep "reads passed filters:" $FILE | grep -o "[0-9]\+\.[0-9]\+\s[GMK].*%)")

	tot_reads=$(grep "total reads:" $FILE | grep -o "[0-9]\+\.[0-9]\+\s[GMK]")

	q_20=$(grep "Q20 bases" $FILE -m 1 | grep -o "[0-9]\+\.[0-9]\+\s[GMK].*%)")

	q_30=$(grep "Q30 bases" $FILE -m 1 | grep -o "[0-9]\+\.[0-9]\+\s[GMK].*%)")

	write_line="${FILE}\t${dup}\t${reads_pass}\t${tot_reads}\t${q_20}\t${q_30}"

	echo -e ${write_line}

	echo -e ${write_line} >> ${outfile}
done
