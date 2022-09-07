#!/usr/bin/Rscript

library(dplyr)
library(tidyr)
library(stringr)
library(tidyverse)
library(ggpubr)
library(rstatix)
library(broom)
library(MASS)

# function to remove complicated reads that are likely to lead to sequence errors rather than true variants
# takes three inputs: 
# 1. a vcf fle = $vcffile.vcf
# 2. polynucleotide = TRUE/FALSE <- this is whether or not you want called variants at the end of a trinucleotide repeat (ex. AA"A") filtered out
# 3. repetitive_nuc = TRUE/FALSE <- this is if you want to filter out variants that are surrounded by a larrge ratio of a single nucleotide, for example out of t
he 20 nucleotides surrounding this variant and over half of them are A, then having this option set as TRUE will filter it out

remove_complicated_reads <- function(vcf_file, polynucleotide, repetitive_nuc) {
  
  # there are two types of variants: snps and indels. How the function deals with each is slightly different so it is best to separate them.
  # first looking at only snps, which means both the fourth and fifth column both have a character length of 1
  
  snpsonly <- vcf_file[nchar(as.character(vcf_file[,4])) == 1,]
  snpsonly <- snpsonly[nchar(as.character(snpsonly[,5])) == 1,]
  number_of_var2 <- 0
  number_of_var <- 0  
  qc_vcf <- data.frame() # created a blank dataframe that will be filled with the reads that pass the quality filter
                         
  for (j in 1:nrow(vcf_file)) { # going through the vcf file line by line

    empty_vec <- vector() # what I did was create this empty vector which accumulates value if there is some sort of tricky sequence read, at the end of the loop
 
                          # if there is nothing in the empty vector then the read passed the filters and will be included in the QC VCF
    
    if(polynucleotide == FALSE && repetitive_nuc == FALSE){  ## basically if the user doesn't want any filters than just return the original vcf file
      
      qc_vcf <- vcf_file
      
    } else { 
      
      if(row.names(vcf_file[j,]) %in% row.names(snpsonly)) { # first going through the SNPs in the VCF file
        
        # the following few lines are how I pulled out and split up the "REF BASES" tag in the vcf file,
        # the ref bases was split up in order to see which nucleotides immediately surround the variant and also
        # if there is a high ratio of a certain nucleotide 
        
        split_col8 <- strsplit(as.character(vcf_file[j,8]),';')
        k <- grep("REF_BASES", split_col8[[1]])
	#print(dim(k))
        just_ref_bp <- split_col8[[1]][k]
        just_ref_bp <- strsplit(as.character(just_ref_bp),'=')
        just_ref_bp <- just_ref_bp[[1]][2]
        just_ref_bp <- strsplit(as.character(just_ref_bp),'')
        just_ref_bp <- as.vector(just_ref_bp[[1]])
	number_of_var2 <- number_of_var2 + length(just_ref_bp)
        number_of_var = number_of_var + length(k)
        # this next part will check for the nucleotides immediately around the variant in order to filter out polynucleotides
        
        if(polynucleotide == TRUE) {
                            
          if(length(unique(just_ref_bp[8:11])) == 1 || length(unique(just_ref_bp[11:14])) == 1) {
            empty_vec <- append(empty_vec, 1) # add something to empty vec which means this read will not be included during the last stage of qc_vcf stuff
          }
          
        }
        
        # this next part will check to see if there is a high ratio of a certain nucelotide in the bases surrounding the variant
            
        if(repetitive_nuc == TRUE) {                  
          number_of_As <- length(just_ref_bp[just_ref_bp == "A"])
          number_of_Ts <- length(just_ref_bp[just_ref_bp == "T"])
          number_of_Gs <- length(just_ref_bp[just_ref_bp == "G"])
          number_of_Cs <- length(just_ref_bp[just_ref_bp == "C"])
      
          if(number_of_As > 10) {
            #print("composed of a lot of A nucleotide around this region")
            empty_vec <- append(empty_vec, 1)
          }
          if(number_of_Ts > 10) {
            #print("composed of a lot of T nucleotide around this region")
            empty_vec <- append(empty_vec, 1)
          }
          if(number_of_Gs > 10) {
            #print("composed of a lot of G nucleotide around this region")
            empty_vec <- append(empty_vec, 1)
          }
          if(number_of_Cs > 10) {
            #print("composed of a lot of C nucleotide around this region")
            empty_vec <- append(empty_vec, 1)
          }
        }
      }
      
      # now the function will look at indels
      
      else {
        
        # same as above, in fact the only different is in the polynucleotide == TRUE check below
        
        split_col8 <- strsplit(as.character(vcf_file[j,8]),';')
        k <- grep("REF_BASES", split_col8[[1]])
	#print(dim(k))
	number_of_var = number_of_var + length(k)
        just_ref_bp <- split_col8[[1]][k]
        just_ref_bp <- strsplit(as.character(just_ref_bp),'=')
        just_ref_bp <- just_ref_bp[[1]][2]
        just_ref_bp <- strsplit(as.character(just_ref_bp),'')
        just_ref_bp <- as.vector(just_ref_bp[[1]])
      	number_of_var2 <- number_of_var2 + length(just_ref_bp)
        
        if(polynucleotide == TRUE) { # here the nucleotides following an insertion (or immediate before in the case of a reverse read) would be bp 12-14 instead 
of 11-13
                            
          if(length(unique(just_ref_bp[8:11])) == 1 || length(unique(just_ref_bp[12:15])) == 1) {
            empty_vec <- append(empty_vec, 1)
          }
          
        }
            
        if(repetitive_nuc == TRUE) {                  
          number_of_As <- length(just_ref_bp[just_ref_bp == "A"])
          number_of_Ts <- length(just_ref_bp[just_ref_bp == "T"])
          number_of_Gs <- length(just_ref_bp[just_ref_bp == "G"])
          number_of_Cs <- length(just_ref_bp[just_ref_bp == "C"])
      
          if(number_of_As > 10) {
            #print("composed of a lot of A nucleotide around this region")
            empty_vec <- append(empty_vec, 1)
          }
          if(number_of_Ts > 10) {
            #print("composed of a lot of T nucleotide around this region")
            empty_vec <- append(empty_vec, 1)
          }
          if(number_of_Gs > 10) {
            #print("composed of a lot of G nucleotide around this region")
            empty_vec <- append(empty_vec, 1)
          }
          if(number_of_Cs > 10) {
            #print("composed of a lot of C nucleotide around this region")
            empty_vec <- append(empty_vec, 1)
          }
        }
      }
      
      if(length(empty_vec) == 0){
      qc_vcf <- rbind(qc_vcf, vcf_file[j,])
    }
      
    }
  
  }

  return(qc_vcf) # depending on parameters, returns the variants filtered
}




##### actually running the function



dedup_vcf_files <- dir(pattern="dedupped.*") # you'll need to run this on every one of your deduplicated vcfs

qc_list <- list() # to save the filtered by tricky reads files

for (i in 1:length(dedup_vcf_files)) { # for all of the vcf files

# run the function
  qc_list[[i]] <- remove_complicated_reads(vcf_file = read.table(dedup_vcf_files[[i]]), polynucleotide = TRUE, repetitive_nuc = FALSE)
  
  # save the output as you'd like
  write.table(qc_list[[i]], file=paste("qc2", dedup_vcf_files[i], sep="."), sep="\t", quote=FALSE, row.names = FALSE, col.names = FALSE)
  
}

