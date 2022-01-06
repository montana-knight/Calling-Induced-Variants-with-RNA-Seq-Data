# Creating an Ultimate Panel of Normals

The Ultimate Panel of Normals (PON) is necessary to have a baseline of what germline mutations are shared among the samples. This allows for more accurate variant calls later on when we officially use Mutect2 in tumor only mode. It also is necessary to run the Base Recalibration tool which examines/re-evaluates the accuracy in each aligned base.

Creating the ultimate power of normals can be broken down into two parts:
1. An initial run of haplotypecaller and mutect2. These tools will call variants in each of the samples.
2. Combining the sets of variant calls and figuring out which ones are likely germline variants.
