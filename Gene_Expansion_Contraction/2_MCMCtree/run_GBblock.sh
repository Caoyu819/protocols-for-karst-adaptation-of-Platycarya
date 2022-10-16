for i in `ls *.nt*_ali.fasta`
do
	Gblocks $i -t=DNA
done
