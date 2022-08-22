#!/usr/bin/perl -w
use strict;

my $vcfIn=shift;
my $vcfPhase=shift;

my $start=shift;
my $end=shift;

my $meta=shift;

my $down_sample=shift;


my (%ref,%alt);
open VI,$vcfIn or die $!;
while(<VI>){
        if(/^#/){
                next;
        }
        chomp;
        my @inf=split;
        my ($len3,$len4)=(length($inf[3]),length($inf[4]));
                if($len3 > $len4){
                        my $tmp= '-' x ($len3-$len4);
                        $inf[4]=$inf[4].$tmp;
                }elsif($len4>$len3){
                        my $tmp= '-' x ($len4-$len3);
                        $inf[3]=$inf[3].$tmp;
                }
        $ref{$inf[0]}{$inf[1]}=$inf[3];
        $alt{$inf[0]}{$inf[1]}=$inf[4];
}
close VI;

open MT, $meta or die $!;
my %meta;
while(<MT>){
        chomp;
        my @inf=split;
        $meta{$inf[0]}=$inf[1];
}
close MT;


my (%sample,%seq1,%seq2);
open VP,$vcfPhase or die $!;
while(<VP>){
        if(/^##/){
                next;
        }
        chomp;
        my @inf=split;
        $inf[0]="chr".$inf[0];
        if(/^#CHROM/){
                my $index=0;
                for my $in (@inf){
                        if($index >=9){
                                my $randi=rand(1);
                                if ($randi<=$down_sample){
                                        $sample{$index}=$in;
                                }
                        }
                        $index+=1;
                }
        }else{
                if(length($ref{$inf[0]}{$inf[1]})>20){
                        next;
                }
                if($start and $end){
                        next if $inf[1]<$start;
                        next if $inf[1]>$end;
                }
                my $index=0;
                for my $in (@inf){
                        if($index >=9 and exists $sample{$index} ){

                                if($in=~/0\|/){
                                        $seq1{$sample{$index}}.=$ref{$inf[0]}{$inf[1]};
                                }elsif($in=~/1\|/){
                                        $seq1{$sample{$index}}.=$alt{$inf[0]}{$inf[1]};
                                }
                                if($in=~/\|0/){
                                        $seq2{$sample{$index}}.=$ref{$inf[0]}{$inf[1]};
                                }elsif($in=~/\|1/){
                                        $seq2{$sample{$index}}.=$alt{$inf[0]}{$inf[1]};
                                }
                        }
                        $index+=1;
                }
        }
}
close VP;

for my $sample (keys %seq1){

        print ">$sample"."_".$meta{$sample}."_1\n".$seq1{$sample}."\n";
        print ">$sample"."_".$meta{$sample}."_2\n".$seq2{$sample}."\n";

}


