#!usr/bin/perl
use strict;
use warnings;

my %hash;
my $header;
my $seq = "";
#my $fastaFile = "$ARGV[0]";
my %seq;
open IN, "<$ARGV[0]" or die "Cannot find the specified fasta file!";
while(my $line=<IN>){
        chomp($line);
        if ($line=~/^>([A-Z]+_[0-9]+.[0-9])/){ #the header line
                if (length $seq > 0){ #not the first line
                        $seq{$header} = $seq;
                }
                $header = $1; #remove >
                $seq = "";
        }else{
                $seq.=$line;
        }
}
$seq{$header} = $seq;
close IN;


open FILE, "<$ARGV[1]";

while (my $line = <FILE>){
     chomp ($line);
         
         my ($gene,$protein)=split (/\s/,$line);
         if(!exists $hash{$gene}){
            $hash{$gene}=$protein;
         }
         else{
            my $protein_old=$hash{$gene};
            my $length_old=length($seq{$protein_old});
            
            my $length_new=length($seq{$protein});
            if ($length_new > $length_old) {
                $hash{$gene}=$protein;
                delete $seq{$protein_old};
            }
            else {
                delete $seq{$protein};
            }
         }
         
     }
close FILE;

open FILE, "<$ARGV[2]";
open OUT1,">$ARGV[3]";
while (my $line = <FILE>){
     chomp ($line);
         my ($chr,$start,$end,$gene)=split (/\s/,$line);
         if (exists $hash{$gene}){
             print OUT1 "$chr $hash{$gene} $start $end\n";
            }

         else {print OUT1 "$chr $gene $start $end\n";}      
}
close FILE;
close OUT1;

open OUT2, ">$ARGV[4]";
foreach my $bb (keys %seq){
   print OUT2 ">",$bb,"\n",$seq{$bb},"\n";
}
