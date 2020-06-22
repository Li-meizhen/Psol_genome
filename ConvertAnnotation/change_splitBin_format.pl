#!/usr/bin/perl

use strict;
use warnings;

open IN1, "<$ARGV[0]" or die "Cannot find the split bin file!";
while (my $line = <IN1>){
     chomp ($line);
     my ($oldid,$newid,$start1,$end1,$len)=split (/\s/,$line);
     if ($newid =~ /scaffold[0-9]+_1\b/){
     	print "$oldid $newid $start1 $end1 $len\n";
     }
     else {
     	my $start=$start1+1;
     	print "$oldid $newid $start $end1 $len\n";
     }
}
