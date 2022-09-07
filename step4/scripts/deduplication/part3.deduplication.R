#!/usr/bin/Rscript


sam_filenames <- dir(pattern="*reduced_alignment.sam") # product of bash script which pulled out only the reads mapping to the allele in sam file, you will have one of these per sample
vcf_filenames <- dir(pattern="*hardfiltered.vcf") # the vcf (each sample)
vcflocations_names <- dir(pattern="*locations_hardfiltered.list") # where the variants are (each sample)

"%notin%" <- Negate("%in%") # handy little function to say "not in"

vcf_filenames <- vcf_filenames[vcf_filenames %notin% vcflocations_names] 

for(i in 1:length(sam_filenames)){ # for all of the reduced alignment files
  
  # read the files in 
  
  samfile <- read.table(sam_filenames[i], fill=TRUE, row.names=NULL, header=FALSE)
  vcf_file <- read.table(vcf_filenames[i], row.names=NULL)
  vcf_togrep <- read.table(vcflocations_names[i], row.names=NULL)
  
  # now this is where it gets a little strange, it takes a while in R to search the files,
  # but a bash script can do it pretty quickly/easily, so lets just write the files out and search them
  # via bash. Its in this R loop just for ease but it could also just be left alone and examined.

  write.table(samfile, "trial2.txt", col.names = FALSE, quote = FALSE, row.names = FALSE) # sam file in txt format
  
  new_vcf_file <- data.frame() # start to create the new vcf file
  
  for(j in 1:nrow(vcf_file)) { # for each of the variants
    
    location_has_alternate <- as.character(vcf_togrep[j,1]) # is there an alternate allele (ie a variant?)
    write.table(location_has_alternate, "trial.txt", col.names = FALSE, quote = FALSE, ro
w.names = FALSE) # save the variant's location
    
    # use bash to pull out all of the supporting reads for that allele
    x <- system("grep -f trial.txt trial2.txt", intern=TRUE, ignore.stdout = FALSE, ignor.stderr = FALSE, wait = TRUE) 
    
    x1 <- strsplit(x, split= " ") # split up the reads into different columns
    
    loc.and.cigar <- data.frame(matrix(ncol=3,nrow=0)) # lets look at the cigar string
    for(k in 1:length(x1)){ # for each of the reads that support the variant
      iteration_loc_cigar <- x1[[k]][c(3,4,6)] # examine the cigar string
      loc.and.cigar <- rbind(loc.and.cigar, iteration_loc_cigar) # record all of the cigar strings
    }

    if(nrow(unique(loc.and.cigar)) <= 1){ # if there is only one read supporting it, then don't keep the variant

    } else{
      new_vcf_file <- rbind(new_vcf_file, vcf_file[j,]) # keep the variant

    }

  }
   	write.table(new_vcf_file, file=paste("dedupped", vcf_filenames[i], sep="."), sep="\t", quote=FALSE, row.names = FALSE, col.names = FALSE)
    # once youve gone through all the variants, save the deduplicated variants to a table
}


#end
