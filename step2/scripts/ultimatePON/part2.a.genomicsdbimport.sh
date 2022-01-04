#!/bin/bash

gatk GenomicsDBImport -R genome.fasta -L intervals.list --genomicsdb-workspace-path hapcall_pon_dir --sample-name-map samplename.map
