#!/usr/bin/python

import sys, os

"""
Extract specific features from the Skelly genome sequencing, specifically GAL3 with upstream sequences 500 base pairs

To extract a specific name specified in bed tools use the -name option
bedtools_command="bedtools getfasta -fi " +path + fasta + " -bed " + path + "GAL3_500bp_upstream.bed  -fo " + path +  fasta +".GAL3_500bp_upstream.out -name"

"""

allFiles=['273614N.fa','378604X.fa','BC187.fa','DBVPG1106.fa','DBVPG1373.fa','DBVPG6765.fa','K11.fa','L_1374.fa','NCYC361.fa','SK1.fa','UWOPS05_217_3.fa','UWOPS05_227_2.fa','UWOPS83_787_3.fa','UWOPS87_2421.fa','Y12.fa','Y55.fa','YJM975.fa','YJM978.fa','YJM981.fa','YPS128.fa','YPS606.fa','YS2.fa','YS9.fa']

path="/Users/RenanEscalante/Dropbox/Phenotypic_diversity/var_bioinfo/20150324_Skelly_Sequences/"

for fasta in allFiles:
	bedtools_command="bedtools getfasta -fi " +path + fasta + " -bed " + path + "GAL3_1KB.bed  -fo " + path +  fasta +".GAL3_1KB.out"
	os.system(bedtools_command)
