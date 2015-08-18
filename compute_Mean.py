"""
Computes arithmetic mean, standard deviation and the minimum of a file


 parser.add_argument('macs2_files',help='This is a comma-delimited list of files that are output from MACS2. BED format is required, so you can use the summits.bed files or the .narrowPeak files')
 parser=ArgumentParser(description='Basic script designed to take results of MACS2 narrowPeak files and find the overlap with ENCODE DNase Clusters and TFBS data. Make sure you are running on the cluster with bedtools installed!')
"""
import sys,os,re
from argparse import ArgumentParser

def main():
	parser=ArgumentParser(description='Basic script designed to take results of MACS2 narrowPeak')
	parser.add_argument('INPUT',help='Enter input directory that will be scanned for SAM or BAM files.')
	args=parser.parse_args()

	print args.INPUT
	
	with open(args.INPUT, 'r') as f:
    	#read lines, strip trailing newlines, and convert to float if not empty
	    numbers = [float(x) for x in (x.strip() for x in f) if x]
	
	avg = sum(numbers) / len(numbers)
	sdv = (sum((n - avg) ** 2 for n in numbers) / len(numbers)) ** .5
	print('The arithmetic mean is {}'.format(avg))
	print('The standard deviation is {}'.format(sdv))
	print('The minimum is {}.'.format(min(numbers)))
	    
	    
	    
if __name__=='__main__':
    main()

	

