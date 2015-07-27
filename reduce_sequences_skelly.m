function sequences_skelly_reduced=reduce_sequences_skelly(sequences_skelly)
%REDUCE_SEQUENCES_SKELLY
%Reduces the FASTA file to the sequences in targetStrains_Skelly

load('targetStrains_Skelly.mat')

skellyStrains_names={sequences_skelly.Header};

for iCounter=1:length(targetStrains_Skelly)
    
    StrainToKeep_idx=find(strcmp(skellyStrains_names,targetStrains_Skelly{iCounter}));
    sequences_skelly_reduced(iCounter).Header=skellyStrains_names{StrainToKeep_idx};
    sequences_skelly_reduced(iCounter).Sequence=sequences_skelly(StrainToKeep_idx).Sequence;
    
end

