#!/usr/bin/python
import sys, os

'''

Computes the coverage of the sequencing.
Login to orchestra and run program from there.

'''

#Load modules

command_loadSamtools = "module load seq/samtools/1.1"
command_loadBedtools = "module load seq/BEDTools/2.23.0"



#Library alignment to whole yeast genome is already done
# Eventually replace the for loop where the names of the libraries are added.
AlignmentFiles = ['r4H3L_yeast_genome','r3A10L_yeast_genome']


for samFile in AlignmentFiles:

	#Convert sam files into bam files
	comand_conversionSamToBam = "bsub -q sysbio_12h samtools view -bS -o /home/rae10/gal_seq/20121101/" + samFile + ".bam /home/rae10/gal_seq/20121101/" + samFile + ".sam ";
	print comand_conversionSamToBam
	#os.system(comand_conversionSamToBam)
	
	#Sort alignments
	
	command_sortBam = "bsub -q sysbio_12h samtools sort /home/rae10/gal_seq/20121101/" + samFile + ".bam /home/rae10/gal_seq/20121101/" + samFile + "_sorted"
	print command_sortBam
	
	#Execute coverage calculation with option d
	commandComputeCoverage = "genomeCoverageBed -ibam " + samFile + "_sorted.bam -g yeast_chr/yeast_genome.fna -bga > Bedtools_coverage_" + samFile
	print commandComputeCoverage
	
	#Cut the column with the counts