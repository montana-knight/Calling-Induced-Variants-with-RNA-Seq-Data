#!/bin/bash

gatk VariantFiltration -V vcf_file.vcf -O hardfiltered.vcf -R genomereference.fasta 

# now to apply your hard filters

# -V the vcf output file from mutect2 that was created during the variant call step
# -O your filtered vcf file output name
# -R your reference genome

## there are a lot of potential parameters you can filter on, see: https://gatk.broadinstitute.org/hc/en-us/articles/360037434691-VariantFiltration

# I suggest these to start: -window 35 -cluster 3 --filter-name DP -filter "DP < 10" --filter-name TLOD -filter "TLOD < 6.00"
