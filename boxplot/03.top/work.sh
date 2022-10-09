ls /workdir/boxplot/02.cut/*list | while read class;do
class=${class##*/}
echo $class
for fw in "0_0.1" "0.1_0.5" "0.5_1" "1_2";do
echo $fw
perl work.pl $fw $class /workdir/boxplot/02.cut 
done
done














