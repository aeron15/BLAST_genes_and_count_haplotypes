function driver_plot_haplotypes(queryGenes,data_output,filename)
%DRIVER_PLOT_HAPLOTYPES plots strains witht the same sequence (haplotypes)

%Compute mean of the replicates
[vector,strains]=compute_mean_data_output(data_output);

for iqueryGenes=1:length(queryGenes)

    gene=queryGenes{iqueryGenes};

    %
    load (['../output_bioinformatics/DNA_ONLY_ORF' gene]);
    QueryStrain_name=[gene '_ONLY_ORF'];
    
    plot_clusters_SNPs_protein(vector,strains,DNA_idx_identical_sequences,QueryStrain_name,filename);
    
    %
    load (['../output_bioinformatics/DNA_PROMOTER_ORF' gene])
    QueryStrain_name=[gene '_PROMOTER_ORF'];
    
    plot_clusters_SNPs_protein(vector,strains,DNA_idx_identical_sequences,QueryStrain_name,filename);
    
    %
    load (['../output_bioinformatics/PROT_' gene])
    QueryStrain_name=[gene '_PROT'];
    
    plot_clusters_SNPs_protein(vector,strains,PROT_idx_identical_sequences,QueryStrain_name,filename);
    
end

end