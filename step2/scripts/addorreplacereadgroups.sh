#!/bin/bash

java -jar picard.jar AddOrReplaceReadGroups I=bam_filename.bam O=output_bam_filename.bam RGID=readgroupid RGLB=library RGPL=Illumina RGPU=machine RGSM=readgroupsamplename

# picard script
# https://gatk.broadinstitute.org/hc/en-us/articles/360037226472-AddOrReplaceReadGroups-Picard-
# This is only a necessary step due to the sequential use of GATK. GATK (and some other bioinformatic tools) require a read group (RG) 
# tag in order to process the samples. Picard's AddOrReplaceReadGroups will add this tag to each samples. The user can input the tags including:
# Read Group ID
# Read Group Library
# Read Group platform
# Read Group platform unit
# Read Group sample name

# the scripts adds necessary tags to the bam file, but doesn't do anything other than that
