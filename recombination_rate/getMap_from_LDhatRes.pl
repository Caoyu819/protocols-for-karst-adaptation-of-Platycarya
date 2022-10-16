#usage: perl xxx.plp blocklist Resfile_Dir(in current directory) Ne
use strict;
use warnings;

my ($blocklist,$resdir,$Ne,$mapF,$resF)=@ARGV;

my $flag="NULL";
my $sumd=0;
my $num=0;
open MAP,">$mapF" or die "$!\n";
open RES,">$resF" or die "$!\n";

open LI,$blocklist or die "$!\n";
while (<LI>){
	chomp;
#	push @blist,$_;
	my $prefix=$_;
	my $resfile="./$resdir/$prefix\_res.txt";
#	print "$resfile\n";

	$prefix=~ /(.*)_block\d+.*/;
	my $chrid=$1;
	if ($chrid ne $flag){
		$sumd=0;
		$num=0;
	}
	$flag=$chrid;

	open IN,$resfile or die "$!\n";
	while (<IN>){
        	chomp;
		next if (/Loci/ || /\-1\.000/);
        	my @it=split /\t/;
		my $pos=$it[0]*1000;
		my $rho=$it[1];
                my $d=1/4*log((2*$Ne+$rho)/(2*$Ne-$rho));
		my $res=$rho/(4*$Ne);
		$num += 1;
#=cut		
		if ($num == 1){
                	$d=0;
        	}
#=cut
		$sumd += $d;
#		print "$chrid\:$flag:$num\t$chrid:$pos\t$sumd\t$pos\n";
		print MAP "$chrid\t$chrid:$pos\t$sumd\t$pos\n";
		print RES "$chrid\t$chrid:$pos\t$rho\t$res\n";
	}

	close IN;
}
close LI;
close MAP;
close RES;

