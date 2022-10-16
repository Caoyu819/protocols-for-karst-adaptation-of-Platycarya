#!/usr/bin/perl -w
use strict;
use Getopt::Std;
my %opt;
&getopts("p:o:h",\%opt);
if(!exists $opt{p} || !exists $opt{o})
{
	print "perl xxx.pl -p path -o outfile\n";
	exit;
}

open (FILE,">$opt{o}")or die;
my @files=split/\n/,`ls $opt{p}`;
foreach my $f(@files)
{
	if($f=~/(.*).align.fa/)
	{
		my $loci=$1;
		my %seq;
		my $id;
		open (FA,"$opt{p}/$f")or die ;
		while(<FA>)
		{
			chomp;
=cut		
			if(/^(\S+)\n(\S+)/)
			{
				my ($id,$seq)=($1,$2);
				$seq =~ tr/\n//;
				$seq{$id}.=$seq;
			#	print "$id\t$seq{$id}\n";
			}
=cut
			if(/>/){
				s/\>//g;
				$id=$_;
			}else{
				s/\s//g;
				$seq{$id} .= $_;
			}
		}
		close(FA);
		my @t=keys %seq; my $len=length($seq{$t[0]});
			print FILE "5\t$len\n";
#=cut
			foreach my $id (sort keys %seq)
			{print FILE "$id\t$seq{$id}\n";}
#=cut
	}
}
close(FILE);
