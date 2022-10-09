$leng=@ARGV;
$leng=$leng-1;
$indir="/workdir/boxplot/03.top";
$outdir="/workdir/boxplot/04.forplot";
open OUT,">","$outdir/$ARGV[$leng]";
for($i=0;$i<$leng;$i+=1){
	open FI,"$indir/$ARGV[$i]";
	$name=$ARGV[$i];
	$name =~ /(\.[A-Z]+\.[a-zA-Z]\.list)$/;
	$name=$`;
	print "$name\n";
	while(<FI>){
		print OUT $name."\t".$_;
	}
	close FI;
}










