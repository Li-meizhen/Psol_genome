#!/usr/bin/perl
use strict;
use warnings;

# Usage: perl 01_group_numbers.pl groups.txt numbers.txt

my @array_name = qw /Aech Agam Agla Amel Apis Bmor Btab Clec Csol Dmel Dple Hhal Nvit Phum Plon Psol Rpro Tcas Turt/;

open IN, "<", $ARGV[0] or die "Cannot find the file!";
open OUT, ">", "$ARGV[1]";
while (<IN>) {
	chomp();
	my @array=split/\s+/,$_;
	my $group=shift @array;
	my @array_a;
	foreach (@array) {
		 my @a = split /\|/,$_;
		push @array_a, $a[0]; 
	}
	my %hash;
	foreach(@array_a){
		$hash{$_}=0 unless exists $hash{$_};
		$hash{$_}+=1;
	}
	my @out;
	foreach(@array_name){
		$hash{$_}=0 unless exists $hash{$_};
		push @out,$hash{$_};
	}
	my $result = join "\t", @out;
	print OUT $group."\t".$result."\n";	
}
close IN;
close OUT;



