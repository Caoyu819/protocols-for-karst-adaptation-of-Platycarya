#usage: nohup perl run_ms.pl random_paras.5000 2>log_run_ms_par5000 &

#!/usr/bin/perl
use strict;
use warnings;
my ($par)=@ARGV;

open PAR,"$par" ||die "cannot open $par $!\n";
while(<PAR>){
	chomp;
	my @it=split / /,$_;
	my ($num, $res, $theta, $nuA, $nu1B, $nu1A, $nu2B, $nu2A, $alpha_pl, $alpha_ps, $Ta, $Tdiv, $Tms, $Tmt, $m12, $m21)=($it[0], $it[1], $it[2], $it[3], $it[4], $it[5], $it[6], $it[7], $it[8], $it[9], $it[10], $it[11], $it[12], $it[13], $it[14], $it[15]);
	#split with secondary contact then split (model1 in dadi)
	`ms 210 100 -I 2 88 122 -r $res 25000 -t $theta -g 1 $alpha_pl -g 2 $alpha_ps -n 1 $nu1A -n 2 $nu2A -em $Tmt 1 2 $m12 -em $Tmt 2 1 $m21 -em $Tms 1 2 0 -em $Tms 1 2 0 -ej $Tdiv 2 1 -en $Tdiv 1 $nuA -en $Ta 1 1 -threads 20 >outms/SCS.par$num".ms"`;
}
close PAR;
