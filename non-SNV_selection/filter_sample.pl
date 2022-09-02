#!/usr/bin/perl -w
use strict;

my $ped=shift;
my $samples=shift;

my %samples;
open SAMP,$samples or die $!;
while(<SAMP>){
        chomp;
        $samples{$_}=1;
}
close SAMP;

open PED, $ped or die $!;
while(<PED>){
        chomp;
        my @inf=split;
        if (exists $samples{$inf[0]}){
                print $_."\n";
        }
}
close PED;
