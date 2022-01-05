#!/bin/bash

gatk CreateSomaticPanelOfNormals -R genome.fasta -V vcf_file.vcf -O output_pon_file.vcf

# https://gatk.broadinstitute.org/hc/en-us/articles/360037058172-CreateSomaticPanelOfNormals-BETA-

# this tool creates a panel of normals using a group of vcf files
# the goal is to identify all germline mutations among the samples
# this way we can avoid germline mutations later on when we are counting the number of variants called
# we are going to run this twice, on the vcf files from haplotypecaller and
# those from mutect2.
# then we will use a custom script to combine them.
