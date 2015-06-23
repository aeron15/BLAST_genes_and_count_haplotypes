function [iPosition,seq_hit_subject_cell]=map_hit(seq_query,seq_subject)

%MAP_HIT maps the sequences in an alignment to the coordinates in the
%reference gene. Returns the seq_subject formatted to match the coordinates
%of the query (reference gene used GAL3, in our case)
% 1001 is the start codon ATG


[Score, Alignment, Start] = swalign(seq_query,seq_subject);

iPosition=Start(1,1);

% Extract the sequence of the query (gene in the refernce for BLAST)

query_hit_seq=Alignment(1,:);
subject_hit_seq=Alignment(3,:);
seq_tmp=subject_hit_seq;

%Finding insertions in subject (that is - in the query
pos_to_eliminate=[regexp(query_hit_seq,'-')];    

[pos,~,~,dash]=regexp(query_hit_seq,'[-]+');    

%Finding insertions in query
regexp(subject_hit_seq,'[-]+');

%%

length_insertions=cellfun(@length,dash,'UniformOutput',false);
length_insertions=cell2mat(length_insertions);
offset=cumsum(length_insertions);
offset=[0 offset];

%% Transform subject sequence to cell

seq_tmp(pos_to_eliminate)=[];
seq_hit_subject_cell=str2cell(seq_tmp);


%% DEAL with insertions in the subject sequence
%Reshape the subject sequence 

for iBP=1:length(pos)
   
    %Extract indel
    str=dash(iBP);
    len_seq_indel=length(str{:});
    start_indel=pos(iBP)-1;
    indel={subject_hit_seq((start_indel:start_indel+len_seq_indel))};

    %Insert in the right position of the alignment
    pos_indel=(pos(iBP)-offset(iBP))-1;
    seq_hit_subject_cell{pos_indel}=indel;
    
end

% Extract sequence of the subject

%display('done')





