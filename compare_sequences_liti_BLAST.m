function compare_sequences_liti_BLAST(names_genomes,sequences_cells,names_genomes_Liti,sequences_cells_Liti,queryGene,path_data)
%function [tot_changes,syn_changes,ns_changes]=compare_sequences_liti_BLAST(names_genomes,sequences_cells,names_genomes_Liti,sequences_cells_Liti,queryGene,path_data)

%COMPARE_SEQUENCES_LITI  create table for SNP counting
% Load data and concatenate arrays for SNP count. Center all sequences
% around 1001
%modified on 20150622 to exclude protein SNP count due to bugs in the
%protein code

%Concatenate arrays
nm1=names_genomes';
nm2=names_genomes_Liti';

nm_all=vertcat(nm1,nm2);

seq1=sequences_cells';
seq2=sequences_cells_Liti';
seq_all=vertcat(seq1, seq2);

sz_all=cellfun(@(x) length(x), seq_all, 'UniformOutput', false);

sz_all=cell2mat(sz_all);

sequence_table=cell(length(nm_all),max(sz_all));

for iSeq=1:length(seq_all)
    
    seq_now=seq_all{iSeq};
    
    for iPos=1:length(seq_now)
        
        sequence_table{iSeq,iPos}=seq_now{iPos};
        
    end
end

%% Identify protein SNPs and clusters of protein

% protein_table=convert_to_protein(sequence_table,queryGene);
% %save('protein_table')
% %GET protein SNPs and clusters
% 
% PROT_SNP_Structure=SNP_finder_protein(protein_table,nm_all);
% 
% 
% PROT_idx_identical_sequences=determine_unique_protein(PROT_SNP_Structure, protein_table, nm_all,queryGene);
% 
% save(['output/PROT_DATA_' queryGene],'PROT_SNP_Structure','PROT_idx_identical_sequences','protein_table','nm_all')

%save('idx_identical_sequences_protGAL3','PROT_idx_identical_sequences')

%% SNP and cluster count for DNA. Specify region

get_orf_promoter=1;
%haplotypes for the coding region
[DNA_SNP_structure,sequence_table_DNA]=SNP_finder_DNA(sequence_table,nm_all,get_orf_promoter,queryGene,path_data);
DNA_idx_identical_sequences=determine_unique(DNA_SNP_structure, sequence_table_DNA, nm_all);
save(['output/DNA_DATA_PROMOTER_ORF' queryGene],'DNA_SNP_structure','DNA_idx_identical_sequences','sequence_table_DNA','nm_all');

%%

get_orf_promoter=0;
%haplotypes for the coding region
[DNA_SNP_structure,sequence_table_DNA]=SNP_finder_DNA(sequence_table,nm_all,get_orf_promoter,queryGene,path_data);
DNA_idx_identical_sequences=determine_unique(DNA_SNP_structure, sequence_table_DNA, nm_all);
save(['output/DNA_DATA_ONLY_ORF' queryGene],'DNA_SNP_structure','DNA_idx_identical_sequences','sequence_table_DNA','nm_all');


%% COMPUTE synonymous versus non synonymous SNPs. Length of ORF
% tot_changes=size(DNA_SNP_structure,2);
% ns_changes=size(PROT_SNP_Structure,2);
% syn_changes=tot_changes-ns_changes;


end

