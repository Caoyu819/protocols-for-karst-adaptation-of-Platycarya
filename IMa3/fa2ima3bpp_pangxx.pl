#!/usr/bin/perl -w
use strict;
use Getopt::Std;
my %opt;
&getopts("p:m:o:i:h",\%opt);
if(!exists $opt{p} || !exists $opt{m} || !exists $opt{o} || !exists $opt{i})
{
	print "perl xxx.pl -p path -m map -o outfile -i [1/2]\n";
	print "format for outfile: 1:BPP\t2:IMA3\n";
	exit;
}
my %map;
open (MAP,$opt{m})or die;
while(<MAP>)
{
	if(/(\S+)\s+(\S+)/)
	{
		$map{$1}=$2;
	}
}
close(MAP);

open (FILE,">$opt{o}")or die;
my @files=split/\n/,`ls $opt{p}`;
foreach my $f(@files)
{
	if($f=~/loci(\d*).phased.flt.ind.fa/)
	{
		my $loci=$1;
		my %seq;
		my %num;
		$/=">";
		open (FA,"$opt{p}/$f")or die ;
		while(<FA>)
		{
			chomp;
			if(/^((\S+)[ab])\n(\S+)/)
			{
				my ($id,$name,$seq)=($1,$2,$3);
				$seq{$id}=$seq;
				if($map{$name} eq "PL"){$num{"PL"}++;}
				else{$num{"PS"}++;}
			}
		}
		close(FA);
		$/="\n";
		my @t=keys %seq; my $len=length($seq{$t[0]});
		if($opt{i} == 1)
		{
			print FILE $num{PL}+$num{PS}."\t$len\n";
			foreach my $id (sort keys %seq)
			{print FILE "loci$loci^$id\t$seq{$id}\n";}
		}
		if($opt{i} == 2)
		{
			print FILE "loci$loci $num{PL} $num{PS} $len H 1.0 ".2.06e-9*$len."\n";
			foreach my $id (sort keys %seq)
			{print FILE "$id $seq{$id}\n";}
		}
	}
}
close(FILE);
