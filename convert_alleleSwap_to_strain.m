function newStrains=convert_alleleSwap_to_strain(strains)
%Convert allele swap names to strain backgrounds

load('AlleleSwapStrain_conversion')

for iStrain=1:length(strains)
   
    idx=find(strcmp(strains{iStrain},AlleleSwapStrain_conversion(:,1)));
    newStrains{iStrain}=AlleleSwapStrain_conversion{idx,2};
    
end


end