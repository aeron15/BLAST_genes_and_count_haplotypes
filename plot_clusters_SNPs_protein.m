
function plot_clusters_SNPs_protein(set_points_setvalue,strains,idx_identical_sequences,gene,filename)

%PLOT_CLUSTERS_SNPs_PROTEIN plots strains based on their haplotype. Each
%color represents a different haplotype.

clusters={idx_identical_sequences.Strains};

haplotype_type=filename;
filename=[filename gene];

%% Get clusters/haplotypes from idx identical sequences

s=cellfun(@size,clusters,'uniform',false);%sort clusters/haplotypes
[trash is]=sortrows(cat(1,s{:}),-[1 2]);
clusters=clusters(is);

colors_vec=cbrewer('qual', 'Set1', 9);
colors_vec=repmat(colors_vec,5,1);

% Sort setpoints and the strains
[C,idx]=sort(set_points_setvalue);
sortedStrains=strains(idx)';

mark_size_plot=50;

hfig=figure('Position',[131         171        1124         634]);
hold all;
k_strain=1;

labels={};
cluster_counter=0;

for iCluster=1:length(clusters)
    
    cluster_analyzed=clusters{iCluster};
    
    %renames the cluster to the sequence used in the
    %setpoints_value structure so that the names match
    cluster_analyzed=clean_up_cluster(cluster_analyzed);
    
    QueryStrain_cell=intersect(cluster_analyzed,sortedStrains);
    
    %if ~(isempty(cluster_analyzed))
    if ~(isempty(QueryStrain_cell))
    
        cluster_counter=cluster_counter+1;
    end
    
    for iStrain=1:length(cluster_analyzed)
        
        x=find(strcmp(sortedStrains,cluster_analyzed(iStrain)));
        y=C(x);
        
        if ~(isempty(x)|isempty(y))
            
            x_strain=repmat(k_strain,length(y),1);
            plot(x_strain,y,'.','MarkerSize',mark_size_plot,'color',colors_vec(iCluster,:));
            set_yaxis()
            vline(k_strain,'k--')
            k_strain= k_strain+1;
            labels=horzcat(labels,cluster_analyzed(iStrain));
            
        end

    end

end

%% Labels of strains
if strcmp(haplotype_type,'alleleSwaps_haplotypes_')
    
    labels=addlabels_GAL3alleleSwaps(labels);
    xticklabel_rotate([1 : length(labels)],45,labels,'interpreter','none');
    
else
    
    xticklabel_rotate([1 : length(labels)],45,labels,'interpreter','none');
    
end

title(['Haplotypes for  ' gene ' with ' num2str(cluster_counter) ' haplotypes'],'interpreter','none');

set_yaxis();

Set_fig_RE(hfig,16,16,18);
export_fig_specific_path(filename, '-pdf','-transparent','-nocrop');

close(hfig);

end




