### Introduction
In some analyses, eg. genome synteny and ortholog assignment, we are supposed to only keep one alternative splicing isoform for each gene. Usually, we choose the longest one. Under most circumstances, we would use RefSeq genome annotation file (gff3) and protein sequences (fasta) for downstream analyses. This script was used to keep pick the longest isoform for each protein coding gene in RefSeq format.

### Usage
```bash
bash remove_alternative_splicing.sh dmel  # name_of_species
```

### File requirements
Only two input files needed: species.gff and species_protein.fasta. You can change "species" to any words, just  make sure these two files have same prefix. And also put the perl scripts remove_alternative_splicing.pl in the same dir/
