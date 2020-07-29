# Analyzing spaceflight data using an RNA-Seq pipeline.


Gene expression data is one of the most common biological data types collected. It's incredibly informative, and now can have nucleotide level information thanks to Next Generation Sequencing (NGS) technolgy's RNA-Seq. Oftentimes labs opt to do RNA-Seq data because they value gene expression information over other biological information. This makes finding new "alternative" uses for RNA-Seq data (besides just gene expression) that much more interesting.

Scientific research on the International Space Station (ISS) is expensive. On top of that the ISS has extreme conditions and limited resources. Gene expression data, or transcript profiles, are the most common data type on NASA's Genelab Omics database. Thanks to advances in NGS, many of these gene expression sets are RNA-Seq. Spaceflight biological research provides new insights into how terrestial beings cope with a spaceflight environment. This is absolutely essential as we continue on a path to explore the universe.

In this analysis we proposed to optimize the amount of information given to us from RNA-Seq data by using the actual sequencing information to look for possible mutations caused by spaceflight. This study could shed light as to how spaceflight's environment (particularly its microgravity and space radiation) are impacting an organism at the nucleotide level. We chose to focus on data from *Arabidopsis thaliana* due to its highly inbred and homozygous nature. As this study continued on, we realized this homozygous natures is highly advantageous as it is almost comparable to studying clones or multi-tissue samples.

RNA-Seq data being used for variant discovery is not a new concept, however it is associated with a high false discovery rate. This is due to the additional reverse transcription step before PCR, the complexity in splice junction sites and alignment mapping, and RNA editing. This pipeline proposes ways to address these issues in order to have informative and appropriate analysis.

The general flow of the pipeline is as follows:

### [Step 0 -- Collecting raw read data and quality control of the fastq files](https://github.com/montana-knight/spaceflight-RNAseq/tree/master/step0)

### [Step 1 -- Alignment mapping](https://github.com/montana-knight/spaceflight-RNAseq/tree/master/step1)

### [Step 2 -- Quality control of the alignment files](https://github.com/montana-knight/spaceflight-RNAseq/tree/master/step2)

### [Step 3 -- Initial Variant Discovery](https://github.com/montana-knight/spaceflight-RNAseq/tree/master/step3)

### [Step 4 -- Quality control of the variant call files](https://github.com/montana-knight/spaceflight-RNAseq/tree/master/step4)

### [Step 5 -- Statistical and biological analysis of filtered variants](https://github.com/montana-knight/spaceflight-RNAseq/tree/master/step5)
