function run_BLAST(queryGenes,path_data)
%RUN_BLAST runs BLAST on targeted strains and then uses the Liti collection
%to complete the number of strains

%% Load specific target strains for BLAST

<<<<<<< Updated upstream
load('targetStrains_BLAST.mat')
%targetStrains_BLAST={'REF'};%for testing purposes
=======
%load('targetStrains_BLAST.mat')
targetStrains_BLAST={'YPS163'};%for testing purposes
>>>>>>> Stashed changes

blast_queries_to_targets_extract_ORF(queryGenes,targetStrains_BLAST,path_data);

end