#!usr/bin/perl -w
use strict;

use SVG;
use Data::Dumper;
use Getopt::Long;

my $type;
GetOptions(
                "type:s"=>\$type,
          );
$type ||= 'point';

die  "perl $0 <ld_matrix>  <bed> <start> <end> <label> <zoom>\n" unless ($#ARGV==5);

my $ld = shift;
my $bed = shift;  ## only one chr included
#my $ticks = shift;
my $start=shift;
my $end=shift;
my $label=shift;
my $zoom=shift;

my @coord;
open BED, $bed or die $!;
while(<BED>){
        push @coord,(split)[1]; ##only one chr included

}
close BED;


my ($x_offset,$y_offset)=(100,100);

my $width=$end-$start;
#

my $svg = SVG->new('width',$width/$zoom+2*$x_offset,'height',$width/$zoom+2*$y_offset);
$svg->rect('x',$x_offset,'y',$y_offset,'width',$width/$zoom,'height',$width/$zoom,'stroke','black','fill','none','stroke-width',1);



my ($ld_min,$ld_max)=(0.2,1);
my ($r1,$g1,$b1)=(111,20,242);
#my ($r1,$g1,$b1)=(255,237,160);
my ($r2,$g2,$b2)=(240,59,32);




open LD,$ld or die $!;
my $i=0;
while(<LD>){
        my @inf=split;
        my $j;
        for ($j=0;$j<=$#inf;$j+=1 ){
                if( $inf[$j] >0 ){
                        my $ldi=$inf[$j];
                        my ($ri,$gi,$bi)=($r1+($r2-$r1)*($ldi-$ld_min)/($ld_max-$ld_min), $g1+($g2-$g1)*($ldi-$ld_min)/($ld_max-$ld_min), $b1+($b2-$b1)*($ldi-$ld_min)/($ld_max-$ld_min));
                        $svg->circle(cx => ($coord[$i]-$start)/$zoom+$x_offset, cy => ($coord[$j]-$start)/$zoom+$y_offset, r => 1.5,
                                style => {
                                     fill   => "rgb($ri,$gi,$bi,0.5)",
                                     'stroke-width'   => 0
                                    # stroke => "rgb($ri,$gi,$bi)"
                                }
                            );
                }
                if($j == $i){
                        $svg->circle(cx => ($coord[$i]-$start)/$zoom+$x_offset, cy => ($coord[$j]-$start)/$zoom+$y_offset, r => 1.5,
                                style => {
                                     fill   => "rgb($r2,$g2,$b2,0.5)",
                                     'stroke-width'   => 0
                                }
                            );
                }
        }
        $i+=1;
}
close LD;

 $svg->circle(cx => ($label-$start)/$zoom+$x_offset, cy => ($label-$start)/$zoom+$y_offset, r => 3,
                                style => {
                                     fill   => "rgb(0,0,0)",
                                     'stroke-width'   => 0
                                    # stroke => "rgb($ri,$gi,$bi)"
                                 }
              );


my $out = $svg->xmlify;
print $out;

