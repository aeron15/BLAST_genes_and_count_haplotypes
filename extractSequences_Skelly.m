function extractSequences_Skelly()
%EXTRACTSEQUENCES_SKELLY extracts and combines sequences to the Skelly
%genome sequences.
% Skelly sequences are +- 1kb of the ORF

pathData = '../data_bioinformatics/sequences_GAL3_Skelly/';

allFiles = dir([pathData '*.out']);

allFiles_names = {allFiles.name};

for iFile=1:length(allFiles_names)
    
    queryStrain_fileName = allFiles_names{iFile};
    
    tmpFasta = fastaread([pathData queryStrain_fileName]);
    
    queryStrain_name = strsplit(queryStrain_fileName, '.');
    
    %Name of the strain
    queryStrain_name{1}
    
    tmpFasta.Sequence
    
    
    
end

