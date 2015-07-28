function [HaplotypeCount, Number_SNPs]=count_haplotypes_in_experiment(strains,get_orf_promoter,QueryGene)

% COUNT_HAPLOTYPES_IN_EXPERIMENT count haplotypes takes a list of strains and determines how many
%haplotypes there are in these list of strains using gene GAL3
%Sort haplotypes
%Check intersect
%Create new haplotypes
% There are 35 sequences because there are two Y9 strains (Y9 and Y9
% combined)

if get_orf_promoter
    load(['../output_bioinformatics/DNA_PROMOTER_ORF' QueryGene '.mat'])
else
    load(['../output_bioinformatics/DNA_ONLY_ORF' QueryGene '.mat'])
end

%% Sort the haplotypes based on number of strains in the haplotype

AllStrains_haplotypes={DNA_idx_identical_sequences.Strains};
AllStrains_haplotypes=AllStrains_haplotypes';
s=cellfun(@size,AllStrains_haplotypes,'uniform',false);
[trash is]=sortrows(cat(1,s{:}),-[1 2]);
AllStrains_haplotypes=AllStrains_haplotypes(is);
counter=1;

for iCell=1:length(AllStrains_haplotypes)
    
    %Check first cell and see intersection
    if ~(length(AllStrains_haplotypes{iCell})==1)
        
        QueryStrain_haplotype=AllStrains_haplotypes{iCell};
        QueryStrain_cell=intersect(QueryStrain_haplotype,strains);
        
        len_haplotype=length(QueryStrain_cell);
        
        if len_haplotype>1
            
            %Count of haplotypes of strains with more than one strain in
            %the group
            strains_haplotype_count(counter)=len_haplotype;
            counter=counter+1;
            
            
        end
    end
    
end
%% Number of haplotypes
% The number of haplotypes is the number of strains minus the number of
% strains that are part of haplotypes with more than one strain

if exist('strains_haplotype_count')
    HaplotypeCount=length(strains)-sum(strains_haplotype_count);
    Number_SNPs=length(DNA_SNP_structure);
    
else %No halotypes with more than one strain were detected resulting in each strain belonging to a different haplotype
    HaplotypeCount=length(strains);
    Number_SNPs=length(DNA_SNP_structure);
    
    
end



