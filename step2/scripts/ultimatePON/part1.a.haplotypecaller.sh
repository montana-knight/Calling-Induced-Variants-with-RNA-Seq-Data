#!/bin/bash

gatk HaplotypeCaller --input bam_filename.bam --output output_filename.g.vcf --reference genome.fasta --heterozygosity 0.0001 -ERC GVCF

# the input file here is the output file from the splitncigar reads tool
# https://gatk.broadinstitute.org/hc/en-us/articles/360037225632-HaplotypeCaller

# haplotype caller calls germline variants within your samples, perform on each sample
