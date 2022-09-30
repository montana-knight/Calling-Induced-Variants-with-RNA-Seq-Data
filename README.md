![NCSU Logo](https://brand.ncsu.edu/assets/logos/ncstate-brick-4x1-red-min.png)

# Somatic Variant Calling in a Highly Inbred Species with RNA-Seq Data


**Gene expression data** is one of the most common biological data types collected. It's incredibly informative, and now can have nucleotide level information thanks to Next Generation Sequencing (NGS) technolgy's **RNA-Seq**. Oftentimes labs opt to do RNA-Seq data because they value gene expression information over other biological information. This makes finding **new "alternative" uses for RNA-Seq data** (besides just gene expression) that much more interesting.

Here, we outline a toolbox of publicly available software and new custom scripts that help to optimize the amount of information given to us from RNA-Seq data by using the actual sequencing information to look for **variants** in a **highly-inbred** species.

RNA-Seq data being used for variant discovery is not a new concept, however it is associated with a **high false discovery rate**. This is due to the additional reverse transcription step before PCR, the complexity in splice junction sites and alignment mapping, and RNA editing. This pipeline proposes ways to address these issues in order to have **informative and appropriate analysis**.

Most of the following tools are from popular software like STAR or GATK. However, in Step 4 you will see a few custom scripts we suggest using to help combat the number of high false variant calls. 

### **The general flow of the pipeline is as follows:**

#### [Step 0 -- Collecting raw read data and quality control of the fastq files](https://github.com/montana-knight/spaceflight-RNAseq/tree/master/step0)

#### [Step 1 -- Alignment mapping](https://github.com/montana-knight/spaceflight-RNAseq/tree/master/step1)

#### [Step 2 -- Quality control of the alignment files](https://github.com/montana-knight/spaceflight-RNAseq/tree/master/step2)

#### [Step 3 -- Initial Variant Discovery](https://github.com/montana-knight/spaceflight-RNAseq/tree/master/step3)

#### [Step 4 -- Quality control of the variant call files](https://github.com/montana-knight/spaceflight-RNAseq/tree/master/step4)

#### [Step 5 -- Statistical and biological analysis of filtered variants](https://github.com/montana-knight/spaceflight-RNAseq/tree/master/step5)
