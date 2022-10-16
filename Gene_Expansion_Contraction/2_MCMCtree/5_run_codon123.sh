#codon_dir="./6_condon/"
#mkdir -p $codon_dir
#genefa_dir="/panfs2/db/Juglandaceae/Platycarya_strobilacea/7_ChloroAnaly/8_partition/3_genefa"

for i in `cat $1`
do
perl ../5_partbycodon123.pl $i 5_part_fa
done
