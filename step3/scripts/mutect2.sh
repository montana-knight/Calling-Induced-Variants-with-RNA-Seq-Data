#!/bin/bash

gatk Mutect2 -R genome.fasta -I alignment_file.bam --panel-of-normals ultimatePON.vcf -O mutect2vcffile.vcf

# Mutect2 was our variant caller of choice. You can run it using only your sample (without a paired normal tissue sample).
# There are many additional options you can use when using this tool, for example we included the parameter "--max-num-haplotypes-in-population"
# The main parameters required/we suggest are the reference genome (-R), the alignment file (-I), the 
# panel of normals (--panel-of-normals), and the output filename (-O)

# the PON is not required but highly suggested in order to filter out likely germline mutations (remember we are interested
# in somatic mutation accumulation due to environmental stress conditions

# https://gatk.broadinstitute.org/hc/en-us/articles/360037593851-Mutect2
