function identfy_SNPs(sequence_table,All_names,queryGene,path_output_bionformatics)
%COMPARE_SEQUENCES_LITI  creates table for SNP counting
% Load output_bionformatics and concatenate arrays for SNP count. Center all sequences
% around 1001 (start site)

%% SNP count for PROTEIN output_bionformatics
protein_table=convert_to_protein(sequence_table,queryGene);
PROT_SNP_Structure=SNP_finder_protein(protein_table,All_names);
PROT_idx_identical_sequences=determine_unique_protein(PROT_SNP_Structure, protein_table, All_names,queryGene);

save(['../output_bioinformatics/PROT_' queryGene],'PROT_SNP_Structure','PROT_idx_identical_sequences','protein_table','All_names')
save('idx_identical_sequences_protGAL3','PROT_idx_identical_sequences')
%% SNP and cluster count for DNA. Specify region

get_orf_promoter=1;
%haplotypes for the coding region
[DNA_SNP_structure,sequence_table_DNA]=SNP_finder_DNA(sequence_table,All_names,get_orf_promoter,queryGene,path_output_bionformatics);
DNA_idx_identical_sequences=determine_unique(DNA_SNP_structure, sequence_table_DNA, All_names);
save(['../output_bioinformatics/DNA_PROMOTER_ORF' queryGene],'DNA_SNP_structure','DNA_idx_identical_sequences','sequence_table_DNA','All_names');

get_orf_promoter=0;
%haplotypes for the coding region
[DNA_SNP_structure,sequence_table_DNA]=SNP_finder_DNA(sequence_table,All_names,get_orf_promoter,queryGene,path_output_bionformatics);
DNA_idx_identical_sequences=determine_unique(DNA_SNP_structure, sequence_table_DNA, All_names);
save(['../output_bioinformatics/DNA_ONLY_ORF' queryGene],'DNA_SNP_structure','DNA_idx_identical_sequences','sequence_table_DNA','All_names');


%% COMPUTE synonymous versus non synonymous SNPs. Length of ORF
tot_changes=size(DNA_SNP_structure,2);
ns_changes=size(PROT_SNP_Structure,2);
syn_changes=tot_changes-ns_changes;


end

