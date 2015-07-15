function driver_SNP_finder(queryGenes,path_data)

for iquery = 1:length(queryGenes)
    %% Identification of SNPs with respect to the reference strain S288C
    
    load(['../output_bioinformatics/sequences_' queryGenes{iquery}])
    identfy_SNPs(sequence_table,All_names,queryGenes{iquery},path_data)
end

end