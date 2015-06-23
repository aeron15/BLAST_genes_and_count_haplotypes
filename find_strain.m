function tmp=find_strain(input_strain,strains_list)
%returns the index and set point value of a given strain
%names_strain={};

tmp='';

for iStrain=1:length(input_strain)
    
     %names_strain{iStrain}=strains_list{iStrain};
    
    tmp=[tmp ' ' strains_list{input_strain(iStrain)}];
    
end

end


