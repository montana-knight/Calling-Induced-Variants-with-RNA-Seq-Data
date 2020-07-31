# Step 0 -- Collecting raw read data and quality control of the fastq files

### Tools used:

* fastqc
* fastx_trimmer

#### Step 0.1 -- Loading raw fastq reads and checking their quality via **fastqc**

Fastqc generates a report based on read quality. After loading the raw fastq files, run them through fastqc in order to see what kinds of quality control measures you need to take. Generally reads need to be trimmed and low quality reads filtered out, but the fastqc report may also alert you to other issues in your file.

#### Step 0.2 -- Trimming 

