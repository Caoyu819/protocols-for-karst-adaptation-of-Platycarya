#perl substitude_orthname.pl orthlist nu orthseq
##!/usr/bin/perl
use warnings;
use strict;
my ($list,$nu,$orth) = @ARGV;
open LI,"$list" || die "$!\n";
while (<LI>){
	chomp;
	my @it = split /\t/,$_;
	`sed -i 's/$it[$nu]/$it[0]/g' $orth`
	#`sed -i 's/$it[2]/$it[0]/g' $orth`
}
