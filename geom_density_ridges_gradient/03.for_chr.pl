open FI,"/work_dir/LLR/01.overlop/lg_top/lg.list";


#my %class=();
#while(<FI>){
#	if(/^>/){
#		$i=$_;
#		$class{$i}=$i;
#	}else
#		$class{$i}.=$_;
#	}
#}
#foreach(keys(%class)){
#	print $_."\n";
#}	


while(<FI>){
	if(/^>/){
		if($i){
			close CL;
		}
		$line=(split /\t/ ,$_)[0];
		$line=~s/^>//;
		open CL,">","/work_dir/LLR/01.overlop/chaifen/chaifen.$line.list";
		$i=1;
	}else{
		print CL $_;
	}
}
close CL;
close FI;

