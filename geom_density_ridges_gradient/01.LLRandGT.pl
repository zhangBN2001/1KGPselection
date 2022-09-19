open LLR ,"/work_dir/step4.all.sel.10.map.withlle.vcf2.5k.gff.LLR";
open GT ,"/work_dir/LLR/01.overlop/GTEx_Analysis_v8.metasoft.txt";
my %llr;
my %gt;
my ($num_LLF,$num_GT,$over_LLF,$over_GT,$over_all)=(0,0,0,0,0);
while(<LLR>){
	chomp;
	$num_LLF+=1;
	@line=split /\t/ ,$_;
	$llr{$line[1]}.="#".$_;
#	print "LLR:$line[1]\n";
}
while(<GT>){
	chomp;
	$num_GT+=1;
	$line=(split /\t/ ,$_)[0];
	$pv=(split /\t/ ,$_)[2];
	@line=split /_/ ,$line;
	$pha="$line[0]\t$line[1]\t$line[2]\t$line[3]\t$pv\t";
	$gt{$line[0].":".$line[1]}.="#".$pha;
#	print "GT:$line[0]:$line[1]\n";
}

@llr_dir=keys(%llr);
@gt_dir=keys(%gt);
my %all;
for $dir(@llr_dir){
	if($gt{$dir}){
		$all{"ALL:".$dir}.=$llr{$dir}."\t\t";
		$over_all+=1;
	}else{
		$all{"LLR:".$dir}.=$llr{$dir}."\t\t";
		$over_LLF+=1;
	}
}

for $dir(@gt_dir){
	if($llr{$dir}){
                $all{"ALL:".$dir}.=$gt{$dir}."\t\t";
	}else{
                $all{"GT:".$dir}.=$gt{$dir}."\t\t";
		$over_GT+=1;
        }
}

@sortdir=keys(%all);
#@sortdir=sort{$a<=>$b}@sortdir;
#@sortdir=sort(@sortdir);
#print "num of LLF : $num_LLF\nnum of GT : $num_GT\n";
#print "overlop of LLF : $over_LLF\n";
#print "overlop of GT : $over_GT\n";
#print "overlop of all : $over_all\n";
for $class(@sortdir){
	@line=split /:/ ,$class;
	@line2=split /#/ ,$all{$class};
	print "$line[0]\t$line[1]\t$line[2]\t$line2[0]\t$all{$class}\n"
}
		
close GT;
close LLR;


