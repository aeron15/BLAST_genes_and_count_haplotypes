function compute_SNP_number_haplotype_count(queryGenes)

%This function computes the number of SNPs in some query genes that have
%been precomputed
%Thisi is done this way so that the BLAST running and sequence assemble
%does not have to be performed multiple times
for iQueryGene=1:length(queryGenes)
    
    queryGene=queryGenes{iQueryGene};
    %% All natural isolates. Added 1 extra haplotype for Y9. Determine how many Y12-WashU and Y12-SGRP
    
    load('strains_in_study_20150622.mat')%List of names of strains, perhaps needs a conversion
    
    %Count haplotypes among 36 strains in the experiment with ORF only
    get_orf_promoter=0;
    [ORFStrain_hap,ORFStrain_SNPcount]=count_haplotypes_in_experiment(strains,get_orf_promoter,queryGene)
    
    %Count haplotypes among 36 strains in the experiment with ORF only
    get_orf_promoter=1;
    [pORFStrain_hap,pORFStrain_SNP]=count_haplotypes_in_experiment(strains,get_orf_promoter,queryGene)
    
    %% Get haplotype count figure 4
    
    load('strains_allele_swaps.mat')
    
    %Count haplotypes among 36 strains in the experiment with ORF only
    get_orf_promoter=0;
    [ORFStrain_hap,ORFStrain_SNPcount]=count_haplotypes_in_experiment(strains,get_orf_promoter,queryGene)
    
    %Count haplotypes among 36 strains in the experiment with ORF only
    get_orf_promoter=1;
    [pORFStrain_hap,pORFStrain_SNP]=count_haplotypes_in_experiment(strains,get_orf_promoter,queryGene)
    
end


end