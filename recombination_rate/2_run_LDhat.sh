fid=$1
outdir=$2
lkfile=$3

mkdir -p $outdir/out

for i in `cat $fid`
{
#3.2 estimate variable recombination rate by interval
	prefix=$i"_"$outdir"_"

	interval -seq $outdir/$i".sites" -loc $outdir/$i".locs" -lk $lkfile -its 10000000 -samp 2000 -bpen 5 -prefix $prefix &>log_interval_$outdir
	rm -f $prefix"bounds.txt" $prefix"new_lk.txt" $prefix"type_table.txt"

#3.3 summary recombination rates by stat
	stat -input $prefix"rates.txt" -burin 500 -loc $outdir/$i".locs" -prefix $prefix >log_stat_$outdir
	rm  -f $prefix"rates.txt"
	mv $prefix* $outdir/out
}

#CPLDhat is two slow
#mpirun -n 15 interval -seq $outdir/PL1_CTG_1".ldhat.sites" -loc $outdir/PL1_CTG_1".ldhat.locs" -lk lk_PL1_n94_t0.001new_lk.txt -its 10000000 -samp 500 -bpen 5 -prefix PL1_CTG_1"_" >log_interval_PL1
#mpirun -n 15 stat -input PL1_CTG_1_rates.txt -burin 200 -loc $outdir/PL1_CTG_1".ldhat.locs" -prefix PL1_CTG_1"_" >log_stat_PL1
