#!/bin/bash

fastx_trimmer -Q33 -f ## -l ## -i input_raw.fastq -o trimmed.fastq

# the -Q33 tag might need to be added depending on the sequencer that you used to get your reads
# there are many other tools you can use to trim your reads
