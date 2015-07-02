function MAIN

%MAIN script that determines the number of haplotypes in the paper

%% Collect sequences of the strains and generate SNP count for the strains
%run_BLAST()

%% All natural isolates. Added 1 extra haplotype for Y9. Determine how many Y12-WashU and Y12-SGRP

load('output/strains_in_study_20150622.mat')%List of names of strains, perhaps needs a conversion

%Count haplotypes among 36 strains in the experiment with ORF only
get_orf_promoter=0;
ORFStrain_hap=count_haplotypes_in_experiment(strains,get_orf_promoter)

%Count haplotypes among 36 strains in the experiment with ORF only
get_orf_promoter=1;
pORFStrain_hap=count_haplotypes_in_experiment(strains,get_orf_promoter)


%%

load('output/strains_allele_swaps.mat')

%Count haplotypes among 36 strains in the experiment with ORF only
get_orf_promoter=0;
ORFStrain_hap=count_haplotypes_in_experiment(strains,get_orf_promoter)

%Count haplotypes among 36 strains in the experiment with ORF only
get_orf_promoter=1;
pORFStrain_hap=count_haplotypes_in_experiment(strains,get_orf_promoter)

display('pause')


