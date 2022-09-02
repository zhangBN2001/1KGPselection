#!/usr/bin/perl -w
use strict;


my $fai=shift;
my $bin_len=shift;

my $chrs=shift;

my %chrs;
open CHR,$chrs or die $!;
while(<CHR>){
        chomp;
        $chrs{$_}=1;
}
close CHR;


open FAI,$fai or die $!;
while(<FAI>){
        chomp;
        my @inf=split;
        if(exists $chrs{$inf[0]}){
                my $idx=0;
                while($idx<$inf[1]){
                        my ($start,$end)=($idx+1,$idx+$bin_len);
                        if($end > $inf[1]){
                                $end=$inf[1];
                        }
                        print "$inf[0]\t$start\t$end\n";
                        $idx+=$bin_len;
                }
        }
}
close FAI;

