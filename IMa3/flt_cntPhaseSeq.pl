use strict;
use warnings;

#my ($in,$out)=@ARGV;
my ($in)=@ARGV;

my $seq;
my $id;
my $ambi;
open IN,"$in" or die "$!\n";
while (<IN>){
	chomp;
	if (/^>/){
		$id=$_;
	}
	else{
		$seq=$_;
		$ambi= $seq =~ tr/[RYSWKMN]//;
		if($ambi == 0){
			print "$id\n$seq\n";
		}
	}
}
