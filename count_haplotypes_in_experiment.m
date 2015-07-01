function HaplotypeCount=count_haplotypes_in_experiment(strains,get_orf_promoter)

% COUNT_HAPLOTYPES_IN_EXPERIMENT count haplotypes takes a list of strains and determines how many
%haplotypes there are in these list of strains using gene GAL3
%Sort haplotypes
%Check intersect
%Create new haplotypes
% There are 35 sequences because there are two Y9 strains

if get_orf_promoter
    load('output/DNA_DATA_PROMOTER_ORFS288C_YDR009W_GAL3_flanking.mat')
else
    load('output/DNA_DATA_ONLY_ORFS288C_YDR009W_GAL3_flanking.mat')
    
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
            %intersect has to be longer than 1
            %QueryStrain_cell
            
            strains_haplotype_count(counter)=len_haplotype;
            counter=counter+1;
            
            
        end
    end
    
end
%% Number of haplotypes

 HaplotypeCount=length(strains)-sum(strains_haplotype_count);



