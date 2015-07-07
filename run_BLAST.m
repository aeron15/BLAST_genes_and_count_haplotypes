function run_BLAST(queryGenes)
%RUN_BLAST runs BLAST on targeted strains and then uses the Liti collection
%to complete the number of strains

path_data='/Users/RenanEscalante/Dropbox/Phenotypic_diversity/var_bioinfo/20141115_BLAST/';

load('targetStrains_WashU.mat')

%targetStrains_WashU={'YPS163'};

blast_queries_to_targets_extract_ORF(queryGenes,targetStrains_WashU,path_data);

end