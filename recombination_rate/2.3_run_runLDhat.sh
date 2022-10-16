#usage: sh XXX.sh blocklist inputDir lk.file
for i in `ls blocklistDir_PL`
do
#       echo $i
	nohup sh 2_run_LDhat.sh blocklistDir_PL/$i 1_PL_block_500k lk_PL_n88_t0.001new_lk.txt 2>log/err_chr_500k_$i &
#	nohup sh 2_run_LDhat.sh blocklistDir_PS/$i 2_PS_block_500k lk_PS_n122_t0.001new_lk.txt 2>log/err_chr_500k_$i &
done
