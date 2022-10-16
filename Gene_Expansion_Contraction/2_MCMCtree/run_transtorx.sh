for i in `cat $1`
do
	translatorx_vLocal.pl -i $i".ind.fa" -o $i -p maFft
done
