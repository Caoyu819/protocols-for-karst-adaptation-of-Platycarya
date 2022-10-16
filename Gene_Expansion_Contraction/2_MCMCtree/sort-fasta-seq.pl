#!/usr/bin/perl

my %h;
my $i;
while(<>){
	chomp;
	if(/>/){
		$id=$_;
	}else{
		my $line=uc($_);
		$h{$id}.=$line;
	}
}

foreach my $k (sort keys %h){
	print "$k\n$h{$k}\n";
}

