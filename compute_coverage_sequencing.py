#!/usr/bin/python
import sys, os

'''

Computes the coverage of the sequencing.

'''

#Load modules

command_loadSamtools = "module load seq/samtools/1.1"
command_loadBedtools = "module load seq/BEDTools/2.23.0"



#Library alignment to whole yeast genome is already done
# Eventually replace the for loop where the names of the libraries are added.
AlignmentFiles = ['r4H3L_yeast_genome','r3A10L_yeast_genome']

#Now turn the sam files into bam files

for samFile in AlignmentFiles:

	comand_conversionSamToBam = "bsub -q sysbio_12h samtools view -bS -o /home/rae10/gal_seq/20121101/" + samFile + ".bam /home/rae10/gal_seq/20121101/" + samFile + ".sam ";
	print comand_conversionSamToBam
	#os.system(comand_conversionSamToBam)