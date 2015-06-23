function run_BLAST_20150107()

%This piece of code can run both coding and flanking blasts on different
%genes in the GAL pathway

% load 'doc/47_strains_study';
%
% targetStrains=Strains_20141215;

%% Target Strains that are not in the Liti collection

% targetStrains={
%     'CLIB324'};

targetStrains={
    'YPS163',
    'YPS1009',
    'YJM653',
    'YJM428',
    'YJM421',
    'Y9combined',%'Y9_WashU',
    'WE372',
    'UC5',
    'T7',
    'PW5',
    'NC_02',%'NC-02'
    'M22',
    'IL_01',%'IL-01',
    'I14',
    'FL100',
    'CLIB382',
    'CLIB324'};% Removed CLIB215 since there was only one replicate


%% QUERY GENE SELECTION

type_of_BLAST='flanking';% 20150619 flanking or coding

queryGenes = {'S288C_YDR009W_GAL3_flanking'} %Reduce flanking to only 500 bp
%queryGenes = {['S288C_YDR009W_GAL3_' type_of_BLAST]} %Reduce flanking to only 500 bp


%queryGenes = {'S288C_YBR020W_GAL1_flanking','S288C_YDR009W_GAL3_flanking','S288C_YML051W_GAL80_flanking','S288C_YBR018C_GAL7_flanking','S288C_YMR105C_PGM2_flanking','S288C_YPL248C_GAL4_flanking','S288C_YBR019C_GAL10_flanking'}

%queryGenes = {'S288C_YLR081W_GAL2_flanking','S288C_YMR105C_PGM2_flanking','S288C_YPL248C_GAL4_flanking','S288C_YBR019C_GAL10_flanking'}

%queryGenes = {'S288C_YLR081W_GAL2_flanking'}



%% BLAST
%queryGenes = {'S288C_YDR009W_GAL3_flanking'};
%queryGenes = {'S288C_YBR020W_GAL1_flanking'};
%queryGenes = {'S288C_YBR020W_GAL1_flanking','S288C_YLR081W_GAL2_flanking','S288C_YML051W_GAL80_flanking'};

%queryGenes = {'S288C_YBR020W_GAL1_flanking','S288C_YLR081W_GAL2_flanking','S288C_YDR009W_GAL3_flanking','S288C_YML051W_GAL80_flanking','S288C_YMR105C_PGM2_flanking','S288C_YPL248C_GAL4_flanking','S288C_YBR019C_GAL10_flanking'};

blast_queries_to_targets_extract_ORF(queryGenes,targetStrains);

%% PHYLOGENETIC TREE

%queryGenes ={'S288C_YJL051W_IRC8_coding'};

%queryGenes ={'S288C_YKL068W_NUP100_coding'}

%queryGenes={'S288C_YML080W_DUS1_coding'};

%queryGenes={'S288C_YNL161W_CBK1_coding'};

%queryGenes={'S288C_YNL125C_ESBP6_coding'};

%queryGenes={'S288C_YML056C_IMD4_coding'};

%queryGenes={'S288C_YOR133W_EFT1_coding'};

%queryGenes={'S288C_YBL052C_SAS3_coding'};

%queryGenes={'S288C_YML056C_IMD4_coding'};

%queryGenes={'S288C_YBR163W_EXO5_coding'};

%queryGenes={'S288C_YBR019C_GAL10_flanking'};

%%
% queryGenes ={'S288C_YJL051W_IRC8_coding','S288C_YKL068W_NUP100_coding','S288C_YML080W_DUS1_coding',...
%     'S288C_YNL161W_CBK1_coding','S288C_YNL125C_ESBP6_coding','S288C_YML056C_IMD4_coding',...
%     'S288C_YOR133W_EFT1_coding','S288C_YBL052C_SAS3_coding','S288C_YML056C_IMD4_coding','S288C_YBR163W_EXO5_coding','S288C_YBR019C_GAL10_flanking'};
% 
%blast_queries_to_targets_extract_ORF_FASTA(queryGenes,targetStrains,type_of_BLAST)
%blast_queries_to_targets_extract_ORF_FASTA_cerevisiae(queryGenes,targetStrains,type_of_BLAST)
end