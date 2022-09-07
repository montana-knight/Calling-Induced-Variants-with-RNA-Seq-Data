#!/bin/bash

gatk VariantFiltration -V vcf_file.vcf -O hardfiltered.vcf -R genomereference.fasta 

# now to apply your hard filters

# -V the vcf output file from mutect2 that was created during the variant call step
# -O your filtered vcf file output name
# -R your reference genome

## there are a lot of potential parameters you can filter on, see: https://gatk.broadinstitute.org/hc/en-us/articles/360037434691-VariantFiltration

# I suggest these to start: -window 35 -cluster 3 --filter-name DP -filter "DP < 10" --filter-name TLOD -filter "TLOD < 6.00"


#### you also may want to inspect how many of your variants were in your ultimate PON. but eventually you 
#### do want to filter them out. You also need to filter out variant calls which did not pass the 
#### variant filtration step. the above line is only going to mark them. You can filter them out using 
#### these two lines:


grep -v PON hardfiltered.vcf >hardfiltered.vcf # get rid of any variants marked in the PON

grep -e "#" -e PASS hardfiltered.vcf >hardfiltered.vcf # only keep the header and variants which passed
