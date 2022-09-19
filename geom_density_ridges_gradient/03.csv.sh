ls *list|while read line;do
perl csv.pl $line
done
