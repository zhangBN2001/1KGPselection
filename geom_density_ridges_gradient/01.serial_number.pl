open FI,"/work_dir/LLR/01.overlop/huajian/pv.list";
open OUT,">","/work_dir/LLR/01.overlop/jia_num/pv.list";
print OUT "";
close OUT;
open OUT,">>","/work_dir/LLR/01.overlop/jia_num/pv.list";
my $num=0;
while(<FI>){
	$num+=1;
	print OUT "$num\t$_";
}
close FI;
close OUT;


