function sequences_liti_reduced=reduce_sequences_liti(sequences_liti)
%REDUCE_SEQUENCES_LITI
%Reduces the FASTA file to the sequences in targetStrains_Liti
%It shows a warning if the number of Strains is not the same to the number
%of targetStrains

load('targetStrains_Liti.mat')
LitiStrains_names={sequences_liti.Header};

for iCounter=1:length(targetStrains_Liti)
    
    StrainToKeep_idx=find(strcmp(LitiStrains_names,targetStrains_Liti{iCounter}));
    
    sequences_liti_reduced(iCounter).Header=LitiStrains_names{StrainToKeep_idx};
    sequences_liti_reduced(iCounter).Sequence=sequences_liti(StrainToKeep_idx).Sequence;
    
end
