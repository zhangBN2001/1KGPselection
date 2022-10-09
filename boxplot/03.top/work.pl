
$fanwei=$ARGV[0];
$file=$ARGV[1];
$dir=$ARGV[2];

open FI,"$dir/$file";
open OUT,">","/workdir/boxplot/03.top/$fanwei.$file";
my %dir;
my @dir;
while(<FI>){
	chomp $_;
	$dir{$_}=(split /\t/ ,$_)[1];
	push(@dir,$_);
}
@dir=sort{$dir{$b}<=>$dir{$a}}@dir;
@fanwei=split /_/ ,$fanwei;
#print $fanwei[0]."\t".$fanwei[1]."\n";
$le=@dir;
#print $le."\n";
$mi=$le*$fanwei[0]*0.01;
$ma=$le*$fanwei[1]*0.01;
#print $mi."\t".$ma."\n";
for($i=0;$i<$le;$i+=1){
#	print ($le*$fanwei[0]*0.01)."\t".($le*$fanwei[1]*0.01)."\n";
	if(($i>=$mi)&&($i<$ma)){
		#print $i;
		print OUT $dir[$i]."\n";
	}
}
close FI;
close OUT;















