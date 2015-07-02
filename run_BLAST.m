function run_BLAST(queryGenes)
%RUN_BLAST runs BLAST on targeted strains and then uses the Liti collection
%to complete the number of strains

path_data='/Users/RenanEscalante/Dropbox/Phenotypic_diversity/var_bioinfo/20141115_BLAST/';
load('targetStrains_WashU.mat')
targetStrains=targetStrains_WashU;

%FOR TESTING PURPOSES USE ONE GENE
%targetStrains={'YPS163'}

% BLAST sequences and generate fasta files as well as table sequences used for
blast_queries_to_targets_extract_ORF(queryGenes,targetStrains,path_data);

end