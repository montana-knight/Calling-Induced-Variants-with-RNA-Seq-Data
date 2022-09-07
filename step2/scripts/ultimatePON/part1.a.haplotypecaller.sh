#!/bin/bash

gatk HaplotypeCaller --input bam_filename.bam --output output_filename.g.vcf --reference genome.fasta -ERC GVCF

# the input file here is the output file from the splitncigar reads tool
# https://gatk.broadinstitute.org/hc/en-us/articles/360037225632-HaplotypeCaller

# haplotype caller calls germline variants within your samples, perform on each sample

# there is a parameter "heterozygosity" which should be set to a low value when working with an inbred species
