touch temp.fa
while read LINE
do
  echo $LINE
  grep "\"${LINE}\"" genes.gtf | grep "maker\stranscript" | cut -f1,4,5 > ${LINE}.bed
  bedtools getfasta -fi genome.fa -bed ${LINE}.bed -fo ${LINE}.fa
done <$1

ls

Rscript batchOligostan.r ${1}


while read LINE
do
  echo ${LINE}
  echo -n "Total Probes: "
  TOT=$(wc -l "Probes__${LINE}/Probes__${LINE}_ALL_summary.txt")
  echo ${TOT}
  echo -n "Optimal Probes: "
  OPT=$(wc -l "Probes__${LINE}/Probes__${LINE}_FILT_summary.txt")
  echo ${OPT}
  rm ${LINE}.bed
  rm ${LINE}.fa
done <$1
