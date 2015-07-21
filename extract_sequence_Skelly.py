#!/usr/bin/python

import sys, os

"""
Extract specific features from the Skelly genome sequencing

command11="\"cut -f4,6,10 " + path + "tmp2_"+fastq+"_chr"+ str(i) +".txt>" + path + fastq+"_chr"+ str(i) + ".readsCIGAR\""

bedtools_command="bedtools getfasta -fi YS2.fa -bed GAL3_500bp_upstream.bed  -fo test2.fa.out"
os.system(bedtools_command)
bedtools_command="bedtools getfasta -fi " +path + "YS2.fa -bed " + path + " GAL3_500bp_upstream.bed  -fo " +path " test2.fa.out"
"""
path="/Users/RenanEscalante/Dropbox/Phenotypic_diversity/var_bioinfo/20150324_Skelly_Sequences/"

bedtools_command="bedtools getfasta -fi " +path + "YS2.fa -bed " + path + "GAL3_500bp_upstream.bed  -fo " + path + "test2.fa.out"

print bedtools_command
