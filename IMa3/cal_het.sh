#1. while
geneid=$1
fadir=$2
outdir=$3

sum_het0=`grep -v ">" $fadir/$geneid".ind.fa"|grep -o "R\|Y\|S\|W\|K\|M"|wc -l`
sum_N0=`grep -v ">" $fadir/$geneid".ind.fa"|grep -o "N"|wc -l`

sum_het=`grep -v ">" $fadir/$geneid".phased.ind.fa"|grep -o "R\|Y\|S\|W\|K\|M"|wc -l`
sum_N=`grep -v ">" $fadir/$geneid".phased.ind.fa"|grep -o "N"|wc -l`
echo "$geneid	$sum_het0	$sum_het	$sum_N0	$sum_N"

:<<!
#2.1 cal het before phase
grep ">" $fadir/$geneid".ind.fa" |sed -r 's/>//g' >$outdir/$geneid".id0"
rm -f $outdir/$geneid.het0

grep -v ">" $fadir/$geneid".ind.fa"|while read line
do
	echo $line|grep -o "R\|Y\|S\|W\|K\|M\|N" |wc -l >>$outdir/$geneid.het0
done
	paste $outdir/tmp.het0 $outdir/$geneid.het0 >$outdir/tmp.het1
	mv $outdir/tmp.het1 $outdir/tmp.het0

rm -f $outdir/$geneid.id0 $outdir/$geneid.het0
!

:<<!
#2.2 cal het after phase
grep ">" $fadir/$geneid".phased.ind.fa" |sed -r 's/>//g' >$outdir/$geneid".id"
rm -f $outdir/$geneid.het

grep -v ">" $fadir/$geneid".phased.ind.fa"|while read line
do
	echo $line|grep -o "R\|Y\|S\|W\|K\|M\|N" |wc -l >>$outdir/$geneid.het
done
paste $outdir/$geneid.id $outdir/$geneid.het >$outdir/$geneid.id.het
rm -f $outdir/$geneid.id $outdir/$geneid.het
!
