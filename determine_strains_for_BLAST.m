function determine_strains_for_BLAST()

%DETERMINE_STRAINS_FOR_BLAST
%determines the sequences to be used in the blast search
%Liti sequences are preferred because they were assembled from genome
%sequencing
%We can also test our assembly results

%% Load 42 strains in the study
load('strains_in_study.mat');
load('strains_for_BLAST_washU_Liti.mat');
load('strains_Liti.mat')

%Sequences in Liti
length(intersect(strains_in_study,strains_Liti))

%A is the strains that we will take form Liti et. al
targetStrains_Liti=intersect(strains_in_study,strains_Liti);
%B are the strains that we will take from WashU
targetStrains_WashU=setdiff(strains_in_study,targetStrains_Liti);

save('targetStrains_WashU','targetStrains_WashU');
save('targetStrains_Liti','targetStrains_Liti');
%length(intersect(strains_in_study,strains_for_BLAST_washU_Liti))
% length(intersect(strains,strains_for_BLAST_washU_Liti))
% length(intersect(strains_for_BLAST_washU_Liti,strains))

display('done')
