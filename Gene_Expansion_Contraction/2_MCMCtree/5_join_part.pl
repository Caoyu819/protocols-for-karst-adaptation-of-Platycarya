#!/usr/bin/perl
use warnings;
use strict;

my ($file_list,$indir,$table,$fasta,$limit)=@ARGV;
open FASTA,">$fasta" || die "cant write into $!\n";
open TABLE,">$table" || die "cant write into $!\n";

open LI,$file_list ||die "$!\n";
my @files;
while(<LI>){
	chomp;
	push @files,$_;
}

my %final_seq;
my $last=1;
my $n=0;
my $id;

foreach my $file (@files){
my %seq;
open FA,"./$indir/$file" || die "no file :$!\n";
while(<FA>){
	chomp;
	next if (/^\s/);
	#print "$_\n";
	if(/^\>/){
		my $current_ids=$_;
		  #add ID filter
		  $current_ids =~ s/[\>\-\.]//g;
		  if($current_ids=~/\|/){
			$current_ids=(split(/\|/,$current_ids))[0];
		  }
		  $current_ids.="          ";
		  $current_ids=substr($current_ids,0,14);
		  #end of ID filter
                $id=$current_ids;
                $seq{$id} = "";
        }else{
                my $line=$_;
		$line =~ s/\s//g;
                $line =~ tr/acgtn/ACGTN/;
		#print "$line\n";
                $seq{$id}.=$line;
        }
}
close FA;
my $length = length($seq{$id});
next if ($length < $limit);
my $file_id=$file;
$file_id =~ s/\.align\.fa//; #2.fa-gb
$n+=$length;
print TABLE "$file_id = $last - $n;\n";
$last=$n+1;

foreach my $key (sort keys %seq){
	$final_seq{$key}.=$seq{$key};
}

}#foreach
my $num = keys  %final_seq;
my $final_len=length($final_seq{$id});
print FASTA "$num  $final_len\n";
while(my ($k,$v) = each %final_seq){
	$k =~ s/>//g;
	print FASTA "$k  $v\n";
}


