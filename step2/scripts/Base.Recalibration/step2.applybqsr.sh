#!/bin/bash

gatk ApplyBQSR -I sample_bamfile.bam -R reference.fasta --bqsr-recal-file baserecaltable.table -O baserecal.adjusted.bamfile.bam

# ApplyBQSR is a tool that takes the individual bam files and the previously created base recalibration table (created
# using BaseRecalibrator) and adjust base accuracy calls so that variants can be called more accurately.

# https://gatk.broadinstitute.org/hc/en-us/articles/360035890531-Base-Quality-Score-Recalibration-BQSR-
# https://gatk.broadinstitute.org/hc/en-us/articles/360037268511-ApplyBQSR

# -I input bam file, from the output of splitncigar reads
# -R reference genome
# --bqsr-recal-file base recalibration table from the BaseRecalibrator step
# -O base recalibrated output filename
