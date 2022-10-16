#usage: perl XXX.pl in out

#!/usr/bin/perl
use warnings;
use strict;
my($file,$flt_out)=@ARGV;

open OUT,">$flt_out"|| die "$!\n";
open IN,"$file"|| die "$!\n";
#print OUT "CHROM_BIN_START_BIN_END\tCHROM\tBIN_START\tNUM_SNP\tMEAN_FST_PL-PS\td_TajimaD\tROD\n";
print OUT "CHROM_BIN_START_BIN_END\tCHROM\tBIN_START\tMEAN_FST_PL-PS\td_TajimaD\tROD\n";
readline IN;
while(<IN>){
chomp;
	my @it = split(/\t/);
	my $dTD = $it[7]-$it[6];
	my $dPI = $it[9]/$it[8];
	print OUT "$it[0]\t$it[1]\t$it[2]\t$it[5]\t$dTD\t$dPI\n";
}
close IN;
close OUT;
