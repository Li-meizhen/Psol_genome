#!/bin/bash

species="$1"

awk '{if(/^#/) {} else {print $1,$3,$4,$5,$9}}' $species.gff |grep " gene "|awk '{print $1,$3,$4,$5}' >${species}"_gene_temp1.gff"

awk '{if(/GeneID:([0-9]+);/) {print $0}}' ${species}"_gene_temp1.gff" |sed 's/ID\(.*\)GeneID:\([0-9]*\);\(.*\)/LOC\2/g' >${species}"_gene_temp2.gff"

awk '{if(/^#/) {} else {print $3,$9}}' $species.gff |grep "CDS " >${species}"_cds_temp1.gff"

sed 's/\(.*\)GeneID:\([0-9]*\)\(.*\)Name=\([A-Z]*_[0-9]*\.[0-9]\)\(.*\)/LOC\2 \4/g' ${species}"_cds_temp1.gff" >${species}"_cds_temp2.gff"

sort ${species}"_cds_temp2.gff" |uniq >${species}"_cds_temp3.gff"

perl remove_alternative_splicing.pl ${species}"_protein.fasta" ${species}"_cds_temp3.gff" ${species}"_gene_temp2.gff" ${species}"_altered_gene.gff" ${species}"_altered_protein.fasta" 

mkdir ${species}"_temp_file"

mv $species.gff ${species}"_gene_temp1.gff" ${species}"_gene_temp2.gff" ${species}"_cds_temp1.gff" ${species}"_cds_temp2.gff" ${species}"_cds_temp3.gff" ${species}"_protein.fasta" ./${species}"_temp_file"

