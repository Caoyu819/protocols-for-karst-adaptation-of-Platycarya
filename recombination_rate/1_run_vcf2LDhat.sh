for i in `cat $1`
do
	vcftools --vcf $2".vcf" --ldhat-geno --chr $i --out $2"_"$i 2>$2"_"$i.log
	mv $2"_"* $3
done
