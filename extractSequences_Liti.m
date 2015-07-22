function [queryStrain_names,sequences_cells,sequences_liti]=extractSequences_Liti(queryGene,path_data)

% EXTRACT_LITI extracts the first cerevisiae strains sequences from the Liti collection (39)

tmpFASTA = fastaread([path_data 'data/query_genes/' queryGene '.fsa.txt']);%query gene sequence

conversion_table=csv2cell(['Gene_FileNames_StandardNames_Lenght_conversion.csv']);

query_genes_names=conversion_table(:,1);

idx=find(strcmp(queryGene,query_genes_names));

sequences_liti=fastaread([path_data 'sequences/' conversion_table{idx,2}]);

queryStrain_seq=tmpFASTA.Sequence;

startORF=1001;

%% Restrict 'sequences_liti' to specific strains in the study. 24 strains.
sequences_liti=reduce_sequences_liti(sequences_liti);

%Convert fasta to tabular format for haplotype analysis
[queryStrain_names, sequences_cells ] = convert_fasta_to_table(sequences_liti,queryStrain_seq);

end