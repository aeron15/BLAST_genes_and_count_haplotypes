function blast_specific_plasmid (files_to_blast,path_data,PlasmidData_path,specificPlasmid)
%BLAST_SPECIFC_PLASMID blasts the sequences of a specific plasmid and
%creates the BLAST results strucutre with the best scores and common hits
%across blasts

for iFile=1:length(files_to_blast)
    
    %Remove extension of blasted files
    outputFile_name=remove_extension(files_to_blast{iFile});
    
    try% blasting
        
        [allBlastResults_sorted,bestScore_hits{iFile}] = blast_sequence(files_to_blast{iFile},path_data,PlasmidData_path);
        specificPlasmid_results(iFile).Sequence = files_to_blast{iFile};
        specificPlasmid_results(iFile).Result = allBlastResults_sorted;
        
    catch% catch blast not working
        display (['BLAST failed with ' outputFile_name]);
        
    end
    
end

%Determine common best hits across BLASTS. Use when there are several
%plasmid sequences
commonHits = determine_commonHits_across_BLASTs(bestScore_hits);

save(['../output_bioinformatics/BLAST_'  specificPlasmid], 'specificPlasmid_results','bestScore_hits','commonHits');

end