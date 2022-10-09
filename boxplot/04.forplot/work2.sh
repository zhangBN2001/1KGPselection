while read class;do
canshu=""
for fanwei in "0_0.1" "0.1_0.5" "0.5_1" "1_2";do
for cla in "SNV" "ID" "SV";do
canshu="$canshu$fanwei.$cla.$class.list "
done
done
canshu="$canshu $class.list"
echo $canshu
perl work.pl $canshu
done</workdir/boxplot/class.list



