#!/bin/bash

STAR --runMode genomeGenerate --genomeDir genome_directory --genomeFastaFiles genome_in_fasta_format.fasta --sjdbGTFfile genome_annotation_file.gtf --genomeSAindexNbases 12

# first step in running a STAR alignment in to create a genome directory STAR uses to do the alignment
# --runMode genomeGenerate is the tag needed to tell STAR you're creating a genome directory
# --genomeDir tag is the name of the genome directory you'll be creating
# --genomeFastaFiles the genome in fasta format
# --sjdbGTFfile is the genome annotation file, if you have it
# --genomeSAindexNbases is a tag that may be necessary if you have a smaller genome/working with an organism with a smaller genome
