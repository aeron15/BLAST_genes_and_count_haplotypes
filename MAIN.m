function MAIN

%MAIN script that determines the number of haplotypes and SNPs in the paper

%% Query genes
queryGenes = {'S288C_YDR009W_GAL3_flanking','S288C_YML051W_GAL80_flanking'}

%% Collect sequences of the strains and generate SNP count for the strains

run_BLAST(queryGenes)

%% Plot different haplotypes

load('/Users/RenanEscalante/Documents/phenotypic_variation/Analysis_data_create_figure/data_output_figure_1.mat')
driver_plot_clusters(queryGenes,data_output)

%%
compute_SNP_number_haplotype_count(queryGenes)



