#!/bin/bash

gatk Mutect2 -R genome.fasta -I bam_filename.bam -O output_filename.vcf.gz

# in reality this is run parallel to haplotype caller
# the input file is the output file from te splitncigarreads tool
# the .gz tag in the output file zips it up

# https://gatk.broadinstitute.org/hc/en-us/articles/360037593851-Mutect2

# the --max-num-haplotypes-in-population should be set to a low value to accomodate a highly inbred species
