open FI,"/workdir/SNV.step4.all.sel.10.map.withlle.gff.tab";
open OUT,">","/workdir/boxplot/01.input/input.list";
close OUT;
open OUT,">>","/workdir/boxplot/01.input/input.list";

while(<FI>){
	chomp $_;
	@line=(split /\t/ ,$_);
	$line="SNV\t".$line[3]."\t".$line[4]."\n";
	print OUT $line;
}
close FI;
open FI,"/workdir/step4.all.sel.10.map.withlle.vcf2.gff.LLR ";
while(<FI>){
	chomp $_;
	@line=(split /\t/ ,$_);
	$ref=length($line[4]);
	$query=length($line[5]);
	if($ref > $query){
		$cha=$ref-$query;
	}else{
		$cha=$query=$ref;
	}
	if($cha>50){
		$line="SV\t".$line[3]."\t".$line[6]."\n";
	}elsif($cha>0){
		$line="ID\t".$line[3]."\t".$line[6]."\n";
	}else{
		print $cha."\t".$_;
	}
	print OUT $line;
}

close OUT;









