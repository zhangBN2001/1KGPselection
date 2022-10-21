$in_list=shift;
open INL,"$in_list";
open OUT,">","$in_list.list";
while(<INL>){
	$i=$_;
	if($i=~/^#/){
	}else{
		chomp $i;
		@line=split /\s+/ ,$i;
		$num=0;
		$all=0;
		foreach $line(@line){
			if($line=~/\d[|]\d/){
				#print $line."\n";
				$all+=1;
				#print $num."\n";
				@nub=split /[|]/ ,$line;
				if($nub[0]==1){$num+=1;}
				if($nub[1]==1){$num+=1;}
				#print $num."\n";
			}
		}
		print  OUT $line[1]."\t".$num."\n";
	}	
}	
close INL;
close OUT;
print 2*$all."\n";





