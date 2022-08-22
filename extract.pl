#!/usr/bin/perl -w
use strict;

my $in=shift;
my $start=shift;
my $end=shift;

open IN,$in or die $!;

while(<IN>){
        chomp;
        my @inf=split;
        if ($end < $inf[1] or $inf[1] < $start ){
                next;
        }else{
                print $_."\n";
        }
}

