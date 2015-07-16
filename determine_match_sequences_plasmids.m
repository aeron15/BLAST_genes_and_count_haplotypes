function determine_match_sequences_plasmids()
%function determine_match_sequences_plasmids(path_data)

%extract all the sequence from a folder. These are sequences that came from
%a plasmid sequencing. Return a list of hits that are good

PlasmidData_path='/Users/RenanEscalante/Dropbox/Phenotypic_diversity/var_cloning/20150626_GAL3_plasmids/10-301507723_seq/';

%Path to the data and BLAST location
path_data='/Users/RenanEscalante/Dropbox/Phenotypic_diversity/var_bioinfo/20141115_BLAST/';

files_to_blast=extract_files_to_blast(PlasmidData_path);

for iFile=1:length(files_to_blast)
    
    allBlastResults_sorted = blast_sequence(files_to_blast{iFile},path_data,PlasmidData_path)
    
    hitScore =cell2mat(allBlastResults_sorted (:,3))
    
    %Hits that are equally good
    sum(hitScore == max(hitScore))
end

end