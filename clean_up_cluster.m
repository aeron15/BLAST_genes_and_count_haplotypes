function clean_cluster_analyzed=clean_up_cluster(cluster_analyzed,strains)

%CLEAN_UP_CLUSTER renames the cluster to the sequence used in the
%setpoints_value structure so that the names match

%% List of substitutions. These are the strain names in the experiments

substitution_list={
    'Gal3YJM978';
    'L_1528';
    'L_1374';
%    '273614N';
%    '378604X';
%    '322134S';
    'I14';
    'L1374';
    'RM11_1A';
    'UWOPS87';
    'YIIc17';
    'NC_02';
    'GAL3_ORF YDR009W SGDID:S000002416';
    'S288c';
    'IL_01';
    'UWOPS03';
    'UWOPS05_227_2';
    'UWOPS87_2421';
    'Y9combined';
    'Y12SGRP'};

%'Y12SGRP';
%'Y9';
%'Y12';
%'Y9combined';



tmp=repmat({nan},length(substitution_list),1);

substitution_list(:,2)=tmp;

substitution_list{find(strcmp(substitution_list(:,1),'Gal3YJM978')),2}='YJM978';
substitution_list{find(strcmp(substitution_list(:,1),'L_1528')),2}='L-1528';
substitution_list{find(strcmp(substitution_list(:,1),'L_1374')),2}='L-1374';
substitution_list{find(strcmp(substitution_list(:,1),'I14')),2}='I-14';

substitution_list{find(strcmp(substitution_list(:,1),'UWOPS05_227_2')),2}='UWOPS05-227.2';
substitution_list{find(strcmp(substitution_list(:,1),'UWOPS03')),2}='UWOPS03-461.4';
substitution_list{find(strcmp(substitution_list(:,1),'UWOPS87_2421')),2}='UWOPS87-242.1';
substitution_list{find(strcmp(substitution_list(:,1),'NC_02')),2}='NC-02';
substitution_list{find(strcmp(substitution_list(:,1),'YIIc17')),2}='YIIc17-E5';
substitution_list{find(strcmp(substitution_list(:,1),'IL_01')),2}='IL-01';
substitution_list{find(strcmp(substitution_list(:,1),'S288c')),2}='S288C';
substitution_list{find(strcmp(substitution_list(:,1),'RM11_1A')),2}='Bb32';
substitution_list{find(strcmp(substitution_list(:,1),'Y9combined')),2}='Y9-WashU';
substitution_list{find(strcmp(substitution_list(:,1),'Y12SGRP')),2}='Y12-SGRP';

%% Remove certain matches for 6 strains + REF
% Test remove BC187
StrainsRemoved_set={'273614N','REF'};
%intersect(cluster_analyzed,StrainsRemoved_set)

%%
cluster_analyzed=setdiff(cluster_analyzed,StrainsRemoved_set);%Remove unwanted strains

for iCounter=1:length(cluster_analyzed)
        
    if isempty(find(strcmp(cluster_analyzed{iCounter},strains)))
        
        try
            
            clean_cluster_analyzed{iCounter}=substitution_list{find(strcmp(substitution_list(:,1),cluster_analyzed{iCounter})),2};
            
        catch
            clean_cluster_analyzed{iCounter}=cluster_analyzed{iCounter};
            
        end
        
    else
        
        clean_cluster_analyzed{iCounter}=cluster_analyzed{iCounter};
    end
    
    
end

end
