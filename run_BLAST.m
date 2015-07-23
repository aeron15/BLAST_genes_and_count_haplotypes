function run_BLAST(queryGenes,path_data)
%RUN_BLAST runs BLAST on targeted strains and then uses the Liti collection
%to complete the number of strains

%% Load specific target strains for BLAST

load('targetStrains_WashU.mat')

%targetStrains_WashU={'YPS163'};%for testing purposes

blast_queries_to_targets_extract_ORF(queryGenes,targetStrains_WashU,path_data);

end