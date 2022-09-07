#!/usr/bin/Rscript

count_data <- dir(pattern="htseq/*htseq.results") # you have to run htseq on your alignment files and get count information to be able to run this script

qc_vcf_filenames <- dir(pattern="qc") # import all of the variant call files that were filtered by tricky reads

qc_list <- list() # to save the vcfs in

for (i in 1:length(qc_vcf_filenames)) { # for all of the vcf files
  
  qc_list[[i]] <- read.table(qc_vcf_filenames[i], fill = TRUE) # read them in and save them

}

# examine variants based on whether their corresponding gene is
# expressed in every sample or not
  
  tissue_expressiondf <- list() # to save the counts that are above 10 for each sample
  
  i=1
  
  while(i <= length(count_data)){ # going through all of the counts from htseq
    iterative_gene_expression_df <- read.delim(count_data[i], fill=TRUE, sep="\t", header=FALSE) # read them in
    tissue_expressiondf[[i]] <- iterative_gene_expression_df # save
    names(tissue_expressiondf)[[i]] <- count_data[i] # name
    tissue_expressiondf[[i]] <- subset(tissue_expressiondf[[i]], tissue_expressiondf[[i]][,3] > 10) # save over, this time only counts above 10
    i=i+1 # go to next iteration
  }
  
  for(i in 1:length(tissue_expressiondf)){ # for each of the counts that are above 10 for each sample
    iterative_gene_expression_df <- tissue_expressiondf[[i]] # current gene
    for(j in 1:length(tissue_expressiondf)){ # for each of the samples again, this loop is going to check that the genes are expressed in every single sample
      iterative_gene_expression_df <- iterative_gene_expression_df[iterative_gene_expression_df[,1] %in% tissue_expressiondf[[j]][,1], ] # save only genes which are expressed in both samples
    }
    tissue_expressiondf[[i]] <- iterative_gene_expression_df # save new count data frame with genes that are expressed in each sample
  }
  
  all_gene_expression <- list() 

  for(i in 1:length(tissue_expressiondf)){ # for each of the samples
    
    all_gene_expression[[i]] <- tissue_expressiondf[[i]] # current list of expression counts 
    all_gene_expression[[i]][,1] <- unique(unlist(strsplit(all_gene_expression[[i]][,1], ":")))[-1] # looking just at the genes
    
    
  }
  # row.names(filtered_by_expression) <- count_data 
  
}

genesexpressed <- all_gene_expression[[1]][,1] # all the genes should be the same so as long as you're looking at the first column

final_var <- list() # to save the final variant calls

for(i in 1:length(qc_list)){ # for all the variant calls
  persamplefinalvar <- data.frame(matrix(ncol=ncol(qc_list[[1]]),nrow = 0)) # to save variants to
  for(j in 1:nrow(qc_list[[i]])){ # for each of the vcfs
  # are the variants in genes that are expressed?
    expressedorno <- genesexpressed[as.numeric(qc_list[[i]][j,1]) == as.numeric(genesexpressed[,2]) & as.numeric(qc_list[[i]][j,2]) <= as.numeric(genesexpressed[,4]) & as.numeric(qc_list[[i]][j,2]) >= as.numeric(genesexpressed[,3]),]
    if(nrow(expressedorno > 0)){ # if so
      persamplefinalvar <- rbind(persamplefinalvar, qc_list[[i]][j,]) # save the variant
    }
  }
  final_var[[i]] <- persamplefinalvar # save new variant file
}


names(final_var) <- qc_vcf_filenames # each sample is named
for(i in 1:length(final_var)){ # for each sample's new filtered by expression variant call file, save the file
  write.table(final_var[[i]], file= paste("filterbyexpression",names(final_var)[i], sep = "."), sep="\t", quote=FALSE, row.names = FALSE)
}
