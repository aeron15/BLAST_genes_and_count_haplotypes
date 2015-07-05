
function plot_clusters_SNPs_protein(set_points_setvalue,strains,idx_identical_sequences,gene)

%PLOT_CLUSTERS_SNPs_PROTEIN

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
cluster_counter=0;

for iCluster=1:length(clusters)
    
    cluster_analyzed=clusters{iCluster};
    
    %cluster_analyzed=clusters{8};%PW5 strain for testing purposes
    %renames the cluster to the sequence used in the
    %setpoints_value structure so that the names match
    cluster_analyzed=clean_up_cluster(cluster_analyzed);
    
    if ~(isempty(cluster_analyzed))
        cluster_counter=cluster_counter+1;
    end
    
    for iStrain=1:length(cluster_analyzed)
        
        try
            x=find(strcmp(new_strains,cluster_analyzed(iStrain)));
            y=C(x);
            
            x_strain=repmat(k_strain,length(y),1);
            plot(x_strain,y,'.','MarkerSize',mark_size_plot,'color',colors_vec(iCluster,:));
            set_yaxis()
            vline(k_strain,'k--')
            
        catch
            
            display(['Strain ' cluster_analyzed{iStrain} ' not found'])
            %display([cluster_analyzed{iStrain}])
            x(iStrain)=nan;
            y(iStrain)=nan;
        end
        
        k_strain= k_strain+1;
        
    end
    
    labels=horzcat(labels,cluster_analyzed);
end


%%
xticklabel_rotate([1 : length(labels)],45,labels,'interpreter','none');
%title(['Haplotypes for  ' gene],'interpreter','none');
title(['Haplotypes for  ' gene ' with ' num2str(cluster_counter) ' clusters'],'interpreter','none');

set_yaxis()

Set_fig_RE(hfig,16,16,18);
filename=['Clusters_' gene];
export_fig_specific_path(filename, '-pdf','-transparent','-nocrop');
close(hfig);

end




