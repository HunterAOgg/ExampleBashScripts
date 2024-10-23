input="Genes.txt" #File with list of gene names in starting organism (Aedes Ae, Culex Q, etc) with one gene name on each line. These must be the names used in the bed file.
bed="CulexT.bed" #Bed file with a list of gene names and locations on the genome
genome="Culex-tarsalis_knwr_CONTIGS_CtarK1.fa" #Fasta file containing the genome, NOT TRANSCRIPTOME, of the  organism

while IFS= read -r line
do
  echo $line
  grep "${line}\s" $bed | grep "ID=mRNA" > $line.bed
  bedtools getfasta -fi $genome -bed $line.bed -fo $line.fa
  rm $line.bed
  rm $line.fa
done < "$input"
