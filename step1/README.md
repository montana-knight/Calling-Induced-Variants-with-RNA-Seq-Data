# Step 1 -- Alignment mapping

### Tools used:

* STAR
* Optional: Picard's ValidateSamFile


### STAR

STAR is an RNA-Sequencing Alignment Mapper. STAR was run in 2-pass mode in order to help identify any novel splice sites in the dataset. Running STAR in 2-pass mode is fairly straight froward. You'll run STAR once regularly by first generating a genome directory and then mapping each fastq file. The difference comes in the next steps. You'll generate another genome, using all of the same information except you'll also use all of the output SJ.out.tab files created for all the fastq files in the previous mapping jobs. This new genome generation will re-look and re-assess some of the splice sites. You'll remap your fastq files to this new genome directory and the hope is that these new alignment files handles the areas around splice sites better.

This is particularly important for this analysis because splice sites are part of the reason that using RNA-Sequencing data for variant calling ends up with a higher false discovery rate. Running STAR in 2-pass mode helps eleviate some of those concerns.

### Picard's ValidateSamFile

Another tool which can be very useful as a post-alignment quality check is Picard's ValidateSamFile. This tool checks the alignment files created by STAR (or another alignment mapper) for any issues. Common problems are corrupted alignment files or files with premature stops.

*Note: There are other alignment mappers which work with RNA-Seq data. STAR in 2-pass mode does a great job at handling splice sites which was essential for this pipeline. It also works faster than other aligners, which is helpful.*
