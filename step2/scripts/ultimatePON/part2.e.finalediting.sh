#!/bin/bash

# The end of this set of scripts will give you an "Ultimate Panel of Normals" from the final R script. It will be missing the 
# normal vcf header so you will need to attach that from another file. For example you can pull out all of the header 
# by doing something like this:

grep "#" somevcffile.vcf >header.txt

# Then attach that header to your ultimate pon and create a vcf version of you file.

cat header.txt ultimatepon.tsv >ultimatepon.vcf # ultimatepon.tsv is the ultimate pon from the r script

# you will also need to index it, this is necessary for any future run of any GATK tool

gatk IndexFeatureFile -I ultimatePON.vcf

# https://gatk.broadinstitute.org/hc/en-us/articles/360037428111-IndexFeatureFile
