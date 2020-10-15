#!/bin/bash

STAR --genomeDir genome_directory --readFilesIn fastq_file_01.fastq fastq_file_02.fastq --outFileNamePrefix output_prefix_name --outSAMtype BAM Unsorted SortedByCoordinate --alignIntronMax ## --outSAMattributes All --outFilterMultimapNmax ## --outFilterMismatchNmax ##

# genomeDir the genome directory created in the previous genome generate step
# readFilesIn the fastq files for each sample. If you have paired end data then put both files here, if you have single end then only one file will go here
# outFileNamePrefix what you want the output alignment file to be called
# outSAMtype the kind of alignment file you want as output, on this pipeline we wanted to types of BAM file, both the unsorted and sorted by coordinate
# alignIntronMax the max intron size you realistically expect. STAR's default can lead to very large introns so you may want to add something more realistic here
# outSAMattributes the tags you want each read alignment to have, we wanted all of them so that we could get all the information we might need
# outFilterMultimapNmax the max number of places a read can max, after that it will be considered unmapped
# outFilterMismatchNmax the max number of mismatches per read before the read is no longer considered a match

## READ ME:
## you're going to run this command twice. Once on the original genome directory you made, and then again for the second pass using the second
## genome directory you make!
