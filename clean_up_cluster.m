function clean_cluster_analyzed=clean_up_cluster(cluster_analyzed,strains)

%CLEAN_UP_CLUSTER renames the cluster to the sequence used in the
%setpoints_value structure so that the names match
%Column 1 in substitions is the experiment name
%Column 2 in substitution is the sequence name
%% List of substitutions. These are the strain names in the experiments

load('substitution_list.mat')

%% Remove certain matches for 6 strains + REF
% Test remove BC187
StrainsRemoved_set={'REF','273614N','378604X','DBVPG6044','378604X','Y55','NCYC110'};

%Do something about 1 size clusters

%%

for iCounter=1:length(cluster_analyzed)
        
    if isempty(find(strcmp(cluster_analyzed{iCounter},strains)))
        
        try
            %Compare sequences to cluster
            clean_cluster_analyzed{iCounter}=substitution_list{find(strcmp(substitution_list(:,2),cluster_analyzed{iCounter})),1};
            
        catch
            clean_cluster_analyzed{iCounter}=cluster_analyzed{iCounter};
            
        end
        
    else
        
        clean_cluster_analyzed{iCounter}=cluster_analyzed{iCounter};
    end
    
    
end

end
