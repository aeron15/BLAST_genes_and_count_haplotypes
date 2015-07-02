function run_BLAST()

%This piece of code can run both coding and flanking blasts on different
%genes in the GAL pathway

path_data='/Users/RenanEscalante/Dropbox/Phenotypic_diversity/var_bioinfo/20141115_BLAST/';
load('targetStrains_WashU.mat')
targetStrains=targetStrains_WashU;

%for testing purposes use one genome
targetStrains={'YPS163'}
%% QUERY GENE SELECTION

type_of_BLAST='flanking';% 20150619 flanking or coding

queryGenes = {'S288C_YDR009W_GAL3_flanking'} %Reduce flanking to only 500 bp

%% BLAST sequences and generate fasta files as well as table sequences used for 

blast_queries_to_targets_extract_ORF(queryGenes,targetStrains,path_data);

%% COUNT HAPLOTYPES

count_haplotypes_in_experiment()

end