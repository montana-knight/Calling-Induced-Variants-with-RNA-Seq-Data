#!/usr/bin/Rscript

# this script is simply going to read through each of your hard filtered sample variant call
# files and extract the lociaton of the variants. This is going to be done so that the 
# reads which map to this variant can be extracted from the alignment file, we need the locations.

vcf_filenames <- dir(pattern="*hardfiltered.vcf") # you will need all of your hard filtered samples
for (i in 1:length(vcf_filenames)) { # for all of your vcf sample filtes
	vcf_file <- read.table(vcf_filenames[i]) # read them into R
	format_for_samtools_view <- paste(vcf_file[,1], vcf_file[,2], sep=":")  # getting location
	format_for_samtools_view <- paste(format_for_samtools_view, "=1", sep="") # specify alternative allele
  # i saved the locations as a dataframe, using the same filename as before but adding in 'locations' as a prefix and 'list' as a suffix
	write.table(as.data.frame(format_for_samtools_view), file=paste("locations",vcf_filenames[i],"list",sep="."), quote=FALSE, row.names = FALSE, col.names = FALSE) 
  
}

# end


