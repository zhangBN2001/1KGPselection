open FI,"/work_dir/LLR/01.overlop/jia_num/pv.list";

my %class=();
my %dir=();
while(<FI>){
	$class=(split /\t/ ,$_)[7];
	$level=(split /\t/ ,$_)[4];
	$number=(split /\t/ ,$_)[0];
	$dir{$number}=$_;
	$class{$class}.="$number\t$level#";
#	print "$number\t$level\n";
}
my %dir2;
@class=keys(%class);
for $class(@class){
	@level=split /#/ ,$class{$class};
	foreach(@level){
		$dir2{$_}=(split /\t/ ,$_)[1];
#		print $_."\n";
	}
	@level=sort{$dir2{$b}<=>$dir2{$a}}@level;
#	foreach(@level){
#		print "$_\n";
#	}
	$length=@level;
	$length=int($length/10);
	print ">$class\t$length\n";
	$sub=0;
	for $lev(@level[0..$length-1]){
		$sub+=$i2;
		my($i1,$i2)=(split /\t/ ,$lev)[0,1];
		$dir{$i1}=~s/^[^\t]+\t//;
		print $dir{$i1};
	}
#	$sub=$sub/$length*10000;
#	print $sub."\n";
}

#for $class(@class){
#	print $class."\n";
#}
#open FI,"/work_dir/LLR/01.overlop/huajian/pv.list";
#for $class(@class){
#	print "0\n";
#	my @top=();
#	while(<FI>){
#		chomp;
#		$fi_class=(split /\t/ ,$_)[6];
#		$value=(split /\t/ ,$_)[3];
#		if($fi_class eq $class){
#			push(@top,$value);
#		}
#		@top=sort{$b<=>$a}@top;
#		$length=@top;
##		$length=int($length/10);
##		for$va(@top[0,$length-1]){
##		#	print "$class\t$length\t$va\n";
#		}
#	}
#}
close FI;
sub mysort{
	$a=(split /_/ ,$a)[1];
	$b=(split /_/ ,$b)[1];
	if($a<$b){
		return(-1)
	}elsif($a>$b){
		return(1)
	}else{
		return(0)
	}
}
