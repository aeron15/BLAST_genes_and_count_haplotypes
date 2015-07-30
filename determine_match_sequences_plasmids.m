function determine_match_sequences_plasmids()
%DETERMINE_MATCH_SEQUENCES_PLASMIDS extract all the sequence from a folder
%and BLAST against all cerevisiae genomes. Export results of BLAST when
%sorted

tic

PlasmidData_path='../data_bioinformatics/data_plasmid/';

%Path to the data and BLAST location
path_data='../data_bioinformatics/';

specificPlasmid='RB53';%'*' blasts every sequence in the folder

files_to_blast=extract_files_to_blast(PlasmidData_path,'specificPlasmid', specificPlasmid);

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

toc

%Determine common best hits across BLASTS. Use when there are several
%plasmid sequences
commonHits = determine_commonHits_across_BLASTs(bestScore_hits);

save(['../output_bioinformatics/BLAST_'  specificPlasmid], 'specificPlasmid_results','bestScore_hits','commonHits');

end