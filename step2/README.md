# Step 2 -- Quality control of the alignment files

### Tools used:

* Picard's CreateSequenceDictionary
* Picard's AddOrReplaceReadGroups 
* GATK's SplitNCigarReads (Split N Cigar Reads)
* GATK's HaplotypeCaller
* GATK's Mutect2
* GATK's GenomicsDBImport
* GATK's GenotypeGVCFs
* GATK's CreateSomaticPanelOfNormals
* Custom R Script to Create an Ultimate Panel of Normals
* GATK's IndexFeatureFile
* GATK's BaseRecalibrator + ApplyBQSR

### CreateSequenceDictionary

The genome's fasta file needs to have a dictionary file in order for the fasta to be read by further GATK tools. Using Picard's CreateSequenceDictionary will create a .dict file in the same directory as your fasta file.

### AddOrReplaceReadGroups

This is only a necessary step due to the sequential use of GATK. GATK (and some other bioinformatic tools) require a read group (RG) tag in order to process the samples. Picard's AddOrReplaceReadGroups will add this tag to each samples. The user can input the tags including:

* Read Group ID
* Read Group Library
* Read Group platform
* Read Group platform unit
* Read Group sample name

### SplitNCigarReads

![SplitNCigarReads Elimination Process,  https://discussions4562.rssing.com/chan-67237868/all_p81.html#c67237868a1602i1254726666](https://github.com/montana-knight/spaceflight-RNAseq/blob/master/step2/images/d400461fa1673ce50603487714be76.png)

GATK's SplitNCigarReads reassesses nucleotides surrounding splice sites and is an essential step in calling variants from RNA-Seq data. Reads will be split up based on the parts of the read that map before an intron (N) and after (N). Overhangs in intronic regions will then be clipped. This will eliminate any variants which otherwise would have been falsely called in these regions.

### HaplotypeCaller + GenomicsDBImport + GenotypeGVCFs + CreateSomaticPanelOfNormals

HaplotypeCaller is GATK's germline variant caller. This tool has a joint genotyping workflow option which has show to work with RNA-Sequencing data to call appropriate variants (REF). We are not interested in calling germline variants in this workflow, we are interested in calling somatic variants HOWEVER in order to do that we will need to utilize a Somatic Panel Of Normals. 

### BaseRecalibrator + ApplyBQSR



*Note: There is also a tool called MergeBamAlignment from Picard which you may want to use. It will merge the mapped and unmapped reads in a file. We didn't do it in this case just because Arabidopsis is very well annotated and we had a high mapping rate.*
