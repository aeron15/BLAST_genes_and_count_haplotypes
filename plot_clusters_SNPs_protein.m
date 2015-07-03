
function plot_clusters_SNPs_protein(set_points_setvalue,strains,idx_identical_sequences,gene)

%PLOT_CLUSTERS_SNPs_PRTEIN
%just take 36 strains and not all of them
%sort based on the set point

clusters={idx_identical_sequences.Strains};
%% Get clusters from idx identical sequences

s=cellfun(@size,clusters,'uniform',false);%sort clusters
[trash is]=sortrows(cat(1,s{:}),-[1 2]);
clusters=clusters(is);


colors_vec=cbrewer('qual', 'Set1', 9);
colors_vec=repmat(colors_vec,5,1);

% Sort setpoints and the strains accordingly
[C,idx]=sort(set_points_setvalue);
new_strains=strains(idx)';

mark_size_plot=50;

hfig=figure('Position',[131         171        1124         634]);
hold all;
k_strain=1;

labels={};

for iCluster=1:length(clusters)
    
    cluster_analyzed=clusters{iCluster};
    
    %renames the cluster to the sequence used in the
    %setpoints_value structure so that the names match
    
    cluster_analyzed=clean_up_cluster(cluster_analyzed,new_strains);
        
    for iStrain=1:length(cluster_analyzed)
        
        try
            x=find(strcmp(new_strains,cluster_analyzed(iStrain)));
            y=C(x);
            
            x_strain=repmat(k_strain,length(y),1);
            
            cluster_analyzed(iStrain)
            plot(x_strain,y,'.','MarkerSize',mark_size_plot,'color',colors_vec(iCluster,:));
            ylim([-9 -3])
            vline(k_strain,'k--')
            
        catch
            
            display(['Strain ' cluster_analyzed{iStrain} ' not found'])
            %display([cluster_analyzed{iStrain}])
            x(iStrain)=nan;
            y(iStrain)=nan;
        end
        
        k_strain= k_strain+1;
        
    end
    
    %% If cluster had some strains they need to be clean out
    %new_strains_to_add=length(cluster_analyzed);
    labels=horzcat(labels,cluster_analyzed);
end


%%
xticklabel_rotate([1 : length(labels)],45,labels,'interpreter','none');
%title(['Clusters based on non coding and coding sequence of ' gene ' with ' num2str(length(clusters)) ' clusters']);
title(['Clusters based on coding sequence of ' gene ' with ' num2str(length(clusters)) ' clusters']);

ylim([-9 -3])

Set_fig_RE(hfig,16,16,18)
filename=['Clusters_PROT' gene];
export_fig(filename, '-pdf','-transparent','-nocrop');

close(hfig);

end




