:<<!
#0. get pop vcf
nohup vcftools --vcf 1_WGHQ_130inds_v3.vcf --recode --recode-INFO-all --stdout  --keep list_PLunrelated_44inds >PL.vcf 2>log_PL &
nohup vcftools --vcf 1_WGHQ_130inds_v3.vcf --recode --recode-INFO-all --stdout  --keep list_PSunrelated_61inds >PS.vcf 2>log_PS &

!

:<<!
#1.1 vcf2LDhat

nohup sh 1_run_vcf2LDhat.sh list_scaffold_chr PL 1_PL 2>log/log_1_PL &
nohup sh 1_run_vcf2LDhat.sh list_scaffold_chr PS 2_PS 2>log/log_2_PS &
:<<!
for i in `cat $1`
do
        vcftools --vcf $2".vcf" --ldhat-geno --chr $i --out $2"_"$i
        mv $2"_"* $3
done
!
!

:<<!
#1.2 vcf2block
#Rscript vcf2block.R <snpDen.file> <ctglist> <inputDir/> <windowSize> <sampleSize of pop> <outputDir>
nohup Rscript 1.2_vcf2block.R PLAT_500k.snpden list_chr 1_PL/ 500000 44 1_PL_block_500k/ 2>log_vcf2block_1_PL_500k &
nohup Rscript 1.2_vcf2block.R PLAT_500k.snpden list_chr 2_PS/ 500000 61 2_PS_block_500k/ 2>log_vcf2block_2_PS_500k &
!

:<<!
for i in `ls scalistDir`
do
	nohup Rscript 1.2_vcf2block.R PLAT_500k.snpden scalistDir/$i 1_PL/ 500000 44 1_PL_block_500k/ 2>log/log_vcf2block_1_PL_500k_$i &
	nohup Rscript 1.2_vcf2block.R PLAT_500k.snpden scalistDir/$i 2_PS/ 500000 61 2_PS_block_500k/ 2>log/log_vcf2block_2_PS_500k_$i &
done
!

#	nohup Rscript 1.2_vcf2block.R PLAT_500k.snpden scalistDir/xaa 1_PL/ 500000 70 1_PL_block_500k/ 2>log/log_vcf2block_1_PL_500k_xaa &

#2. LDhat
#2.1 get looktable for my data
:<<!
nohup lkgen -lk lk_n100_t0.001 -nseq 88 -prefix lk_PL_n88_t0.001 &
nohup lkgen -lk lk_n192_t0.001 -nseq 122 -prefix lk_PS_n122_t0.001 &
!
#2.2 get blocklist of each pop
#ls -alrt 1_PL_block_500k/*.locs|awk -F "/" '{print $NF}'|sed 's/\.locs//g' >blocklist_500k
#ls -alrt 1_PL_block_100k/*.locs|awk -F "/" '{print $NF}'|sed 's/\.locs//g' >blocklist_100k
#ls -alrt 1_PL_block_50k/*.locs|awk -F "/" '{print $NF}'|sed 's/\.locs//g' >blocklist_50k
#ls -alrt 1_PL_block_25k/*.locs|awk -F "/" '{print $NF}'|sed 's/\.locs//g' >blocklist_25k

#2.3 estimate variable recombination rate by interval
#sh 2.3_run_runLDhat.sh

:<<!
for i in `ls listDir_100k`
do
	sh 2_run_LDhat.sh listDir_100k/$i 1_PL_block_100k lk_PL_n162_t0.001new_lk.txt 2>log/err_$i &
done
!

:<<!
#2.4 summary Res
sh get_winRes.sh 500000 blocklist_500k out_res_500k 1_PL_block_500k_res.txt >1_PL.500k.res &
sh get_winRes.sh 500000 blocklist_500k out_res_500k 2_PS_block_500k_res.txt >2_PS.500k.res &
!

:<<!
#3.res2Map
nohup perl getMap_from_LDhatRes.pl blocklist_500k_PL_remain1349.sort out_res_500k 5910 1_PL.smcpp.map 1_PL.smcpp.res &
nohup perl getMap_from_LDhatRes.pl blocklist_500k_PS_remain1349.sort out_res_500k 3450 2_PS.smcpp.map 2_PS.smcpp.res &

nohup perl getMap_from_LDhatRes.pl blocklist_500k_PL_remain1349.sort out_res_500k 20000 1_PL.psmc.map 1_PL.psmc.res &
nohup perl getMap_from_LDhatRes.pl blocklist_500k_PS_remain1349.sort out_res_500k 10000 2_PS.psmc.map 2_PS.psmc.res &

nohup perl getMap_from_LDhatRes.pl blocklist_500k_PL_remain1349.sort out_res_500k 40000 1_PL.ima3.map 1_PL.ima3.res &
nohup perl getMap_from_LDhatRes.pl blocklist_500k_PS_remain1349.sort out_res_500k 20000 2_PS.ima3.map 2_PS.ima3.res &
