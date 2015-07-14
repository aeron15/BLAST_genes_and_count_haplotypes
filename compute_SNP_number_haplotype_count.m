function compute_SNP_number_haplotype_count(queryGenes)

%This function computes the number of SNPs in some query genes that have
%been precomputed
%Thisi is done this way so that the BLAST running and sequence assemble
%does not have to be performed multiple times

for iQueryGene=1:length(queryGenes)
    
    queryGene=queryGenes{iQueryGene};
    %% All natural isolates. Added 1 extra haplotype for Y9. Determine how many Y12-WashU and Y12-SGRP
    
    %load('strains_in_study_20150622.mat')%List of names of strains, perhaps needs a conversion
    load('../outputFigures/data_output_figure_1.mat')%List of names of strains, perhaps needs a conversion
    strains={data_output.strain};
    
    %Count haplotypes among natural isolates on figure 1 in the experiment with ORF only
    get_orf_promoter=0;
    [ORFStrain_hap,ORFStrain_SNPcount]=count_haplotypes_in_experiment(strains,get_orf_promoter,queryGene)
    
    %>>>>>LOG ENTRIES
    add_entry_log('Number of natural isolates',length(strains);
    add_entry_log(['Haplotypes natural isolates figure 1 using ORF for ' queryGenes{iQueryGene}],ORFStrain_hap);
    
    %Count haplotypes among natural isolates on figure 1 in the experiment with promoter and ORF only
    get_orf_promoter=1;
    [pORFStrain_hap,pORFStrain_SNP]=count_haplotypes_in_experiment(strains,get_orf_promoter,queryGene)
    
    add_entry_log('Haplotypes natural isolates using promoter and ORF ',pORFStrain_hap;
    
    %Count haplotypes among natural isolates on figure 1. Using protein.
    
    
    
    %% Get haplotype count figure 4. Allele swaps in the YJM978 background.
    
    load('../outputFigures/data_output_figure_4.mat')%List of names of strains, perhaps needs a conversion
    strains={data_output.strain};
    
    %Count haplotypes among 36 strains in the experiment with ORF only
    get_orf_promoter=0;
    [ORFStrain_hap,ORFStrain_SNPcount]=count_haplotypes_in_experiment(strains,get_orf_promoter,queryGene)
    
    %>>>>>LOG ENTRIES
    add_entry_log('Number of allele swaps',length(strains);
    add_entry_log(['Haplotypes for allele swaps using ORF ' queryGenes{iQueryGene}],ORFStrain_hap);
    
    
    %Count haplotypes among 36 strains in the experiment with ORF only
    get_orf_promoter=1;
    [pORFStrain_hap,pORFStrain_SNP]=count_haplotypes_in_experiment(strains,get_orf_promoter,queryGene)
    
    %>>>>>LOG ENTRIES
    addd_entry_log(['Haplotypes for allele swaps prmoter and ORF ' queryGenes{iQueryGene}],pORFStrain_hap);
    
    
end


end