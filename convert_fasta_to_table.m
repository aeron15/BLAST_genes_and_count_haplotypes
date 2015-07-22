function [queryStrain_names, sequences_cells] = convert_fasta_to_table(sequences_fasta,queryStrain_seq)

%Converts a fasta file read in MATLAB to two cell arrays, one with the names of the strains
% and a second with the sequences of the strains


for iSeq=1:length(sequences_fasta)
    
    table_assemble={};
    
    subjectStrain_seq=sequences_fasta(iSeq).Sequence;
    
    idx_rmv=regexp(subjectStrain_seq,'-');
    
    subjectStrain_seq(idx_rmv)=[];
    
    idx_rmv=regexp(subjectStrain_seq,'N');
    
    subjectStrain_seq(idx_rmv)=[];
    
    idx_rmv=regexp(subjectStrain_seq,'=');
    
    subjectStrain_seq(idx_rmv)=[];
    
    idx_rmv=regexp(subjectStrain_seq,'_');
    
    subjectStrain_seq(idx_rmv)=[];
    
    idx_rmv=regexp(subjectStrain_seq,' ');
    
    subjectStrain_seq(idx_rmv)=[];
    
    %Use query genome to map the liti sequence
    [iPosition,seq_hit_subject_cell]=map_hit(queryStrain_seq,subjectStrain_seq);
    
    for iBase=1:length(seq_hit_subject_cell)
        
        table_assemble{iPosition}=seq_hit_subject_cell{iBase};
        iPosition=iPosition+1;
    end
    
    
    %% Save names and sequences
    queryStrain_names{iSeq}=sequences_fasta(iSeq).Header;
    sequences_cells{iSeq}=table_assemble;
    
end