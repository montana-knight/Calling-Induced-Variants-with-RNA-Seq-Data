#!/bin/bash

fastqc -j /path/to/java -o output_directory/ input_filename.fastq

# fastqc generates html formatted quality control reports of different fastq files
# -j option is used if the program needs a particular version of java that is not the default
# -o option is where you want the html doc to go, an output directory
# include the fastq file you want the fastqc done on. The output will go to the output directory with .html added to the end of the filename
