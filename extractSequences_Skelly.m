function [queryStrain_names,sequences_cells,sequences_skelly_reduced] = extractSequences_Skelly(queryGene,path_data)
%EXTRACTSEQUENCES_SKELLY extracts and combines sequences to the Skelly
%genome sequences.
% Skelly sequences are +- 1kb of the ORF
% Creates a fasta file
% Create folders for other sequences GAL80, other genes

pathData = '../data_bioinformatics/sequences_GAL3_Skelly/';

allFiles = dir([pathData '*.out']);

allFiles_names = {allFiles.name};

for iFile=1:length(allFiles_names)
    
    queryStrain_fileName = allFiles_names{iFile};
    
    tmpFasta = fastaread([pathData queryStrain_fileName]);
    
    queryStrain_name = strsplit(queryStrain_fileName, '.');
    
    %Create FASTA file
    sequences_skelly(iFile).Header = queryStrain_name{1};
    sequences_skelly(iFile).Sequence = tmpFasta.Sequence;
        
end

%% Restrict 'sequences_liti' to specific strains in the study. 15 strains. (DO THIS)
%Restrict sequences to only the ones in the study
sequences_skelly_reduced=reduce_sequences_skelly(sequences_skelly);

%% EXTRACT_LITI extracts the first cerevisiae strains sequences from the Liti collection (39)

tmpFASTA = fastaread([path_data 'data/query_genes/' queryGene '.fsa.txt']);%query gene sequence
queryStrain_seq=tmpFASTA.Sequence;

%Convert fasta to tabular format for haplotype analysis
[queryStrain_names, sequences_cells ] = convert_fasta_to_table(sequences_skelly_reduced,queryStrain_seq);


