function run_BLAST()
%RUN_BLAST runs BLAST on targeted strains and then uses the Liti collection
%to complete the number of strains
%Collect sequences of the strains and generate SNP count for the strains
%This piece of code can run both coding and flanking blasts on different
%genes in the GAL pathway

%% Restrict data for specific strains
determine_strains_for_BLAST()

path_data='/Users/RenanEscalante/Dropbox/Phenotypic_diversity/var_bioinfo/20141115_BLAST/';
load('targetStrains_WashU.mat')
targetStrains=targetStrains_WashU;

%for testing purposes use one genome
%targetStrains={'YPS163','CLIB324'}

%% QUERY GENE SELECTION

type_of_BLAST='flanking';% 20150619 flanking or coding

%queryGenes = {'S288C_YDR009W_GAL3_flanking'} %Reduce flanking to only 500 bp
queryGenes = {'S288C_YML051W_GAL80_flanking'};


%% BLAST sequences and generate fasta files as well as table sequences used for
blast_queries_to_targets_extract_ORF(queryGenes,targetStrains,path_data);

end