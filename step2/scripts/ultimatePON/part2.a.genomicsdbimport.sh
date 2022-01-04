#!/bin/bash

gatk GenomicsDBImport -R genome.fasta -L intervals.list --genomicsdb-workspace-path workspace_dir_name --sample-name-map mappingfile.map

### 

# -R reference genome
# -L intervals.list (intervals in genomes to search over)
# --genomicsdb-workspace-path workspace_dir_name (where you want the workspace to be/what you want it called
# --sample-name-map mappingfile.map (your samples/where to find them)

# https://gatk.broadinstitute.org/hc/en-us/articles/360036883491-GenomicsDBImport

# you will need to use this tool on both your haplotypecaller vcfs and your mutect2 vcfs (separately)

