#!/usr/bin/perl

use strict;
use warnings;

# usage perl  
# usage perl splitBin2chromosome.pl Hic_assembly.agp ogs_splitBin_complete.id ogs_chromosome.id
my %chr;
my %chr_start;
my %chr_end;
my %sca_start;
my %sca_end;
my %sca_string;

open IN1, "<$ARGV[0]" or die "Cannot find the split bin file!";
while (my $line = <IN1>){
     chomp ($line);
     my ($chromosome,$start1,$end1,$id,$start2,$end2,$orient)=split (/\s/,$line);
     $chr{$id}=$chromosome;
     $chr_start{$id}=$start1;
     $chr_end{$id}=$end1;
     $sca_start{$id}=$start2;
     $sca_end{$id}=$end2;
     $sca_string{$id}=$orient;
}
close IN1;

open IN2, "<$ARGV[1]" or die "Cannot find the transcript file!";
open OUT, ">$ARGV[2]";
while (my $line = <IN2>){
     chomp ($line);
     my $gene_exist=0;
#     my ($rnaid,$scaffold,$start,$end,$string)=split (/\s/,$line);
     my @infos=split(/\s/,$line);

     foreach my $key (sort keys %chr){
         if ($infos[0] eq $key) {
             $gene_exist=1;
             if($sca_string{$key} eq '+'){
                 my $newstart = $chr_start{$key} + $infos[3] - $sca_start{$key};
                 my $newend = $chr_start{$key} + $infos[4] - $sca_start{$key};
                 print OUT "$chr{$key}\t$infos[1]\t$infos[2]\t$newstart\t$newend\t$infos[5]\t$infos[6]\t$infos[7]\t$infos[8]\n";
             }
             else{
                 my $newstart1 = $chr_start{$key} + $sca_end{$key} - $infos[4];
                 my $newend1 = $chr_start{$key} + $sca_end{$key} - $infos[3];
                 if($infos[6] eq '+'){
                     print OUT "$chr{$key}\t$infos[1]\t$infos[2]\t$newstart1\t$newend1\t$infos[5]\t-\t$infos[7]\t$infos[8]\n";
                 }
                 else{
                     print OUT "$chr{$key}\t$infos[1]\t$infos[2]\t$newstart1\t$newend1\t$infos[5]\t+\t$infos[7]\t$infos[8]\n";
                 }

             }
         }
     }
     if ($gene_exist==0){
         print OUT "$infos[0]\t$infos[1]\t$infos[2]\t$infos[3]\t$infos[4]\t$infos[5]\t$infos[6]\t$infos[7]\t$infos[8]\n";
     }
}

close IN2;
close OUT;
