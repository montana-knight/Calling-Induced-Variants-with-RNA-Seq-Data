#!/usr/bin/Rscript

# this is an R script that can be run directly using R if desired
# the purpose of this script is to combine the two panel of normal files from 
# variants called by haplotypecaller and by mutect2.
# You should have already ran the createsomaticpanelofnormals tool 
# on both sets of vcfs before running this script.

###########################################################################################

# Library packages

# install.packages("dplyr") # this package is needed, install if you don't already have it
library(dplyr) # import the package

###########################################################################################

# import your two pon files

hapcall_pon <- read.table(file="haptype_joint_pon.vcf") # replace filename with your haplotypecaller pon file

mutect2_pon <- read.table(file="mutect2_pon.vcf") # replace filename with your mutect2 pon file

###########################################################################################

`%notin%` <- Negate(`%in%`) # creats a "not in" tool which will do the opposite of the in function

if(nrow(hapcall_pon) > nrow(mutect2_pon)){ # to find calls in both the haplotype caller pon and the mutect2 vcf
                                           # i did it this way so that the larger pon file would look for calls
                                           # in the smaller one. I don't think it actually matters and either way
                                           # you should get the samed results but its kind of a sanity check
  calls_in_both <- hapcall_pon[hapcall_pon$V2 %in% mutect2_pon$V2, ] # if the call from hapcall is in mutect2 then it will be saved in a new dataframe
} else {
  calls_in_both <- mutect2_pon[mutect2_pon$V2 %in% hapcall_pon$V2, ] # vice versa
}

# the calls_in_both dataframe holds variants in both the haplotype caller and mutect2 panel of normals

# print(nrow(calls_in_both)) # to show you the number of variants called by both pons

## this next part will look for variants from each of the pon files and crosscheck it with variants
## in the other pon file and pull out any variants unique to the first pon file
## this is when the "not in" comines in handy

uniq_to_hapcall <- hapcall_pon[hapcall_pon$V2 %notin% mutect2_pon$V2, ] # pulls out variants unique to the haplotype caller pon
uniq_to_mutect <- mutect2_pon[mutect2_pon$V2 %notin% hapcall_pon$V2, ] # pulls out variants unique to the mutect2 pon

## now we will combine both the pon variants called in both, the variants uniquely in each pon

all_snps_called_across_methods <- rbind(calls_in_both, uniq_to_hapcall, uniq_to_mutect) # combine the dataframes

all_snps_called_across_methods <- all_snps_called_across_methods %>% arrange(V1,V2) # order the dataframes by location

### now lets pull out variants which are more likely to be germline mutations.
# i defined this as needing to be identified in at least 3/10 samples (Fraction=0.300)
# i only had ten samples per group so the fractions were super easy (1.000 means all of them, 0.5000 means half, etc...) 
# but if you have a different number of samples that was used to build your pons then your fractions will be different
# also i wanted to only call variants present in 3 or more samples, but if you want to use
# any variants called as a variant in the pon then go for it!

toMatch <- c("FRACTION=1.00", "FRACTION=0.400", "FRACTION=0.300", "FRACTION=0.500", "FRACTION=0.600", "FRACTION=0.700", "FRACTION=0.800", "FRACTION=0.900") # all of the fractions

all_snps_called_across_methods <- filter(all_snps_called_across_methods,grepl(paste(toMatch,collapse="|"),V8)) # filter out any variants in the full combined
                                                                                                               # pon df

print(nrow(all_snps_called_across_methods))

all_snps_called_across_methods <- uniq_to_hapcall

all_snps_called_across_methods <- all_snps_called_across_methods %>% arrange(V1,V2)

toMatch <- c("FRACTION=1.00", "FRACTION=0.400", "FRACTION=0.300", "FRACTION=0.500", "FRACTION=0.600", "FRACTION=0.700", "FRACTION=0.800", "FRACTION=0.900")

all_snps_called_across_methods <- filter(all_snps_called_across_methods,grepl(paste(toMatch,collapse="|"),V8))

print(nrow(all_snps_called_across_methods))

all_snps_called_across_methods <- uniq_to_mutect

all_snps_called_across_methods <- all_snps_called_across_methods %>% arrange(V1,V2)

toMatch <- c("FRACTION=1.00", "FRACTION=0.400", "FRACTION=0.300", "FRACTION=0.500", "FRACTION=0.600", "FRACTION=0.700", "FRACTION=0.800", "FRACTION=0.900")

all_snps_called_across_methods <- filter(all_snps_called_across_methods,grepl(paste(toMatch,collapse="|"),V8))

print(nrow(all_snps_called_across_methods))


#write.table(all_snps_called_across_methods, file="all_snps_called.tsv", sep="\t", quote=FALSE, row.names = FALSE, col.names = FALSE)
