function driver_plot_clusters(queryGenes,data_output)

%DRIVER_PLOT_CLUSTERS plots the data into clusters of either

%queryGenes = {'S288C_YDR009W_GAL3_flanking','S288C_YML051W_GAL80_flanking'}

%Compute mean of the replicates
[vector,strains]=compute_mean_data_output(data_output);


for iqueryGenes=1:length(queryGenes)
    gene=queryGenes{iqueryGenes};

    % ONLY ORF DNA
    %load (['output/DNA_DATA_ONLY_ORF' gene]);
    %QueryStrain_name=[gene '_ONLY_ORF'];
    %plot_clusters_SNPs_protein(vector,strains,DNA_idx_identical_sequences,QueryStrain_name);
    
    %
    load (['../data/DNA_DATA_PROMOTER_ORF' gene])
    QueryStrain_name=[gene '_PROMOTER_ORF'];
    plot_clusters_SNPs_protein(vector,strains,DNA_idx_identical_sequences,QueryStrain_name);
    
    %
    load (['../data/PROT_DATA_' gene])
    QueryStrain_name=[gene '_PROT'];
    plot_clusters_SNPs_protein(vector,strains,PROT_idx_identical_sequences,QueryStrain_name);
    
end
end