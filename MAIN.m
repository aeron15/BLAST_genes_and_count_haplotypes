function MAIN

%MAIN script that determines the number of haplotypes and SNPs in the paper

%% Restrict data for specific strains
% determine_strains_for_BLAST()

%% Query genes
queryGenes = {'S288C_YDR009W_GAL3_flanking'} %Reduce flanking to only 500 bp
%queryGenes = {'S288C_YML051W_GAL80_flanking'};

%% Collect sequences of the strains and generate SNP count for the strains

%run_BLAST(queryGenes)

compute_SNP_number_haplotype_count(queryGenes)

display('pause')


