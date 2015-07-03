function driver_plot_clusters()

%DRIVER_PLOT_CLUSTERS plots the data into clusters of either

%% CHANGE the data to set points value

load('/Users/RenanEscalante/Documents/phenotypic_variation/Analysis_data_create_figure/data_output_figure_1.mat')
[vector,strains]=compute_mean_data_output(data_output);

%%
load ('output/DNA_DATA_ONLY_ORFS288C_YDR009W_GAL3_flanking')
gene='GAL3_ONLY_ORF';
plot_clusters_SNPs_protein(vector,strains,DNA_idx_identical_sequences,gene)

%%
load ('output/DNA_DATA_PROMOTER_ORFS288C_YDR009W_GAL3_flanking')
gene='GAL3_PROMOTER_ORF';
plot_clusters_SNPs_protein(vector,strains,DNA_idx_identical_sequences,gene)

%%
load ('output/PROT_DATA_S288C_YDR009W_GAL3_flanking')
gene='GAL3_PROT';
plot_clusters_SNPs_protein(vector,strains,PROT_idx_identical_sequences,gene)

%%
load ('output/PROT_DATA_S288C_YML051W_GAL80_flanking')
gene='GAL80_PROT';
plot_clusters_SNPs_protein(vector,strains,PROT_idx_identical_sequences,gene)

end