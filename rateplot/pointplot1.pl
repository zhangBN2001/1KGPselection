$in_list=shift;
open INL,"$in_list";
open OUT,">","$in_list.list";
while(<INL>){
	$i=$_;
	if($i=~/^#/){
	}else{
		chomp $i;
		@line=split /\t/ ,$i;
		$num=0;
		$all=0;
		for $line(@line){
			if($line=~/|/){
				$all+=1;
				@nub=split /|/ ,$line;
				if($nub[0]==1){$num+=1;}
				if($nub[1]==1){$num+=1;}
			}
		}
		print  OUT $line[1]."\t".$num."\n";
	}	
}	
close INL;
close OUT;
print 2*$all."\n";









