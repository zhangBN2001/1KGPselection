open LI,"/work_dir/LLR/01.overlop/LLR/end.list";
my @llf=();
my $num_LLR=0;
my $num_PHS=0;
while(<LI>){
	chomp;
	@line=split /#/ ,$_;
	$chas=(split /\t/ ,$line[0])[0];
	if($chas eq "ALL"){
		$num_LLR+=1;
		$line[1]=~s/$/\t1/;
		@GT=@line[2,];
		$bspv=1;
		for $gt(@GT){
			$pv=(split /\t/ ,$gt)[4];
			if($pv<$bspv){
				$bspv=$pv;
			}
		}
		$line[1].="\t".$bspv;
		push(@llf,$line[1]);
	}elsif($chas eq "LLR"){
		$num_PHS+=1;
		$line[1]=~s/$/\t0/;
		$line[1].="\tNA";
		push(@llf,$line[1]);
	}
}
#print "num of LLR : $num_LLR\nnum of PHS : $num_PHS\n";
for $llf(@llf){
	print $llf."\n";
}
close LI;





