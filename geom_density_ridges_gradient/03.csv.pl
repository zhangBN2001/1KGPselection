open FI,"$ARGV[0]";
open OUT,">","$ARGV[0].csv";
while(<FI>){
	$_=~s/\t/,/g;
#	$_=~s/\n/;/g;
	if(((split /,/ ,$_)[8] ne "NA")and((split /,/ ,$_)[8]=~/^\d/)){
		print OUT $_;
	}
}
close FI;
close OUT;


