#!/bin/bash

gatk GenotypeGVCFs --R genome.fasta -V gendb://workspace_dir_name -O output.vcf

# the genotypegvcfs tool is for the vcf files from haplotype caller. you need to use this tool after you create a genomicdb with
# those files (see the genomicsdbimport script).

# this step is needed to perform JOINT genotyping (ie, what are the germline mutations among the samples, as called by haplotype caller)

# https://gatk.broadinstitute.org/hc/en-us/articles/360037057852-GenotypeGVCFs

# you will need to also run the "create somatic panel of normals" tool after this
