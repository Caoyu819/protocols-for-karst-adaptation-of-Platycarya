#for i in `cat blocklist_500k_remain6185`
rm -f *".res.txt"
for i in `cat blocklist_500k_remain1344`
do
	chrID=`echo ${i%_*}`
#	echo "$chrID"
#	echo -n "$chrID	" >>1_PL.$chrID".res.txt"	
	sed -n '3,$p' 1_PL_block_500k/out/$i"_1_PL_block_500k_res.txt" >>1_PL.$chrID".res.txt"
done
