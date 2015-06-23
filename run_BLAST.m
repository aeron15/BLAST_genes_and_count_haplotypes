function run_BLAST()

%This piece of code can run both coding and flanking blasts on different
%genes in the GAL pathway

path_data='/Users/RenanEscalante/Dropbox/Phenotypic_diversity/var_bioinfo/20141115_BLAST/';

%% Target Strains that are not in the Liti collection

targetStrains={
    'YPS163',
    'YPS1009'}
%     'YJM653',
%     'YJM428',
%     'YJM421',
%     'Y9combined',%'Y9_WashU',
%     'WE372',
%     'UC5',
%     'T7',
%     'PW5',
%     'NC_02',%'NC-02'
%     'M22',
%     'IL_01',%'IL-01',
%     'I14',
%     'FL100',
%     'CLIB382',
%     'CLIB324'};% Removed CLIB215 since there was only one replicate




%% QUERY GENE SELECTION

type_of_BLAST='flanking';% 20150619 flanking or coding

queryGenes = {'S288C_YDR009W_GAL3_flanking'} %Reduce flanking to only 500 bp

blast_queries_to_targets_extract_ORF(queryGenes,targetStrains,path_data);

end