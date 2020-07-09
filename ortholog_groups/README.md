### Introduction
Scripts here were used to manipulate OrthoMCL output for downstream phylogenetic analysis. 

### Input file
OrthoMCL output: groups.txt
```
Group1000: Agla|XP_018562144.1 Apis|XP_008178240.1 Apis|XP_008178241.1 ...
Group1001: Aech|XP_011051860.1 Aech|XP_011051919.1 Agam|AGAP002865 Agam|AGAP002866 ...
```

### Usage
01_group_numbers.pl will convert OrthoMCL output to a readable table that records the number of genes in each group.

02_category_select.pl will seperate "numbers.txt" into different files, including "1:1:1.txt", "N:N:N.txt", "xxx-specific.txt", etc. Change the subfunctions as needed.

Then you can count the gene number in each file using 03_category_count.pl.

```bash
$ perl 01_group_numbers.pl groups.txt numbers.txt   # output file: numbers.txt
$ perl 02_category_select.pl numbers.txt
$ perl 03_category_count.pl
```

