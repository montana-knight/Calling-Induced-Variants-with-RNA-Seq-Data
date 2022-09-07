# Step 4 -- Quality control of the variant call files

### Tools used:

* GATK's VariantFiltration
* Custom de-duplicating script
* Custom script to remove likely poly-nucleotide errors
* Custom script to filter based on gene expression

Variant filtering is of the upmost importance when working with variants called from RNA-Sequencing data.

Hard filters can be implemented on your variant calls using GATK's VariantFiltration tool (see: https://gatk.broadinstitute.org/hc/en-us/articles/360037434691-VariantFiltration). Note, that there is the option to simply mark each variant as either pass or fail based on your filters. It may be useful to mark variants first and inspect them to see how many passed vs. failed and why. Then they can be filtered out. This is also when you will filter out variants that are likely germline mutations in your Ultimate PON. They are marked, but not filtered out until you remove them.

The next step is to remove variants that were likely the result of a PCR duplication error. We wait to do this step until after variant calling to help make sure rare variants could still be captured if there were reads supporting them. A custom pipeline was created to remove variants likely to be PCR duplicates. This pipeline will examine individual variants and the reads which support them. If all reads are identical in compositon and mapped location, then they will be considered a result of a PCR duplication error and removed.

Variants which were in "tricky" to sequence regions were also removed. These regions were defined as any variants that were at the end of a sequence of three of the same nucleotide (ex. AA"A").

Finally, variants were only considered if they were not in an extremely lowly expressed gene and were only considered if they were in genes expressed in each of the samples. Two things should be noted here. 1) removing variants in lowly expressed genes could be redundant if a read depth filter is added during the hard filtering step. 2) if you are comparing samples across tissue type (not recommended) then you should not only look at genes expressed in both tissues as this will greatly limit your ability to detect variants. A custom script was written to do this.
