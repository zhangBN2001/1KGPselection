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

die  "perl $0 <list> <out.svg> <zoom>\n" unless ($#ARGV >= 1);
my $in_list = shift;
my $out_svg=shift;
my $zoom=shift || 500;
my $offset_x=shift || -1000;
my $offset_y=shift || 400;


my $xlen_min=0;
my $xlen_max=0;
my %pos;

my $index_i=0;
my %index_i;
open INL , " awk '{print \$2}' $in_list | grep -v 'BP' | sort  -u  -k1,1n | " or die $!;
while(<INL>){
        chomp;
        if ($xlen_max <=$_){$xlen_max=$_;}
        if ($xlen_min >=$_ or $xlen_min eq 0 ){$xlen_min=$_;}
        $index_i{$_}=$index_i;
        $pos{$_}=$_;
        $index_i+=1;
}
close INL;


my $index_j=0;
my %index_j;
open INL , " awk '{print \$5}' $in_list | grep -v 'BP' |sort  -u  -k1,1n  | " or die $!;
while(<INL>){
        chomp;
        if ($xlen_max <=$_){$xlen_max=$_;}
        if ($xlen_min >=$_){$xlen_min=$_;}
        $index_j{$_}=$index_j;
        $pos{$_}=$_;
        $index_j+=1;
}
close INL;

print $xlen_min."\n";
my $xlen=$xlen_max-$xlen_min;

my  $ru_height = 20;
my  $line_height= 100;
my $sq_width=0.5;
my $wide = 200 + $xlen/$zoom;
my $height = 200 + $ru_height + $line_height + length(keys %pos) * $sq_width ;
my $font_size=1;

my $svg = SVG->new('width',$wide,'height',$height);

$svg->line('x1',$offset_x,'y1',$offset_y,'x2',$offset_x+$xlen/$zoom,'y2',$offset_y,'stroke-width',1,'stroke','black');
my $x=0;
my $ind=0;
my %ind;
foreach my $pos(sort {$a<=>$b} keys %pos)
{
        my
        $x=$pos;
        $svg->line('x1',$offset_x+($x-$xlen_min)/$zoom,'y1',$offset_y,'x2',$offset_x+($x-$xlen_min)/$zoom,'y2',$offset_y+$ru_height,'stroke-width',0.01,'stroke','black');
        $svg->line('x1',$offset_x+($x-$xlen_min)/$zoom,'y1',$offset_y + $ru_height, 'x2', $offset_x + $sq_width*(1 + 2*$ind),'y2',$offset_y+$ru_height+$line_height,'stroke-width',0.01,'stroke','black');
        $svg->text('x', $offset_x+($x-$xlen_min)/$zoom,'y',$offset_y -2* $font_size,'font-family', 'Arial', 'font-size',$font_size,'text-anchor','middle', '-cdata',$pos);
        $ind{$pos}=$ind;
        $ind+=1;
}

my $scl_ind=0;
my $scl_width=1;
for my $opa ( (0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0) ){
        $scl_ind+=1;
        $svg->rectangle(
    x      => $scl_ind*$scl_width*4,
    y      => 0,
    width  => $scl_width*4,
    height => $scl_width*4,
    id     => "opa.$opa",
    style => {
        'stroke'         => 'gray',
        'fill'           => 'brown',
        'stroke-width'   => '0.01',
        'fill-opacity'   => $opa,
    }
);

}

open IN3,$in_list or die $!;
<IN3>;
while (<IN3>)
{

        chomp;
        my @aa = split /\s+/;
        my ($y0,$x0)=($offset_y +$ru_height +$line_height  + $sq_width * ($ind{$aa[5]}-$ind{$aa[2]}+1) , $offset_x + $sq_width * ($ind{$aa[2]}+$ind{$aa[5]}-3));
        my ($y1,$x1)=($y0-$sq_width,$x0+$sq_width);
        my ($y2,$x2)=($y0,$x0+2*$sq_width);
        my ($y3,$x3)=($y0+$sq_width,$x0+$sq_width);

        my $xv = [$x0,$x1,$x2,$x3];
        my $yv = [$y0,$y1,$y2,$y3];

        my $points = $svg->get_path(
            x => $xv,
            y => $yv,
            -type   => 'path',
            -closed => 'true'  #specify that the polyline is closed
        );

        my $tag = $svg->path(
            %$points,
            id    => "$ind{$aa[2]}.$ind{$aa[5]}",
            style => {
                'fill-opacity' => $aa[7],
                'fill'   => 'brown',
                'stroke' => 'black',
                'stroke-width' => 0.01
            }
        );
}
close IN3;


open OUT,">$out_svg" or die $!;
my $out = $svg->xmlify;

print OUT "$out";

