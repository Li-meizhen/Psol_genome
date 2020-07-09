### Introduction
If we got different versions of genome assembly, it's much easier to simply convert gene annotation file (gff3) than conduct gene annotation all over again. This an example of how to convert annotations of draft genome assembly (annotated using OMIGA pipeline) to Hi-C assembly. In the other words, scaffolds from draft assembly were assigned to chromosomes in Hi-C assembly.

### Usage
```bash
bash change_omiga_to_HiC_format.sh Pacbio.gff3 split_bin HiC_assembly.agp HiC_V3_CompleteGeneOnly.gff3
```

### File requirements
First, we need the original gff3 file, which is formatted like this:
```
##sequence-region scaffold1 1 7026800
scaffold1     maker   gene    1433    3852    .       +       .       ID=PSOL00001;Name=PSOL00001
scaffold1     maker   mRNA    1433    3852    .       +       .       ID=PSOL00001-TA;Name=PSOL00001-TA;Parent=PSOL00001
scaffold1     maker   exon    1433    1584    .       +       .       ID=PSOL00001-TA:exon1;Name=PSOL00001-TA:exon1;Parent=PSOL00001-TA
scaffold1     maker   exon    1660    1807    .       +       .       ID=PSOL00001-TA:exon2;Name=PSOL00001-TA:exon2;Parent=PSOL00001-TA
scaffold1     maker   CDS     1433    1584    .       +       0       ID=PSOL00001-TA:cds;Name=PSOL00001-TA:cds;Parent=PSOL00001-TA
scaffold1     maker   CDS     1660    1807    .       +       1       ID=PSOL00001-TA:cds;Name=PSOL00001-TA:cds;Parent=PSOL00001-TA
```

If Hi-C data was used to correct draft assembly first, some of the scaffolds in draft genome would be split up as indicated in the "splitBin" file (as follows). Sometimes the original splitBin file was not formatted correctly, i.e. it contained 1bp overlap at left end. We will deal with this later.

```
scaffold1       scaffold1_2     100000  400000  300000
scaffold1       scaffold1_1_2   60000   100000  40000
scaffold1       scaffold1_1     1       60000   60000
```

Finally, we need to provide the Hi-C assembly file. It recorded how the split bins and scaffolds were assigned to each chromosome.
```
chr1    1       20000   scaffold4_3     1       20000   +
chr1    20101   80100   scaffold95_1    1       60000   -
```
