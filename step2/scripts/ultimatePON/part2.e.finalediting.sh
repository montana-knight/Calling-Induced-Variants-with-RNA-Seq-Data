#!/bin/bash


# The end of this set of scripts will give you an "Ultimate Panel of Normals" from the final R script. It will be missing the normal vcf header so you will need to attach that from another file. For example you can pull out all of the header by doing something like this:

>   grep "#" somevcffile.vcf >header.txt

Then attach that header to your ultimate pon and create a vcf version of you file.

>   cat header.txt ultimatepon.tsv >ultimatepon.vcf
