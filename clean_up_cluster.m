function clean_cluster_analyzed=clean_up_cluster(cluster_analyzed,strains)

%CLEAN_UP_CLUSTER renames the cluster to the sequence used in the
%setpoints_value structure so that the names match
%Column 1 in substitions is the experiment name
%Column 2 in substitution is the sequence name
%% List of substitutions. These are the strain names in the experiments. For information on how this list was generated see Mapping_strain_experiment_sequence.xls

load('substitution_list.mat')

%% Remove certain matches for 6 strains + REF
% Test remove BC187
StrainsRemoved_set={'REF','273614N','378604X','DBVPG6044','Y55','NCYC110','PW5'};

cluster_analyzed=setdiff(cluster_analyzed,StrainsRemoved_set);%Remove unwanted strains

for iCounter=1:length(cluster_analyzed)
    clean_cluster_analyzed{iCounter}=substitution_list{find(strcmp(substitution_list(:,2),cluster_analyzed{iCounter})),1};
end

if isempty(cluster_analyzed)
    clean_cluster_analyzed=[];
end

end
