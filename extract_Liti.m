function [names_genomes,sequences_cells,sequences_liti]=extract_Liti(queryGene,path_data)

% EXTRACT_LITI extracts the first cerevisiae strains (39)

tmp = fastaread([path_data 'data/query_genes/' queryGene '.fsa.txt']);

conversion_table=csv2cell([path_data 'doc/20150310_Genes_conversion.csv']);

query_genes_names=conversion_table(:,1);

idx=find(strcmp(queryGene,query_genes_names));

sequences_liti=fastaread([path_data 'sequences/' conversion_table{idx,2}]);

seq_query=tmp.Sequence;

startORF=1001;

%% Restrict 'sequences_liti' to specific strains in the study
sequences_liti=reduce_sequences_liti(sequences_liti);

for iSeq=1:length(sequences_liti)
    
    table_assemble={};
    
    seq_subject=sequences_liti(iSeq).Sequence;
    
    idx_rmv=regexp(seq_subject,'-');
    
    seq_subject(idx_rmv)=[];
    
    idx_rmv=regexp(seq_subject,'N');
    
    seq_subject(idx_rmv)=[];
    
    idx_rmv=regexp(seq_subject,'=');
    
    seq_subject(idx_rmv)=[];
    
    idx_rmv=regexp(seq_subject,'_');
    
    seq_subject(idx_rmv)=[];
    
    idx_rmv=regexp(seq_subject,' ');
    
    seq_subject(idx_rmv)=[];
    
    [iPosition,seq_hit_subject_cell]=map_hit(seq_query,seq_subject);
    
    for iBase=1:length(seq_hit_subject_cell)
        
        table_assemble{iPosition}=seq_hit_subject_cell{iBase};
        iPosition=iPosition+1;
    end

    
    %% Save names and sequences
    names_genomes{iSeq}=sequences_liti(iSeq).Header;
    sequences_cells{iSeq}=table_assemble;
    
end

end