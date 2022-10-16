for i in `cat list_2369orth`
do
#	perl 6_fa2phy_singleinds.pl -i $i".align.fa-gb" -p 2_indfa_final -o $i".fa"
	perl 6_fa2phy_singleinds.pl -i $i".nt_ali.fasta-gb" -p 2_transtorx_indfa -o $i".nt_ali.nogap.fa"
	perl 6_fa2phy_singleinds.pl -i $i".nt_ali.fasta" -p 2_transtorx_indfa -o $i".nt_ali.withgap.fa"
done
