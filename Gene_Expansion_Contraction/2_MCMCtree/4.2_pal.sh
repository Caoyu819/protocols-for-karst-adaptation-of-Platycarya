indfa_dir=./$2
#pdir=$2
#cdir=$3
#outdir=$4
#mkdir -p $outdir
#mkdir -p synonymous-$outdir
rm -f sort.fa.logs sort.pep.logs pal2nal.logs
for i in `cat $1`
do
./sort-fasta-seq.pl $indfa_dir/$i.ind.fa >$indfa_dir/$i.sort.ind.fa 2>>sort.fa.logs
./sort-fasta-seq.pl $indfa_dir/$i.mafft.pep >$indfa_dir/$i.mafft.sort.pep 2>>sort.pep.logs
./pal2nal.pl -codontable 1 -output fasta $indfa_dir/$i.mafft.sort.pep $indfa_dir/$i.sort.ind.fa >$indfa_dir/$i.align.fa 2>>pal2nal.logs

done

