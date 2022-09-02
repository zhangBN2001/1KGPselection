#!/usr/bin/perl -w
use strict;
use Data::Dumper;
use Math::BigFloat;


my $sample=shift;
my $group_field=shift;  ## 0 based
my $Q=shift;

my %group_by;
my @ids;
open SAM,$sample or die $!;
while(<SAM>){
        chomp;
        my @inf=split;
        push @{$group_by{$inf[$group_field]}},$inf[0];
        push @ids,$inf[0];
}
close SAM;

my %compo;
my %Q;
open Q, $Q or die $!;
my $idx=0;
my $head=<Q>;
print $head;
my @col_tmp=split('\s',$head);
my $col_n=$col_tmp[1];
while(<Q>){
        chomp;
        my @inf=split;
        my $i=0;
        while($i <= $#inf){
                $compo{$ids[$idx]}{$i}= Math::BigFloat->new($inf[$i]);
                $i+=1;
        }
        $Q{$ids[$idx]}=$_;
        $idx+=1;
}
close Q;

my @out_ids;
my %mean;
open OG, "> $Q.groups_order" or die $!;
for my $group (sort {$a cmp $b } keys %group_by){
        #$mean{$group}{"total"}=0;
        my $k=0;
        my %d;
        while ($k<$col_n){
                my $total=0;
                $d{$k}=0;
                my $sample_count=$#{$group_by{$group}}+1;
                for my $id ( @{$group_by{$group}}){
                        $total+=$compo{$id}{$k};
                }
                my $avg=$total/$sample_count;
                for my $id ( @{$group_by{$group}}){
                        my $diff=abs($compo{$id}{$k} - $avg);
        #               print $diff."\n";
                        $d{$k}+=$diff*$diff;
                }
                #print $d{$k}."\n";
                $k+=1;
        }
        #print Dumper %d;
        my @ranks= sort{$d{$b}<=>$d{$a}} keys %d;
        #print Dumper @ranks;
        my $rank_k=$ranks[0];
        for my $id  ( sort {$compo{$a}{$rank_k} <=> $compo{$b}{$rank_k}} keys %compo){
                if(grep /$id/,@{$group_by{$group}} ){
                        push @out_ids,$id;
                        print $Q{$id}."\n";
                }
        }
        print OG "Group name $group; Group by component $rank_k\n";
}

