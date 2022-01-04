#!/bin/bash

gatk SplitNCigarReads -R ~/genome.fasta -I bam_filename.bam -O output_bam_filename.bam

# https://gatk.broadinstitute.org/hc/en-us/articles/360036858811-SplitNCigarReads

# splitncigarreads

# notes: the input bam file here needs to have the read groups already added to it, see the addreplacedreadgroups.sh file

# GATK's SplitNCigarReads reassesses nucleotides surrounding splice sites and is an essential step in calling variants from 
# RNA-Seq data. Reads will be split up based on the parts of the read that map before an intron (N) and after (N). 
# Overhangs in intronic regions will then be clipped. This will eliminate any variants which otherwise would have been falsely 
# called in these regions.
