#!/bin/bash

gatk GenotypeGVCFs --R genome.fasta -V gendb://hapcall_pon_dir -O output.vcf
