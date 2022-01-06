# Step 3 -- Initial variant discovery

### Tools used:

* GATK's Mutect2

### Let's Call Some Variants!

Opt for your favorite variant caller. There are a lot out there. We used Mutect2 due to its "Tumor only mode" and ability to input a "Panel of Normals" which allowed us to run each sample individually (without a paired normal tissue sample) and crosscheck it with probable germline mutations. We also used it because we were working with Arabidopsis, a highly inbred line.

Call variants on each of your quality control checked alignment files.

Mutect2 is typically used on tumor tissue samples to identify somatic mutations that have accumulated within the tumor.

https://gatk.broadinstitute.org/hc/en-us/articles/360037593851-Mutect2
