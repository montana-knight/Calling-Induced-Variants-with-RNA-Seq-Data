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

## Do these in order.

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

*Note: We aren't done with BAM QC processing, however, one of the following steps (base recalibration) requires a "known-sites" input. This is possible for species who have known-sites databases (humans), but not for Arabidopsis which is what we used. GATK's work around is to create a somatic panel of normals. They suggest running Mutect2 on the data without base recalibration, obtaining a PON using the CreateSomaticPanelOfNormals tool, and then using that PON to run the alignment files through base recalibration. We will use Mutect2 to do this, but we will also use HaplotypeCaller in joint genotyping mode. This is a workflow which has been shown to work well at identifying variants in RNA-Seq data, so it is of great interest to us. After we run both HaplotypeCaller and Mutect2, we will combine the two different Panels of Normal to create the "Ultimate Panel of Normals". The output of HaplotypeCaller and Mutect2 should have a lot of overlap, but using mutations called by either/or should help combat the high false discovery rate which is associated with using RNA-Seq data for variant calling.*

*All of the steps before Base Recalibration are to create the Ultimate Panel of Normals*

## Creating the Ultimate Panel of Normals

*Creating an Ultimate PON is necessary/helpful if you do not already have a list of known mutations for your samples.*

### HaplotypeCaller + GenomicsDBImport + GenotypeGVCFs + CreateSomaticPanelOfNormals

HaplotypeCaller is GATK's germline variant caller. This tool has a joint genotyping workflow option which has show to work with RNA-Sequencing data to call appropriate variants (REF). We are not interested in calling germline variants in this workflow, we are interested in calling somatic variants. We could possibly use HaplotypeCaller to do this, but the tool doesn't do very well at calling singleton mutations which is what we are the most interested in. But HaplotypeCaller in joint genotyping mode could be used to create a Somatic Panel Of Normals. We want a good Panel of Normals (PON) so that any mutations occuring in the line of Arabidopsis being used by any given lab (that would be identified due to their difference from the reference genome) can be accounted for and not counted as novel variants.

The first step in this joint genotyping workflow is to run HaplotypeCaller on all the samples. Then GenomicsDBImport will take all of those variant call files produced by HaplotypeCaller and merge them into a database easily accessible for sequential tools. Next, GenotypeGVCFs is used to do the joint genotyping on all of the variant call files. GenotypeGVCFs will examine these files and output a joint genotype vcf files with all the samples and their re-adjusted calls. Finally, CreateSomaticPanelOfNormals will be called. This tool will examine all of the re-adjusted calls from the joint genotyping pipeline and call any mutations which are occuring in multiple samples.

### Mutect2 + GenomicsDBImport + CreateSomaticPanelOfNormals

Mutect2 is GATK's somatic variant caller. It is typically reserved to find somatic variants accumulating in tumor samples. There are a few modes it can be ran in, one of which is tumor only. This mode is for when you have only tumor tissue samples. You can compare these samples to the reference genome and can also utilize a somatic panel of normals. If you don't already have one you can create a somatic panel of normals by running Mutect2 on all of your samples, combining them into a database using GenomicsDBImport, and then calling CreateSomaticPanelOfNormals on that database. This is a very similar process to the above HaplotypeCaller workflow, but there isn't any joint genotyping.

### Create the Ultimate PanelofNormals (Custom R Script)

We created an R script which combines the the two panels of normals created from HaplotypeCaller and Mutect2 (above). The script produces a new variant call file that has any variant which was called by either tool. 

The output file needs to have an appropriate header, I used the header from the previous Mutect2 output. You then need to index this new vcf file with GATK's **IndexFeatureFile** tool.

##
*Now back to quality control of the alignment files.*

### Base Recalibration (BaseRecalibrator + ApplyBQSR)

The last quality control step utilized in this pipeline is Base Recalibration. Base recalibration adjust base quality scores based on read group, reported quality scores, machine cyle, and potential dinucleotide errors. Two GATK tools (BaseRecalibrator and ApplyBQSR) are needed to do the base recalibration. BaseRecalibrator looks at all of the bases mapped and builds a model to adjust the base quality scores. It is the tool which needs the panel of normals to fufill the known-sites requirement. ApplyBQSR is then called to take the model created by BaseRecalibrator and actually do the adjustments.

##

*Note: There is also a tool called MergeBamAlignment from Picard which you may want to use. It will merge the mapped and unmapped reads in a file. We didn't do it in this case just because Arabidopsis is very well annotated and we had a high mapping rate.*
