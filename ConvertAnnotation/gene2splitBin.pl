#!/usr/bin/perl
use strict;
use warnings;

#usage perl gene2splitBin.pl split_bin.txt gene/transcript_file($rnaid,$scaffold,$start,$end,$string1) output_file

my %old_scaffold;
my %bin_start;
my %bin_end;

open IN1, "<$ARGV[0]" or die "Cannot find the split bin file!";
while (my $line = <IN1>){
     chomp ($line);
     my ($oldid,$newid,$start1,$end1,$len)=split (/\s/,$line);
     $old_scaffold{$newid}=$oldid;
     $bin_start{$newid}=$start1;
     $bin_end{$newid}=$end1;
}
close IN1;

open IN2, "<$ARGV[1]" or die "Cannot find the transcript file!";
open OUT, ">$ARGV[2]";
while (my $line = <IN2>){
     chomp ($line);
     my $scaffold_exist=0;
     my $gene_exist=0;
     my @infos = split (/\s/,$line);
     #my ($rnaid,$scaffold,$start,$end,$string1)=split (/\s/,$line); #print "$rnaid $scaffold $start $end $string1\n";
     foreach my $key (keys %old_scaffold){
         if ($old_scaffold{$key} eq $infos[0]) {
             $scaffold_exist=1;
             if( ($infos[3] > $bin_end{$key}) || ($infos[4] < $bin_start{$key}) ) {
                  next;
             }
             if( ($infos[3] > $bin_start{$key}) && ($infos[4] < $bin_end{$key}) ){
                  $gene_exist=1;
                  my $new_start = $infos[3] - $bin_start{$key} +1;
                  my $new_end = $infos[4] - $bin_start{$key} +1;  
                  print OUT "$key\t$infos[1]\t$infos[2]\t$new_start\t$new_end\t$infos[5]\t$infos[6]\t$infos[7]\t$infos[8]\n";
                  #print OUT "$rnaid $key $new_start $new_end $string1\n";
                  last;
             }
         }
     }
     if ($scaffold_exist == 0){
         print OUT "$infos[0]\t$infos[1]\t$infos[2]\t$infos[3]\t$infos[4]\t$infos[5]\t$infos[6]\t$infos[7]\t$infos[8]\n";
     } 
     elsif ($gene_exist == 0){
         print OUT "split gene: $infos[0]\t$infos[1]\t$infos[2]\t$infos[3]\t$infos[4]\t$infos[5]\t$infos[6]\t$infos[7]\t$infos[8]\n";
     }  
 }

close IN2;
close OUT;

