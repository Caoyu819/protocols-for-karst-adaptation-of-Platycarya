#0. modify the format of cds's name
#Mru:
#sed -r "/>/s/>(\S+) \[.*\] \[.*\] \[.*\] \[.*\]/>\1/g" Mru.cds >Mru.cds.1
#sed -r "/>/s/(\S+)_cds_(\S+)_(\S+)/>\2/" Mru.cds.1 >Mru.cds.2
:<<!
ln -s /data/data/Juglandaceae/Platycarya/13_geneExCon/genome/*.ext.merge.cds ./
sed -r 's/rna-gnl\|WGS:JAEDWW\|//g' Cil.ext.merge.cds >Cil.ext.merge.cds.2
sed -r 's/rna\-gnl\|WGS\:RXIC\|mrna\.//g' Mru.ext.merge.cds >Mru.ext.merge.cds.2
!

#step 0 1 2
:<<!
for i in `cat list_11sp.index`
do
	l=`echo ${i%_*}`
	sp=`echo ${i#*_}`
	colnu=$[$l+1]
	#0. get the orthlist of each sp
#	cut -f $colnu ./0_orthlist/Orthogroups_SingleCopyOrthologues.txt.2 |sed '1d' >./0_orthlist/orthlist_$sp
	#1. get singlecopy orthologues of each sp
#	awk '/^>/&&NR>1{print "";}{ printf "%s",/^>/ ? $0"\n":$0 }' ./1_genefa/$sp".ext.merge.cds" >./1_genefa/$sp".cds1"
#	grep -A 1 -f ./0_orthlist/orthlist_$sp ./1_genefa/$sp".cds1" -w | sed "/^--$/d" > ./1_genefa/$sp".orth.cds"
	#2. modify name of cds to orthfroup's name
#	perl 2_substitude_orthname.pl ./0_orthlist/Orthogroups_SingleCopyOrthologues.txt.2 $l ./1_genefa/$sp".orth.cds" &
done
!

#3. genefa to indfa
#perl 3_genefa2indfa.pl 0_orthlist/orthlist_OG ../list_11sp 1_genefa 2_indfa &

:<<!
#step 45 can be substitude by translatorx!!!
for i in `cat ../0_orthlist/orthlist_OG`
do
        translatorx_vLocal.pl -i $i".ind.fa" -o $i -p maFft
done
!

:<<!
#4. pal2nal
#nohup sh 4.1_mafft.sh orthlist 2_indfa &>log_mafft &
#sh 4.2_pal.sh orthlist 2_indfa
#5. partition
cd 2_indfa
mkdir 5_part_fa
sh ../5_run_codon123.sh ../orthlist
#creat gene123.list by:
cd 5_part_fa
mkdir bak
mv *12.fa bak
ls *.fa >../gene123.list

for i in `ls 5_part_fa/condon3/*.fa`
do
        Gblocks $i -t=DNA
done
!

:<<!
ls *.nt1_ali.fasta >condon1.list
ls *.nt2_ali.fasta >condon2.list
ls *.nt3_ali.fasta >condon3.list
perl ../5_join_part.pl condon1.list . geneposition1.txt align_condon1.phy 0
perl ../5_join_part.pl condon2.list . geneposition2.txt align_condon2.phy 0
perl ../5_join_part.pl condon3.list . geneposition3.txt align_condon3.phy 0
cat align_condon1.phy align_condon2.phy align_condon3.phy >align_condon123.phy
!

#7. mcmctree
##input file:   1:phylip format sequence file;
##		2:ctl file
##		3.tree file with fossil node time(CIs)

#mkdir 7_mcmctree
#nohup mcmctree mcmctree.ctl 1>log_mcmc_test_0831 2>err_mcmc_test_0831 &
:<<!
for i in {1..2}
do
	mkdir -p run$i
	cp mcmctree.ctl mcmctree.tree align_condon123.phy run$i/
	cd run$i
	nohup mcmctree mcmctree.ctl 1>log_mcmc_condon123 2>err_mcmc_condon123 &
	cd ../
done
!
