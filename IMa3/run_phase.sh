#!/usr/bin/sh
#sh run_phase.sh DIR_indfa DIR_output genelist
indir=$1
outdir=$2
mkdir -p $outdir

#for i in `cat $genelist`
for i in `cat $3`
do 
perl ./seqphase1.pl -1 $indir/$i.ind.fa -p $outdir/$i 
PHASE -MR3 -R0.0004 -S12956 -X1 -N100 -F0.01 -O0.01 -l8 -x1 -p0.9 -q0.9 $outdir/$i.inp $outdir/$i.out 10000 1 10000
perl ./seqphase2.pl -c $outdir/$i.const -i $outdir/$i.out -o $outdir/$i.phased.ind.fa

done
