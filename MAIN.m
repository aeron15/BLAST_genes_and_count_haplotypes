function MAIN

%MAIN script determines the number of haplotypes and SNPs for genes across
%strains in the paper
% For the haplotype count sequences for Liti strains (24 strains in targetStrains_Liti) derived from whole
% genome sequencing and other sequences are blasted from the Fay collection
% (18 strains in targetStrains_WashU).
%
% Python scripts determine coverage of sequencing

%Create an output folder if it does not exist
if ~exist('../outputFigures')
    mkdir('../outputFigures');
end
%% Query genes
queryGenes = {'S288C_YDR009W_GAL3_flanking'}
%queryGenes = {'S288C_YBR020W_GAL1_flanking','S288C_YML051W_GAL80_flanking'}
%queryGenes = {'S288C_YBR020W_GAL1_flanking','S288C_YBR018C_GAL7_flanking','S288C_YMR105C_PGM2_flanking','S288C_YPL248C_GAL4_flanking','S288C_YBR019C_GAL10_flanking'}


%% Collect sequences of the strains and generate SNP count for the strains

%Path to the data and BLAST location
path_data='/Users/RenanEscalante/Dropbox/Phenotypic_diversity/var_bioinfo/20141115_BLAST/';

run_BLAST(queryGenes,path_data)

%% Plot different haplotypes

load('../outputFigures/data_output_figure_1.mat')
driver_plot_clusters(queryGenes,data_output)

%%
%compute_SNP_number_haplotype_count(queryGenes)





