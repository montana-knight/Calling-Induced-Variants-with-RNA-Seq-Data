# Step 0 -- Collecting raw read data and quality control of the fastq files

### Tools used:

* fastqc
* fastx_trimmer

#### Step 0.1 -- Loading raw fastq reads and checking their quality via **fastqc**

Fastqc generates a report based on read quality. After loading the raw fastq files, run them through fastqc in order to see what kinds of quality control measures you need to take. Generally reads need to be trimmed and low quality reads filtered out, but the fastqc report may also alert you to other issues in your file. This is an example of what the left-hand index will look like for the fastqc produced html quality report:

![Image of FASTQC Lefthand index](https://github.com/montana-knight/spaceflight-RNAseq/blob/master/step0/images/FASTQC%20--%20Leftside%20index.png)

Intuitively, the green circles with an inserted checkmark indicate the reads easily fufill the corresponding quality check, the yellow circles with an exclamation mark are a warning for the corresponding quality check, and the red with the "x" indicates bad quality. In the above image the sequence duplication level was the main issue for the quality report (typical with RNA-Seq data, even more typical with plant expression data since plants produce A LOT of photosynthesis related RNA on a daily basis).

#### Step 0.2 -- Trimming 

When I ran fastqc on my raw fastq files, I noticed a warning would pop up on all of the "Per Base Sequence Content" tabs. The corresponding graph looked like this:

![Image of Per Base Sequence Content](https://github.com/montana-knight/spaceflight-RNAseq/blob/master/step0/images/FASTQC%20--%20Per%20base%20nucleotide.png)

This indicates the first thirteen or so bases should likely be trimmed from each of the reads. I also trimmed the last three nucleotides as well. Reads were trimmed using fastx_trimmer, and there are other tools out there that can trim reads as well. After trimming, be sure to run the trimmed reads through fastqc again to continuously check on quality.

You may have other issues which require trimming, for example leftover adapter sequences.

#### Step 0.3 -- Quality Filtering

I filtered based on quality score, keeping those which have scores more than or equal to 30. 

*Note: Quality control of raw reads is very much a case to case basis. Start with your fastqc to see what warnings come up. If you aren't sure what to do with an error/warning, take to google because someone else has probably had the question before.*
