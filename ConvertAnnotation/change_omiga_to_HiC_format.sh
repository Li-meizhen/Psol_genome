#!/bin/bash

omigagff=$1
splitbin=$2
hicassembly=$3
hicgff=$4

# ------------------------change omiga gff format-------------------------#
sed s/.size[0-9]*.pilon// $omigagff | awk '{if($1~/#/) {} else {print}}' >${omigagff}".1"

# ------------------------change splitBin format +1 --------------------------#
perl change_splitBin_format.pl $splitbin >${splitbin}_corrected

# ------------------change original scaffolds to splitBin------------------#
perl gene2splitBin.pl ${splitbin}_corrected $omigagff".1" ${omigagff}_splitBin

# -------------------------remove splited genes ------------------------------#
awk '{if($1~/split/) {} else {print}}' ${omigagff}_splitBin >${omigagff}_splitBin_complete

# ------------------change splitBin to chromosome format-------------------#
perl splitBin2chromosome.pl $hicassembly ${omigagff}_splitBin_complete HiC_extra_exon.temp

# ---------------------remove not split exons in split genes----------------#
awk '{if($3=="exon") {print $9}}' HiC_extra_exon.temp |sed 's/.*\(PSOL[0-9]*\).*/\1/' |sort |uniq >all_exon.temp
awk '{if($3=="gene") {print $9}}' HiC_extra_exon.temp |sed 's/.*\(PSOL[0-9]*\).*/\1/' |sort |uniq >all_gene.temp
grep -F -v -f all_gene.temp all_exon.temp >extra_exon.temp
grep -F -v -f extra_exon.temp HiC_extra_exon.temp >HiC_not_sorted.temp

# ---------------------sort gff3 files by chr and loci----------------------#
sed -i 's/\tmaker/,\tmaker/' HiC_not_sorted.temp 
awk '{print $1}' HiC_not_sorted.temp |sort -u >sort_1_chr.temp 
awk '{if($3=="gene") {print }}' HiC_not_sorted.temp |sort -nk4,5 >sort_2_loci_sorted_genes.temp
for chr in `cat sort_1_chr.temp`; do grep $chr sort_2_loci_sorted_genes.temp >>sort_3_chr_sorted_genes.temp; done
sed 's/.*Name=//' sort_3_chr_sorted_genes.temp >sort_4_genelist.temp
for gene in `cat sort_4_genelist.temp`;do grep $gene HiC_not_sorted.temp >>$hicgff;done

# ----------------------- delete temp files--------------------------------#
mkdir original_files
mv $omigagff $splitbin $hicassembly original_files
mkdir tmp
mv $omigagff* *.temp $splitbin* $hicassembly* tmp