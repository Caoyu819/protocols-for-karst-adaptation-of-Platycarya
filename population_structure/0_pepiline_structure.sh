#step1: transform vcf to input of structure
perl vcf2structure.pl 3a_indep_25k+25k+0_mask25k.vcf stru_list.txt > 3a_indep_25k+25k+0_mask25k.txt

#step2: prepare parafiles
#input_structure.txt ###output from step1 
#stru_list ###two colomns
#extraparams
#mainparams ###change first 4 lines
#run_structure.sh ###change inputfile name 
#seed.txt

	#mkdir result
	#mkdir resultlog

#step3: run structure
nohup sh run_stru.sh 1 &>>K1.log &
nohup sh run_stru.sh 2 &>>K2.log &
nohup sh run_stru.sh 3 &>>K3.log &
nohup sh run_stru.sh 4 &>>K4.log &
nohup sh run_stru.sh 5 &>>K5.log &
nohup sh run_stru.sh 6 &>>K6.log &
nohup sh run_stru.sh 7 &>>K7.log &
nohup sh run_stru.sh 8 &>>K8.log &

