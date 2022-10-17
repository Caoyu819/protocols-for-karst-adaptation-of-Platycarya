#1. run ms for 5000 times,each with iteration 100(total number of simulation=5000*100=500,000)
for i in `ls listDir`
do
	nohup perl run_ms.pl listDir/$i 2>log/log_run_ms_par5000_$i &
done


#2. transform ms output to vcf files, using ms2vcf.py, which is downloaded from https://github.com/Flavia95/Thesis
#cd msout
for i in {1..5000}
#for i in `ls outms/SCS.*.ms`
do
        python ../ms2vcf.py SCS.par$i".ms" ../out_SCS
done

#3. convert file format of vcf for Fst calculation
outdir="out_SCS"
for i in `ls $outdir/*.vcf|sed "s/$outdir\///g"`
do
        awk '{if ($4=="." && $5==".") {$2=$2*25000;$4="A";$5="T"}{print $0}}' $outdir/$i|sed '6,$s/ /\t/g' >$outdir/$i".2"
        mv $outdir/$i".2" $outdir/$i
        #calculate Fst
        vcftools --vcf $outdir/$i --weir-fst-pop list_PL --weir-fst-pop list_PS --fst-window-size 25001 --out $outdir/$i 2>log/log_fst_$i
        vcftools --vcf $outdir/$i --keep list_PL --TajimaD 25000 --out $outdir/PL_$i 2>log/log_tajimaD_PL_$i
        vcftools --vcf $outdir/$i --keep list_PS --TajimaD 25000 --out $outdir/PS_$i 2>log/log_tajimaD_PS_$i
        vcftools --vcf $outdir/$i --keep list_PL --window-pi 25000 --out $outdir/PL_$i 2>log/log_pi_PL_$i
        vcftools --vcf $outdir/$i --keep list_PS --window-pi 25000 --out $outdir/PS_$i 2>log/log_pi_PS_$i
done
