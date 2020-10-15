#!/bin/bash

fastq_quality_filter -Q # -i input.fastq -o filtered.fastq

# -Q tag is the minimum quality score to keep
# again, there are other tools which can do quality filtering
