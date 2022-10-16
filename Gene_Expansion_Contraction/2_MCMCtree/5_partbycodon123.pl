#!/usr/bin/perl -w
my ($prefix,$outdir)=@ARGV;
`mkdir -p $outdir`;
open IN,"$prefix.align.fa" || die;
my %seqs;
my $id;
while(<IN>){
	chomp;
	if(/>/){
	    s/>//g;
	    $id = $_;
	}else{
	    $seqs{$id} .= $_;
	}
}
close IN;

open OUT12,">./$outdir/$prefix.12.fa" || die;
open OUT1,">./$outdir/$prefix.1.fa" || die;
open OUT2,">./$outdir/$prefix.2.fa" || die;
open OUT3, ">./$outdir/$prefix.3.fa" || die;
foreach my $key (sort keys %seqs){
	my $v = $seqs{$key};
	my $len = length($v) - 3;
	print OUT12 ">$key\n";
	print OUT1 ">$key\n";
	print OUT2 ">$key\n";
	print OUT3 ">$key\n";
	my $codon12;
	my $codon1;
	my $codon2;
	my $codon3;
	for (my $i=0;$i<=$len;$i+=3){
                $codon12 .= substr($v,$i,2);
		$codon1 .= substr($v,$i,1);
		my $t = $i +1;
		$codon2 .= substr($v,$t,1);
		my $tt = $i +2;
		$codon3 .= substr($v,$tt,1);
	}
	print OUT12 "$codon12\n";
	print OUT1 "$codon1\n";
	print OUT2 "$codon2\n";
	print OUT3 "$codon3\n";
}
close OUT12;
close OUT1;
close OUT2;
close OUT3;


