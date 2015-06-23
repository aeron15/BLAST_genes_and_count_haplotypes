function strains_found=find_strain_cell(indeces,name_sequences)

strains_found={};

for index=1:length(indeces)
    
    strains_found{index}=name_sequences{indeces(index)};
    
end

end