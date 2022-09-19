open FI,"/work_dir/LLR/01.overlop/top01/top.list";
while(<FI>){
	chomp;
	if(/^>/){
		if($sub_NA){
	        	print "NA:$sub_NA\t0:$sub_0\tlg:$sub_lg\n";
		}
		print $_."\n";
                $sub_NA=0;
                $sub_0=0;
                $sub_lg=0;
	}else{
		@line=split /\t+/ ,$_;
		chomp $line[8];
		if($line[8] eq "NA"){
			$sub_NA+=1;
			#print "NA";
		}elsif($line[8]==0){
			$sub_0+=1;
			#print "0";
		}else{
			$sub_lg+=1;
			$line[8]=(log($line[8]))*(-1);
			#print $line[8];
		}
#		for $line(@line){
#			print $line."\t"
#		}
#		print "\n";
	}
}
print "NA:$sub_NA\t0:$sub_0\tlg:$sub_lg\n";
close FI;
