bedtools getfasta -fi flyGenome.fa -bed Selected.bed


touch culexCC.txt
for FILE in xx*
do
  echo $FILE
  echo $FILE >> culexCC.txt
  tblastx -query $FILE -db CTarsalis -evalue 1e-25 | grep "Query=" -A 7 >> culexCC.txt
done

input="Selected.bed"
touch sortedFlyCC.txt
######################################
# $IFS removed to allow the trimming #
#####################################
while IFS= read -r line
do
  echo $line
  ONE=$(echo $line | cut -d' ' -f2)
  echo $ONE
  TWO=$(echo $line | cut -d' ' -f3)
  echo $TWO
  FB=$(grep $ONE DMel.gtf | grep $TWO | cut -f9 | grep 'FBgn[0-9]*' -o -m1)
  echo $FB
  PHASE=$(grep $FB Drosophila_melanogaster.csv | cut -d',' -f1)
  echo $PHASE
  echo "$FB $PHASE" >> sortedFlyCC.txt
done < "$input"

while IFS= read -r line
do
  echo $line
  echo $(echo $line | cut -d' ' -f2)
done < "$input"

input="Selected.bed"
touch sortedFlyNames.txt
while IFS= read -r line
do
  echo $line
  ONE=$(echo $line | cut -d' ' -f2)
  echo $ONE
  TWO=$(echo $line | cut -d' ' -f3)
  echo $TWO
  FB=$(grep $ONE DMel.gtf | grep -m1 $TWO | cut -f9 | cut -f4 -d'"')
  echo $FB
  echo "$FB" >> sortedFlyNames.txt
done < "$input"
