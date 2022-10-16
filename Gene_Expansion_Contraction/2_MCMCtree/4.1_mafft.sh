list=$1
indir=$2

for i in `cat $list`
do
	mafft --auto $indir/$i.ind.pep >./$indir/$i.mafft.pep
done
