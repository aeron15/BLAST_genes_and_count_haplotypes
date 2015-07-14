function driver_plot_haplotypes(queryGenes,data_output)
%DRIVER_PLOT_CLUSTERS plots the data into clusters of either

%Compute mean of the replicates
[vector,strains]=compute_mean_data_output(data_output);


for iqueryGenes=1:length(queryGenes)
    gene=queryGenes{iqueryGenes};

    % ONLY ORF DNA
    load (['../data/DNA_DATA_ONLY_ORF' gene]);
    QueryStrain_name=[gene '_ONLY_ORF'];
    filename=['naturalIsolates_haplotypes_' gene];
    
    plot_clusters_SNPs_protein(vector,strains,DNA_idx_identical_sequences,QueryStrain_name,filename);
    
    %
    load (['../data/DNA_DATA_PROMOTER_ORF' gene])
    QueryStrain_name=[gene '_PROMOTER_ORF'];
    filename=['naturalIsolates_haplotypes_' gene];
    
    plot_clusters_SNPs_protein(vector,strains,DNA_idx_identical_sequences,QueryStrain_name,filename);
    
    %
    load (['../data/PROT_DATA_' gene])
    QueryStrain_name=[gene '_PROT'];
    filename=['naturalIsolates_haplotypes_' gene];
    
    plot_clusters_SNPs_protein(vector,strains,PROT_idx_identical_sequences,QueryStrain_name,filename);
    
end
end