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
die  "perl $0 <list> <out.svg> <zoom>\n" unless ($#ARGV >= 2);
my $in_list = shift; 
my $out_svg=shift;
my $maxplot=shift;
my $het=shift||500;
my $zoom=shift || 500;
my $offset_x=shift || -1000;
my $offset_y=shift || 400;
my $xlen_min=0;
my $xlen_max=0;
my %pos;
my @ini;
my $index_i=0;
my %index_i;
my %pos2;
open MID , ">" ,"mid.list" or die $!;
open MAP , " awk '{print \$4}' vcf_trans_ped_noX.recode.map |sort -u |" or die $!;
while(<MAP>){
        chomp;
        $pos{$_}=$_;
	$pos2{$_}=0;
}
close MAP;

open INL , " awk '{print \$1}' $in_list | sort  -u  -k1,1n | " or die $!;
while(<INL>){
        chomp;
        if ($xlen_max <=$_){$xlen_max=$_;}
        if ($xlen_min >=$_ or $xlen_min eq 0 ){$xlen_min=$_;}
        $index_i{$_}=$index_i;
        $pos{$_}=$_;
        $index_i+=1;
}
close INL;
open INL , "$in_list " or die $!;
my $max_plot2=0;
while(<INL>){
	chomp;
	my @line=split /\s+/ ,$_;
	if($line[1]>$max_plot2){
	$max_plot2=$line[1];
	}
	$pos2{$line[0]}=$line[1];
}
print $maxplot."\n";
print $max_plot2."\n";
close INL;
foreach my $ps(keys(%pos2)){
	print MID $ps."\t".$pos2{$ps}."\n";
}
close MID;
#print $xlen_min."\n";
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
my $yos=$offset_y+$ru_height +$line_height+10*$sq_width;
foreach my $pos(sort {$a<=>$b} keys %pos)
{
        my
        $x=$pos;
        $svg->line('x1',$offset_x+($x-$xlen_min)/$zoom,'y1',$offset_y,'x2',$offset_x+($x-$xlen_min)/$zoom,'y2',$offset_y+$ru_height,'stroke-width',0.01,'stroke','black');
        $svg->line('x1',$offset_x+($x-$xlen_min)/$zoom,'y1',$offset_y + $ru_height, 'x2', $offset_x + $sq_width*(1 + 2*$ind),'y2',$offset_y+$ru_height+$line_height,'stroke-width',0.01,'stroke','black');
#        $svg->text('x', $offset_x+($x-$xlen_min)/$zoom,'y',$offset_y -2* $font_size,'font-family', 'Arial', 'font-size',$font_size,'text-anchor','middle', '-cdata',$pos);
        $ind{$pos}=$ind;
        $ind+=1;
}
#$svg->line('x1',$offset_x,'y1',$yos,'x2',$offset_x+$xlen/$zoom,'y2',$yos,'stroke-width',1,'stroke','black');
print $het."\n";
my $scl_ind=0;
my $scl_width=1;
$svg->line('x1',$offset_x-6*$sq_width,'y1',$yos+1*$sq_width,'x2',$offset_x-6*$sq_width,'y2',$yos+$het+1*$sq_width,'stroke-width',1,'stroke','black');
$svg->line('x1',$offset_x-5*$sq_width,'y1',$yos+1*$sq_width,'x2',$offset_x-12*$sq_width,'y2',$yos+1*$sq_width,'stroke-width',1,'stroke','black');
$svg->line('x1',$offset_x-5*$sq_width,'y1',$yos+$het+1*$sq_width,'x2',$offset_x-12*$sq_width,'y2',$yos+$het+1*$sq_width,'stroke-width',1,'stroke','black');
open IN3,"cat mid.list|sort -u -k1,1n |" or die $!;
#<IN3>;
while (<IN3>)
{
	
        chomp;
        my @aa = split /\s+/;
	$aa[1] = $aa[1]/$maxplot*$het;
	if(
		$aa[0]==108897145||
		$aa[0]==108413111||
		$aa[0]==108380806||
		$aa[0]==108834662||
		$aa[0]==108465596||
		$aa[0]==108746109||
		$aa[0]==108601445||
		$aa[0]==108501059||
		$aa[0]==108501232||
		$aa[0]==108502395||
		$aa[0]==108745706||
		$aa[0]==108955052||
		$aa[0]==108927427||
		$aa[0]==108320249){
		my ($y0,$x0)=($yos  + 2 * $sq_width  , $offset_x + 2 * $sq_width *($ind{$aa[0]})-2*$sq_width);
	        my ($y1,$x1)=($y0,$x0+4*$sq_width);
        	my ($y2,$x2)=($y0+$aa[1],$x0);
        	my ($y3,$x3)=($y0+$aa[1],$x0+4*$sq_width);
        	($y0,$x0)=($y3-4*$sq_width,$x0);
        	($y1,$x1)=($y0,$x1);
                my $xv = [$x0,$x1,$x3,$x2];
                my $yv = [$y0,$y1,$y3,$y2];
                my $points = $svg->get_path(
                	x => $xv,
                        y => $yv,
                );
		my $tag = $svg->path(
                	%$points,
                        style => {
                        	'fill'   => 'red',
                                'stroke' => 'red',
                                'stroke-width' => 0.01
                        }                                                                   
		);
	}else{			
        	my ($y0,$x0)=($yos  + 2 * $sq_width  , $offset_x + 2 * $sq_width *($ind{$aa[0]})-2*$sq_width);
	        my ($y1,$x1)=($y0,$x0+4*$sq_width);
        	my ($y2,$x2)=($y0+$aa[1],$x0);
	        my ($y3,$x3)=($y0+$aa[1],$x0+4*$sq_width);
		($y0,$x0)=($y3-4*$sq_width,$x0);
		($y1,$x1)=($y0,$x1);
	        my $xv = [$x0,$x1,$x3,$x2];
        	my $yv = [$y0,$y1,$y3,$y2];
	        my $points = $svg->get_path(
            		x => $xv,
            		y => $yv,
        	);

        	my $tag = $svg->path(
            		%$points,
            		style => {
                		'fill'   => 'black',
                		'stroke' => 'black',
                		'stroke-width' => 0.01
            		}
        	);
	}
}
close IN3;


open OUT,">$out_svg" or die $!;
my $out = $svg->xmlify;

print OUT "$out";









