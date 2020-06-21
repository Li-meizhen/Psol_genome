#!/usr/bin/perl
use strict;
use warnings;

# Usage: perl category_count.pl

my @category_files = qw/1-1-1 N-N-N mealybug Hemiptera Coleoptera Diptera Lepidoptera Hymenoptera SD other/;
my @category_count;

foreach(@category_files){
    @category_count = qw/0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0/;
    $category_count[0] = $_;
    open IN, "<", "$_.txt";
    while (<IN>) {
        chomp();
        my @array = split(/\s/, $_);
        for(my $i=1;$i<@category_count;$i++){
            $category_count[$i] += $array[$i];
        }
    }
    close IN;
    open OUT, ">>", "category_count.txt" or die "category_count.txt\n";
    for(my $i=0;$i<@category_count;$i++){
        print OUT "$category_count[$i]\t";
    }
    print OUT "\n";
    close OUT;
}

my @total_gene_number = qw/0 11219 13024 13907 10741 18614 13804 13914 14083 9823 13929 15130 14501 13356 10786 20768 11880 15064 12875 11503/;

open IN, "<", "category_count.txt" or die "can't open category_count.txt!\n";
@category_count = qw/0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0/;
$category_count[0] = "ND";
while (<IN>) {
    chomp();
    my @array = split(/\s/, $_);
    for(my $i=1;$i<@category_count;$i++){
        $category_count[$i] += $array[$i];
    }
}

for(my $i=1;$i<@category_count;$i++){
    $category_count[$i] = $total_gene_number[$i] - $category_count[$i];
}
close IN;

open OUT, ">>", "category_count.txt" or die "can't open category_count.txt!\n";
for(my $i=0;$i<@category_count;$i++){
    print OUT "$category_count[$i]\t";
}
print OUT "\n";
close OUT;
