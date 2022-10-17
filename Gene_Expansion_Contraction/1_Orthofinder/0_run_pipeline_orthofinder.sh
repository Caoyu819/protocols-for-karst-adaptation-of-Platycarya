#1. extract valid transcripts,filter following transcripts:
##Genes with internal stop codons(-g -V),lack start or end codon(-J);
##Genes which length less than 50 amino acids(-l 150);
##discard redundant transcripts(-M -K -Q)
##remain coding only(-C)
gffread -g Plon.fa -y Plon.ext.merge.pep -V  -M -K -J -Q -C -l 150 Plon.gff3 &
gffread -g Pstr.fa -y Pstr.ext.merge.pep -V -M -K -J -Q -C -l 150 Pstr.gff3 &
gffread -g Jre_serr.fa -y Jre_serr.ext.merge.pep -V -M -K -J -Q -C -l 150 Jre_serr.gff3 &
gffread -g Aro.fa -y Aro.ext.merge.pep -V -M -K -J -Q -C -l 150 Aro.gff3 &
gffread -g Fsyl.fa -y Fsyl.ext.merge.pep -V -M -K -J -Q -C -l 150 Fsyl.gff3 &

#2. remain longest transcripts as representation of the gene
#the scripts was downloded from github:
#according to https://www.jianshu.com/p/d334ec7c3571
#remember the >ID in the <in.pep> should match with ID="" in the <gff3>
sed -i '/>/ s/$/.mrna1/' Jre_serr.ext.merge.pep
#modify the last few lines of the scripts(change the info of the input and output)
python extract_L_protein_modi.py

#3. orthofinder
nohup orthofinder -f 0703_PPJF -t 10 >log 2>err &

nohup orthofinder -f 0703_PP -t 5 >log_PP 2>err_PP &
nohup orthofinder -f 0703_PPJA -t 5 >log_PPJA 2>err_PPJA &
