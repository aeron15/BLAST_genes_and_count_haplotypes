function outputPathData = edit_pathData(queryGene)

%Adds path to Skelly sequences for a queryGene  

splittedStrings = strsplit(queryGene,'_');

queryGeneForSearch = splittedStrings{3};

outputPathData = [ '../data_bioinformatics/sequences_' queryGeneForSearch '_Skelly/'];