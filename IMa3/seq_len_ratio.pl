#!/usr/bin/perl -w
use strict;
open (FA,"$ARGV[0]") or die;
my $origin=$/;
$/=">";
my $scaf_name;
my %FA=();
while (my $part=<FA>)
{
        chomp $part;
        next if ($part =~ /^>/);
        if($part=~/(.*?)\n(.*)/s){
                $scaf_name=$1;
                $FA{$scaf_name}=$2;
                $FA{$scaf_name}=~s/\n//g;
	}   
}
$/=$origin;
close (FA);
print "scaffold\tlength\tA_ratio\tT_ratio\tG_ratio\tC_ratio\tGC_ratio\tN_num\tN_ration\tO_num\tO_ratio\n";
#foreach my $i (keys %FA)
foreach my $i (sort{$a cmp $b} keys %FA)
#foreach$name(sort{$a cmp $b} keys %seq ){
{
	print">$i\t";
	my $C_num=0;
        my $C_ratio=0;
	my $A_num=0;
        my $A_ratio=0;
	my $G_num=0;
        my $G_ratio=0;
	my $GC_num=0;
        my $GC_ratio=0;
	my $T_num=0;
        my $T_ratio=0;
	my $N_num=0;
        my $N_ratio=0;
        my $O_num=0;
        my $O_ratio=0;
	my $ss=$FA{$i};
	my$len=length($ss);
	print"$len\t";
	if($ss =~/A/s){
	$A_num+= $ss =~ tr/A/A/;
        $A_ratio=$A_num/$len;
        $A_ratio=sprintf"%.3f",$A_ratio;
	print"$A_ratio%\t";}
#	print"A:$A_num\t\t";}
	if($ss =~/T/s){
	$T_num+= $ss =~ tr/T/T/;
        $T_ratio=$T_num/$len;
        $T_ratio=sprintf"%.3f",$T_ratio;
	print"$T_ratio%\t";}
#       print"T:$T_num\t\t";}
	if($ss =~/G/s){
	$G_num+= $ss =~ tr/G/G/;
        $G_ratio=$G_num/$len;
        $G_ratio=sprintf"%.3f",$G_ratio;
	print"$G_ratio%\t";}
#       print"G:$G_num\t\t";}
	if($ss =~/C/s){
	$C_num+= $ss =~ tr/C/C/;
        $C_ratio=$C_num/$len;
        $C_ratio=sprintf"%.3f",$C_ratio;
	print"$C_ratio%\t";}
#	print"C:$C_num\t\t";}
        $GC_num=$G_num+$C_num;
        $GC_ratio=$GC_num/$len;
        $GC_ratio=sprintf"%.3f",$GC_ratio;
        print"$GC_ratio%\t";
	if($ss =~/N/s){
	$N_num+= $ss =~ tr/N/N/;
        $N_ratio=$N_num/$len;
        $N_ratio=sprintf"%.3f",$N_ratio;
	print"$N_num\t$N_ratio%\t";}
#	print"N;$N_num\n";}
        $O_num=$len-($A_num+$G_num+$T_num+$C_num+$N_num);
        $O_ratio=$O_num/$len;
        $O_ratio=sprintf"%.3f",$O_ratio;
        print"$O_num\t$O_ratio%\t\n";
}
