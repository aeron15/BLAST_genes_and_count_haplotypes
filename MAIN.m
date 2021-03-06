function MAIN

%MAIN script determines the number of haplotypes and SNPs for genes across
%strains in the paper
% When Skelly sequences were added 27 sequences were blasted and 15 strains
% were dowloaded from the Skelly genome sequences.http://www.yeastrc.org/g2p-data/raw-data/genomes/

%Create an output folder if it does not exist
if ~exist('../outputFigures')
    mkdir('../outputFigures');
end

if ~exist('../output_bioinformatics')
    mkdir('../output_bioinformatics');
end

path_data='../data_bioinformatics/';

%% Query genes
close all;
%queryGenes = {'S288C_YDR009W_GAL3_flanking'};
%queryGenes = {'S288C_YMR105C_PGM2_flanking','S288C_YPL248C_GAL4_flanking','S288C_YBR019C_GAL10_flanking','S288C_YML051W_GAL80_flanking'};
queryGenes = {'S288C_YDR009W_GAL3_flanking','S288C_YBR020W_GAL1_flanking','S288C_YBR018C_GAL7_flanking'};
% queryGenes = {'S288C_YDR009W_GAL3_flanking','S288C_YBR020W_GAL1_flanking','S288C_YBR018C_GAL7_flanking',...
%    'S288C_YMR105C_PGM2_flanking','S288C_YPL248C_GAL4_flanking','S288C_YBR019C_GAL10_flanking','S288C_YML051W_GAL80_flanking'};

%% Collect sequences of the strains and generate SNP count for the strains
run_BLAST(queryGenes,path_data)

%% Identify SNPS for all genes
driver_SNP_finder(queryGenes,path_data)

%% Plot different haplotypes for natural isolates of figure 1
load('../outputFigures/data_output_figure_1.mat');
filename='naturalIsolates_haplotypes_';

driver_plot_haplotypes(queryGenes,data_output,filename);

%% Plot different haplotypes for allele swaps of figure 4
load('../outputFigures/data_output_figure_4.mat');
data_output=convert_data_output(data_output);
filename='alleleSwaps_haplotypes_';

driver_plot_haplotypes(queryGenes,data_output,filename);

%% BLAST sequencing results to cerevisiae genome. To confirm plasmid identity but in general BLAST against all the cerevisiae strains.
%determine_match_sequences_plasmids()

%% PLOT LOD SCORES
%plot_lod_scores()

