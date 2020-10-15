#!/bin/bash

STAR --runMode genomeGenerate --genomeDir 2ndpass_genome_directory --genomeFastaFiles genome.fasta --sjdbGTFfile genome_annotation.gtf --genomeSAindexNbases 12 --sjdbFileChrStartEnd output_1stpass/*SJ.out.tab

## this is very similar to the first genome generate, with the exception of the --sjdbFileChrStartEnd output_1stpass/*SJ.out.tab tag. This takes all of the SJ.out.tab outputs for each fastq file which was
## aligned in the first pass and uses them to rebuild the genome better accounting for splice sites and the area around them
