#!/usr/bin/perl -w
use strict;

my $vcf=shift;
my $sample=shift;
my $group_col=shift;

my %group;
open SA,$sample or die $!;
while(<SA>){
        chomp;
        my @inf=split;
        $group{$inf[0]}=$inf[$group_col-1];
}
close SA;

my @head_ids;
open VCF, $vcf or die $!;
while(<VCF>){
        chomp;
        if(/^##/){
                next;
                print $_."\n";
        }elsif(/^#CHROM/){
                @head_ids=split;
                my $line="$head_ids[0]\t$head_ids[1]\t";
                $line.="sub-groups\t";
                $line.="total\n";
                print $line;
        }else{
                my @inf=split;
                my %frac;
                my %total;
                for(my $i=9;$i<=$#inf;$i+=1){
                        next if  ! exists $group{$head_ids[$i]};
                        if($inf[$i]=~/^0\/0/){
                                $total{$group{$head_ids[$i]}}+=2;
                                $frac{$group{$head_ids[$i]}}+=0;
                        }elsif($inf[$i]=~/^0\/1/ or $inf[$i]=~/^1\/0/){
                                $total{$group{$head_ids[$i]}}+=2;
                                $frac{$group{$head_ids[$i]}}+=1;
                        }elsif($inf[$i]=~/^1\/1/){
                                $total{$group{$head_ids[$i]}}+=2;
                                $frac{$group{$head_ids[$i]}}+=2;
                        }elsif($inf[$i]=~/^\.:\./){
                                my $tmp=0;  ## hold position.
                        }else{
                                exit 1;
                        }
                }
                my $out_line="$inf[0]\t$inf[1]\t";
                my ($frac,$total)=(0,0);
                for my $group (sort {$a cmp $b} keys %total){
                #for my $group (  sort {$hash{$a}<=>$hash{$b} } keys %group ) {
                        my $tmp_frac=sprintf "%.4f",$frac{$group}/$total{$group};
                        $out_line.="$group:$tmp_frac;";
                        $frac+=$frac{$group};
                        $total+=$total{$group};
                }
                my $tot_frac=sprintf "%.4f",$frac/$total;
                $out_line.="\t$tot_frac\n";
                print $out_line;
        }
}

