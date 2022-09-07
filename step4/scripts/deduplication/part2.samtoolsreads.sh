#!/bin/bash

for filename in *alignmentfiles.bam # for all of your alignment files
do

	samtools view $filename . >$filename.sam # save the bam to a sam file
	grep -f locations.hardfiltered.vcf.list $filename.sam >$filename.red.sam # this will reduce the size
  # of your alignment file to only the reads that are mapping to your variant location, making
  # it easier/faster to search!


done
