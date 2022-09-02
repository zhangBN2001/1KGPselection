#!/usr/bin/perl -w
use strict;

my $vcf=shift;
my $frac=shift;

if ($vcf=~/gz$/){
        open  VCF,"zcat  $vcf |" or die $!;
}else{
        open VCF, $vcf or die $!;
}

while(<VCF>){
        chomp;
        if(/^#/){
                print $_."\n";
        }else{
                my $rand=rand();
                if($rand < $frac){
                        my @inf=split;
                        if (length($inf[3])>1 or length($inf[4])>1 ){
                                next;
                        }else{
                                print $_."\n";
                        }
                }
        }
}
close VCF

