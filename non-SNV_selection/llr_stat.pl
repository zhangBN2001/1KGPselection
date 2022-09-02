#!/usr/bin/perl -w
use strict;
use POSIX;
use Data::Dumper;

my $in=shift;

my @percentile=(0.01,0.1,0.5,1,2,5,10,20,50,75,100);
my @lle;
my $count=0;
open IN,$in or die $!;

while(<IN>){
        chomp;
        my @inf=split;
        push @lle,$inf[3];
        $count+=1;
}
close IN;

#print Dumper @lle;
@lle=sort {$b <=> $a} @lle;
for my $perc(@percentile){
        my $index= POSIX::ceil(($count*$perc)/100);
        print "$perc\t$lle[$index-1]\n";
}

