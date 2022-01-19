#!/bin/bash

gatk VariantFiltration -V vcf_file.vcf -O mutect2/$filename.mutect.filtered.vcf -R /home3/mknight/SpaceRadiation/TAIR10_chr_all.fasta -window 35 -cluster 3 --filter-name DP -filter "DP < 10" --filter-name TLOD -filter "TLOD < 6.00"
