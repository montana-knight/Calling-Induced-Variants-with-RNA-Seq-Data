# Step 3 -- Initial variant discovery

### Tools used:

* GATK's Mutect2

### Let's Call Some Variants!

We used Mutect2 due to its "Tumor only mode" and ability to input a "Panel of Normals" which allowed us to run each sample individually (without a paired normal tissue sample) and crosscheck it with probable germline mutations. We also used it because we were working with Arabidopsis, a highly inbred line.

Call variants on each of your quality control checked alignment files.

Mutect2 is typically used on tumor tissue samples to identify somatic mutations that have accumulated within the tumor.

https://gatk.broadinstitute.org/hc/en-us/articles/360037593851-Mutect2

Note, there are a lot of variant callers out there. If you have another tool which you like to work with, then please go ahead, though you may have to modify some of the downstream filtering scripts to work with your output files.
