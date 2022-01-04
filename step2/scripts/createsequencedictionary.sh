#!/bin/bash

gatk CreateSequenceDictionary -R ~/TAIR10_chr_all.fasta

# -R is the reference file, the genome in fasta format

# https://gatk.broadinstitute.org/hc/en-us/articles/360037068312-CreateSequenceDictionary-Picard-

# The genome's fasta file needs to have a dictionary file in order for the fasta to be read by further 
# GATK tools. Using Picard's CreateSequenceDictionary will create a .dict file in the same directory as 
# your fasta file.
