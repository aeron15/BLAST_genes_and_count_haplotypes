function [sequence_table,All_names]=combine_sequences_names(names_genomes,sequences_cells,names_genomes_Liti,sequences_cells_Liti)

%COMBINE_SEQUENCES_NAMES combines data from BLASTING and LITI sequences

%Concatenate arrays
nm1=names_genomes';
nm2=names_genomes_Liti';

All_names=vertcat(nm1,nm2);

seq1=sequences_cells';
seq2=sequences_cells_Liti';
seq_all=vertcat(seq1, seq2);

sz_all=cellfun(@(x) length(x), seq_all, 'UniformOutput', false);

sz_all=cell2mat(sz_all);

sequence_table=cell(length(All_names),max(sz_all));

for iSeq=1:length(seq_all)
    
    seq_now=seq_all{iSeq};
    
    for iPos=1:length(seq_now)
        
        sequence_table{iSeq,iPos}=seq_now{iPos};
        
    end
end

end