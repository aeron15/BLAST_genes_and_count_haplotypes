function identfy_SNPs(sequence_table,All_names,queryGene,path_data)
%function [tot_changes,syn_changes,ns_changes]=compare_sequences_liti_BLAST(names_genomes,sequences_cells,names_genomes_Liti,sequences_cells_Liti,queryGene,path_data)

%COMPARE_SEQUENCES_LITI  creates table for SNP counting
% Load data and concatenate arrays for SNP count. Center all sequences
% around 1001 (start site)

%% SNP count for PROTEIN DATA
protein_table=convert_to_protein(sequence_table,queryGene);
PROT_SNP_Structure=SNP_finder_protein(protein_table,All_names);
PROT_idx_identical_sequences=determine_unique_protein(PROT_SNP_Structure, protein_table, All_names,queryGene);

save(['../data/PROT_DATA_' queryGene],'PROT_SNP_Structure','PROT_idx_identical_sequences','protein_table','All_names')
save('idx_identical_sequences_protGAL3','PROT_idx_identical_sequences')
%% SNP and cluster count for DNA. Specify region

get_orf_promoter=1;
%haplotypes for the coding region
[DNA_SNP_structure,sequence_table_DNA]=SNP_finder_DNA(sequence_table,All_names,get_orf_promoter,queryGene,path_data);
DNA_idx_identical_sequences=determine_unique(DNA_SNP_structure, sequence_table_DNA, All_names);
save(['../data/DNA_DATA_PROMOTER_ORF' queryGene],'DNA_SNP_structure','DNA_idx_identical_sequences','sequence_table_DNA','All_names');

get_orf_promoter=0;
%haplotypes for the coding region
[DNA_SNP_structure,sequence_table_DNA]=SNP_finder_DNA(sequence_table,All_names,get_orf_promoter,queryGene,path_data);
DNA_idx_identical_sequences=determine_unique(DNA_SNP_structure, sequence_table_DNA, All_names);
save(['../data/DNA_DATA_ONLY_ORF' queryGene],'DNA_SNP_structure','DNA_idx_identical_sequences','sequence_table_DNA','All_names');


%% COMPUTE synonymous versus non synonymous SNPs. Length of ORF
tot_changes=size(DNA_SNP_structure,2);
ns_changes=size(PROT_SNP_Structure,2);
syn_changes=tot_changes-ns_changes;


end

