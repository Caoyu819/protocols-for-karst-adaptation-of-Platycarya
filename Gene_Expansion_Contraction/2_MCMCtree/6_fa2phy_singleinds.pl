#!/usr/bin/perl -w
use strict;
use Getopt::Std;
my %opt;
&getopts("i:p:o:h",\%opt);
if(!exists $opt{i} ||!exists $opt{p} || !exists $opt{o})
{
	print "perl xxx.pl -i inputfile -p path -o outfile\n";
	exit;
}

open (FILE,">$opt{p}/$opt{o}")or die;
#my @files=split/\n/,`ls $opt{p}`;
#foreach my $f(@files)
#{

my $f=$opt{i};
	if($f=~/OG.*\.nt_ali\.fasta/)
	{
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
#			if ($len >=800 && $len <=900){
#				print FILE "5	$len\n";
				print STDERR  "$f\t$len\n";
#=cut
				foreach my $id (sort keys %seq)
#				{print FILE ">$id\n$seq{$id}\n";}
				{print FILE ">$id\n$seq{$id}\n";}
#=cut
#			}
	}
#}
close(FILE);
