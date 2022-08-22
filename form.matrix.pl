#!/usr/bin/perl -w
use strict;


my $bed=shift;
my $ld=shift;

my $loc_count=0;
my %bed;
open BED, $bed  or die $!;
while(<BED>){
        chomp;
        my @inf=split;
        $bed{$inf[0]}{$inf[1]}=$loc_count;
        $loc_count+=1;
}
close BED;


my @matrix;
for my $i ( 1..$loc_count ){
        push @{$matrix[$i-1]}, (split //, 0 x $loc_count);
}

open LD,$ld or die $!;
<LD>;
while (<LD>){
        chomp;
        my @inf=split;
        if (exists $bed{$inf[0]}{$inf[1]}  and exists $bed{$inf[3]}{$inf[4]}){
                $matrix[$bed{$inf[0]}{$inf[1]}][$bed{$inf[3]}{$inf[4]}]=$inf[6];
        }
}
close LD;

for my $x (@matrix){
        my $line=join("\t",@{$x});
        print $line."\n";
}

