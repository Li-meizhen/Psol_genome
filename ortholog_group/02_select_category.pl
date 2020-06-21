#!/usr/bin/perl

# Usage: perl 01_category_select.pl numbers.txt
# Species: Aech Agam Agla Amel Apis Bmor Btab Clec Csol Dmel Dple Hhal Nvit Phum Plon Psol Rpro Tcas Turt

use strict;

my $file = $ARGV[0];
my @arr;

open IN, "<", $file or die "can't open $file!\n";
while (<IN>) {
    chomp();
    @arr = split(/\s/, $_);
    Is_1_1_1();
    Is_N_N_N();
    Is_SD();
    Is_mealybug();
    Is_Hemiptera();
    Is_Hymenoptera();
    Is_Lepidoptera();
    Is_Diptera();
    `echo $_ >>other.txt`;
}


sub Is0 {
    my ($num) = @_;
    if ($num==0) {
        return 0;
    }
    else{
        return 1;
    }
}

sub Is_Coleoptera {
    if ($arr[3]>=1 && $arr[18]>=1 && 
        $arr[1]+$arr[2]+$arr[4]+$arr[5]+$arr[6]+$arr[7]+$arr[8]+$arr[9]+$arr[10]+$arr[11]+$arr[12]+$arr[13]+$arr[14]+$arr[15]+$arr[16]+$arr[17]+$arr[19] == 0) {
        `echo $_ >>Coleoptera.txt`;
        next;
    }
}

sub Is_Diptera {
    if ($arr[2]>=1 && $arr[10]>=1 && 
        $arr[1]+$arr[3]+$arr[4]+$arr[5]+$arr[6]+$arr[7]+$arr[8]+$arr[9]+$arr[11]+$arr[12]+$arr[13]+$arr[14]+$arr[15]+$arr[16]+$arr[17]+$arr[18]+$arr[19] == 0) {
        `echo $_ >>Diptera.txt`;
        next;
    }
}

sub Is_Hemiptera {
    if (Is0($arr[5])+Is0($arr[7])+Is0($arr[15])+Is0($arr[16])+Is0($arr[8])+Is0($arr[12])+Is0($arr[17])>=5 && 
        $arr[1]+$arr[2]+$arr[3]+$arr[4]+$arr[6]+$arr[9]+$arr[10]+$arr[11]+$arr[13]+$arr[14]+$arr[18]+$arr[19] == 0) {
        my $test1=Is0($arr[5]);
        my $test2=Is0($arr[7]);
        my $test3=Is0($arr[15]);
        `echo $_ >>Hemiptera.txt`;
        next;
    }
}

sub Is_Hymenoptera {
    if (Is0($arr[1])+Is0($arr[4])+Is0($arr[9])+Is0($arr[13])>=3 && 
        $arr[2]+$arr[3]+$arr[5]+$arr[6]+$arr[7]+$arr[8]+$arr[10]+$arr[11]+$arr[12]+$arr[14]+$arr[15]+$arr[16]+$arr[17]+$arr[18]+$arr[19] == 0) {
        `echo $_ >>Hymenoptera.txt`;
        next;
    }
}

sub Is_Lepidoptera {
    if ($arr[6]>=1 && $arr[11]>=1 && 
        $arr[1]+$arr[2]+$arr[3]+$arr[4]+$arr[5]+$arr[7]+$arr[8]+$arr[9]+$arr[10]+$arr[12]+$arr[13]+$arr[14]+$arr[15]+$arr[16]+$arr[17]+$arr[18]+$arr[19] == 0) {
        `echo $_ >>Lepidoptera.txt`;
        next;
    }
}

sub Is_mealybug {
    if ($arr[15]>=1 && $arr[16]>=1 && 
        $arr[1]+$arr[2]+$arr[3]+$arr[4]+$arr[5]+$arr[6]+$arr[7]+$arr[8]+$arr[9]+$arr[10]+$arr[11]+$arr[12]+$arr[13]+$arr[14]+$arr[17]+$arr[18]+$arr[19] == 0) {
        `echo $_ >>mealybug.txt`;
        next;
    }
}

sub Is_SD {
    my $count_group = 0;
    for (my $i=1;$i<20;$i++){
        if($arr[$i] >= 1){
            $count_group += 1;
        }
    }
    if ($count_group == 1) {
        `echo $_ >>SD.txt`;
        next;
    }
}

sub Is_1_1_1 {
    my $count_single_copy = 0;
    for (my $i=1;$i<20;$i++){
        if ($arr[$i] == 1){
            $count_single_copy += 1;
        }
    }
    if ($count_single_copy == 19) {
        `echo $_ >>1-1-1.txt`;
        next;
    }
}

sub Is_N_N_N {
    my $count_group = 0;
    for (my $i=1;$i<20;$i++){
        if ($arr[$i] >= 1){
            $count_group += 1;
        }
    }
    if ($count_group >= 18 && $arr[14]>=1 && $arr[19] >=1) {
        `echo $_ >>N-N-N.txt`;
        next;
    }
}
