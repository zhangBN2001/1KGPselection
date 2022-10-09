open FI,"/workdir/boxplot/01.input/input.list";

my %dir;

while(<FI>){
	chomp $_;
	@line=(split /\t/ ,$_);
	$line=$line[0].".".$line[2];
#	print $line."\n";
	if($dir{$line}){
		$yi=$dir{$line};
		push(@$yi,$_);
	}else{
		$yi=$dir{$line};
		$dir{$line}=\@{$line};
		push(@$yi,$_);
	}
}
close FI;
@dir=keys(%dir);
foreach $di(@dir){
	open OUT,">","/workdir/boxplot/02.cut/$di.list";
	$yi=$dir{$di};
	@dia=@$yi;
	foreach $li(@dia){
		print OUT $li."\n";
	}
	close OUT;
}
















