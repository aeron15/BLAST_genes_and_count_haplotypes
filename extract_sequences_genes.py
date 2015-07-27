#!/usr/bin/python

import sys, os

"""
Extract specific features from the Skelly genome sequencing, specifically GAL3 with upstream sequences 500 base pairs

To extract a specific name specified in bed tools use the -name option
bedtools_command="bedtools getfasta -fi " +path + fasta + " -bed " + path + "GAL3_500bp_upstream.bed  -fo " + path +  fasta +".GAL3_500bp_upstream.out -name"

os.system(bedtools_command)

%queryGenes = {'S288C_YDR009W_GAL3_flanking','S288C_YBR020W_GAL1_flanking','S288C_YBR018C_GAL7_flanking',...
%   'S288C_YMR105C_PGM2_flanking','S288C_YPL248C_GAL4_flanking','S288C_YBR019C_GAL10_flanking','S288C_YML051W_GAL80_flanking'};

print directory_command
print(bedtools_command)

"""

allFiles=['273614N.fa','378604X.fa','BC187.fa','DBVPG1106.fa','DBVPG1373.fa','DBVPG6765.fa','K11.fa','L_1374.fa','NCYC361.fa','SK1.fa','UWOPS05_217_3.fa','UWOPS05_227_2.fa','UWOPS83_787_3.fa','UWOPS87_2421.fa','Y12.fa','Y55.fa','YJM975.fa','YJM978.fa','YJM981.fa','YPS128.fa','YPS606.fa','YS2.fa','YS9.fa']
allGenes=['GAL3','GAL1','GAL2','GAL4','GAL80','GAL10','GAL7'];
path="/Users/RenanEscalante/Dropbox/Phenotypic_diversity/var_bioinfo/20150324_Skelly_Sequences/"

for gene in allGenes:
	pathOut="../data_bioinformatics/sequences_" + gene + "_Skelly/"
	directory_command="mkdir " + pathOut
	os.system(directory_command)

	for fasta in allFiles:
		bedtools_command="bedtools getfasta -fi " +path + fasta + " -bed " + path + gene + "_1KB.bed  -fo " + pathOut +  fasta +"." + gene + "_1KB.out"
		os.system(bedtools_command)