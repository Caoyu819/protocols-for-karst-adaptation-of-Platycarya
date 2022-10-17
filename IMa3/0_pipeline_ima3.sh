:<<!
#1.get nocds for each locus
##link the consensus seq of all inds in current directory
##copy and modify the script: get_loci.py in current directory
python get_loci.py &
!

#2b.phase the sequences
#2b.1 get indfa for each pop
:<<!
for ((i=0;i<=632;i++))
do
	grep -f PL_27inds.list -A 1 indfa_300-1000bp_25k_0N_47inds/all/loci$i".fas" >indfa_300-1000bp_25k_0N_47inds/PL/loci$i".ind.fa"
	grep -f PS_20inds.list -A 1 indfa_300-1000bp_25k_0N_47inds/all/loci$i".fas" >indfa_300-1000bp_25k_0N_47inds/PS/loci$i".ind.fa"
done
!
#2b.2 phase
:<<!
for i in `ls listDir`
do
	nohup sh run_phase.sh indfa_300-1000bp_25k_0N_47inds/PL indfa_300-1000bp_25k_0N_47inds/PL listDir/$i &
	nohup sh run_phase.sh indfa_300-1000bp_25k_0N_47inds/PS indfa_300-1000bp_25k_0N_47inds/PS listDir/$i &
done
!
#2b.2.2 cal hetezygosity of each locus(just in order to evaluate the result of phasing,not necessary!!!)
:<<!
for ((i=1;i<=185;i++))
do
#	sh cal_het.sh locus$i indfa_300-1000bp_25k_0N_47inds/PS indfa_300-1000bp_25k_0N_47inds/PS
	sh cal_het.sh locus$i indfa_300-1000bp_25k_0N_47inds/PL indfa_300-1000bp_25k_0N_47inds/PL
done
!

#2b.2.3 flt inds that can't be phased
:<<!
for i in `cat 458loci.final.list`
do
	perl flt_cntPhaseSeq.pl indfa_300-1000bp_25k_0N_47inds/PL/$i".phased.ind.fa" > indfa_300-1000bp_25k_0N_47inds/PL/$i".phased.flt.ind.fa"
	perl flt_cntPhaseSeq.pl indfa_300-1000bp_25k_0N_47inds/PS/$i".phased.ind.fa" > indfa_300-1000bp_25k_0N_47inds/PS/$i".phased.flt.ind.fa"
	cat indfa_300-1000bp_25k_0N_47inds/PL/$i".phased.flt.ind.fa" indfa_300-1000bp_25k_0N_47inds/PS/$i".phased.flt.ind.fa" >indfa_300-1000bp_25k_0N_47inds/all/2_phase_flt_458locus/$i".phased.flt.ind.fa"
done
!

#3.combine indfa of each locus into whole file 458loci_300-1000bp_25k_0N_47inds.ima3
perl fa2ima3bpp_pangxx.pl -p ./ -m K2_47inds.imap -o 458loci_300-1000bp_25k_0N_47inds.ima3 -2

#randomly choose 200loci from the 458loci from before steps, do this three times, we'll get three datasets, these three datasets can be used for input of IMa3 independently.

#4. run the IMa3, do remember to give full path of Ima3!!!
nohup mpirun -np 80 IMa3 -hn400 -ha0.995 -hb 0.4 -i in.200loci_300-1000bp_25k_0N_35inds.ima3 -o ima3_200loci_300-1000bp_25k_0N_35inds.out.hn500.1e6 -q6 -m1 -t4 -u30 -b24.0 -L48.0 -r257 -p23567 &>log_200loci_hn400_trun &
