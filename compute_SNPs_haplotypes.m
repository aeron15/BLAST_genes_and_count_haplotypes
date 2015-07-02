function compute_SNPs_haplotypes()

%Extracts from a gene list the relevant data without running BLAST again


%% Identification of SNPs with respect to the reference strain S288C
    identfy_SNPs(sequence_table,All_names,queryGenes{iquery},path_data)