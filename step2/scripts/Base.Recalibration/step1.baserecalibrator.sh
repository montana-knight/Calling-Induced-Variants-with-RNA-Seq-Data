#!/bin/bash

gatk BaseRecalibrator -I sample_bam_file.bam -O output_baserecal.table -R genome.fasta --known-sites ultimatePON.vcf

# this first BaseRecalibrator tool takes a bam file and examines bases in it for things like which cycle the base was in, is it part of 
# a dinucleotide, etc... and it re-evaluates the accuracy of the call and then creates a table that will be applied
# using ApplyBQSR. Base scores will be re-evaluated.

# https://gatk.broadinstitute.org/hc/en-us/articles/360035890531-Base-Quality-Score-Recalibration-BQSR-
# https://gatk.broadinstitute.org/hc/en-us/articles/360036898312-BaseRecalibrator

# -I is the input bam file, from the output of split n cigar reads. Reminder you will be doing this on every single sample's bam file
# -O whatever you want the output base recalibration table to be called
# -R reference genome
# --known-sites a known set of mutations, if you do not have one for your species then create your own using the ultimate pon steps

