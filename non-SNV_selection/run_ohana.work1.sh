
#  step 1, explore population structure using Ohana nemeco.

wd=/jdfssz1/ST_HEALTH/P21Z10200N0047/zengyan/PAV/pangenie_populations/Population_struct
frac=0.02
vcf=/hwfssz1/pub/database/ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/HGSVC2/release/v1.0/PanGenie_results/pangenie_merged_bi_all.vcf.gz
sample=/jdfssz1/ST_HEALTH/P21Z10200N0047/zengyan/PAV/pangenie_populations/Population_struct/unrelated.IDs
sample_meta=/jdfssz1/ST_HEALTH/P21Z10200N0047/zengyan/PAV/pangenie_populations/Population_struct/samples.meta
plot=/jdfssz1/ST_HEALTH/P21Z10200N0047/zengyan/software/ohana/tools/plot-q.py


out_ped="$wd/vcf_trans_ped_noX"
out="$wd/total_noX"
source /jdfssz1/ST_HEALTH/P21Z10200N0047/zengyan/software/ohana/bin/load.sh

perl /jdfssz1/ST_HEALTH/P21Z10200N0047/zengyan/SW_selection/ohana/subsample_vcf.pl  $vcf   $frac  >  $out.1percent.vcf

grep -v "^chrX"  $out.1percent.vcf  >  $out.1percent_withnoX.vcf

vcftools --vcf $out.1percent_withnoX.vcf  --plink  --out $out_ped

perl /jdfssz1/ST_HEALTH/P21Z10200N0047/zengyan/SW_selection/ohana/filtersample.pl  $out_ped.ped  $sample   > $out_ped.ped2   && mv $out_ped.ped2  $out_ped.ped
plink  --noweb  --recode12  --geno 0.0 --maf 0.05 --tab  --file  $out_ped  --out  $out_ped.recode  && rm $out_ped.ped  $out_ped.map
sort $out_ped.recode.ped > $out_ped.recode.ped.sort
convert ped2dgm   $out_ped.recode.ped.sort   $out.1percent.g.dgm

awk '{print $1}' $out_ped.recode.ped.sort  >  $out.samplre_order
sort $sample_meta  >  $sample_meta.sort

awk  -F '\t' '{print $1"\t"$2"\t"$3"\t"$6"_"$4}' $sample_meta.sort  >  $sample_meta.sort2
join -a1 $out.samplre_order  $sample_meta.sort2  > $out.samplre_order.meta

for k in {3..12};   ####  define k ranges
do
out_inference="$wd/noX.infer$k"
perl /jdfssz1/ST_HEALTH/P21Z10200N0047/zengyan/SW_selection/ohana/sort_component.pl  $out.samplre_order.meta 3  $out_inference.1percent_Q.matrix  >  $out_inference.1percent_Q.matrix.sort
cat > qsub.$k.sh <<EOF
cd $wd
source /jdfssz1/ST_HEALTH/P21Z10200N0047/zengyan/software/ohana/bin/load.sh
#qpas  $out.1percent.g.dgm  -e 0.0001 -k $k -qo  $out_inference.1percent_Q.matrix -fo  $out_inference.1percent_F.matrix
#nemeco $out.1percent.g.dgm  $out_inference.1percent_F.matrix  -e 0.0 -co $out_inference.1percent_C.matrix
#cat  $out_inference.1percent_C.matrix | convert cov2nwk | convert nwk2svg > $out_inference.1percent.tree.svg
perl /jdfssz1/ST_HEALTH/P21Z10200N0047/zengyan/SW_selection/ohana/sort_component.pl  $out.samplre_order.meta 3  $out_inference.1percent_Q.matrix  >  $out_inference.1percent_Q.matrix.sort
python  $plot   $out_inference.1percent_Q.matrix.sort   $out_inference.1percent_Q.matrix.sort.svg
EOF
qsub -cwd  -l vf=2g -l num_proc=1 -binding linear:1 qsub.$k.sh
done
