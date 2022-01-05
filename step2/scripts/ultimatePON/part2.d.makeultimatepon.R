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

`%notin%` <- Negate(`%in%`)

if(nrow(hapcall_pon) > nrow(mutect2_pon)){
  calls_in_both <- hapcall_pon[hapcall_pon$V2 %in% mutect2_pon$V2, ]
} else {
  calls_in_both <- mutect2_pon[mutect2_pon$V2 %in% hapcall_pon$V2, ]
}

#print(nrow(calls_in_both))

uniq_to_hapcall <- hapcall_pon[hapcall_pon$V2 %notin% mutect2_pon$V2, ]
uniq_to_mutect <- mutect2_pon[mutect2_pon$V2 %notin% hapcall_pon$V2, ]

all_snps_called_across_methods <- calls_in_both  #rbind(calls_in_both, uniq_to_hapcall, uniq_to_mutect)

all_snps_called_across_methods <- all_snps_called_across_methods %>% arrange(V1,V2)

toMatch <- c("FRACTION=1.00", "FRACTION=0.400", "FRACTION=0.300", "FRACTION=0.500", "FRACTION=0.600", "FRACTION=0.700", "FRACTION=0.800", "FRACTION=0.900")

all_snps_called_across_methods <- filter(all_snps_called_across_methods,grepl(paste(toMatch,collapse="|"),V8))

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
