use warnings;
use strict;
my ($genelist,$indlist,$genefadir,$outdir) = @ARGV;
#my ($genelist,$indlist) = @ARGV;
#`mkdir -p $outdir`;
open LI,$genelist or die "$!\n";
my @glist;
while (<LI>){
	chomp;
	push @glist,$_;
}
close LI;
open IND,$indlist or die "$!\n";
while (<IND>){
	chomp;
	&getSeq($_);
}
close IND;
sub getSeq(){
	my $prefix = shift;
	my $file = "./$genefadir/$prefix.orth.cds";
#	my $file = "./$genefadir/$prefix.orth.pep";
	my $id = '';
	open IN,$file or die "$!\n";
	my $flag = 0;
	while (<IN>){
		chomp;
		if(/>/){
			s/\>//g;
			$_ =~ s/\t.*$//g;
			$id=$_;
			if (grep /^$id$/,@glist){
				$flag = 1;
			}else{
				$flag = 0;
			}
		}elsif($flag == 1){
			s/\s//g;
			open OUT,">>$outdir/$id.ind.fa" or die "$!\n";
#			open OUT,">>$outdir/$id.ind.pep" or die "$!\n";
			print OUT ">$prefix\n$_\n";
			close OUT;
		}
	}
	close IN;
}
