function blast_sequence(file_to_blast,path_data,PlasmidData_path)

%BLAST sequence to the target Genome List
%
% This script assumes that each target genome sequence has been formatted
% into a BLAST database, which is true for all of the included Liti+Fay
% genomes. If you have added new target genomes, use the code in
% "format_blast_database.m" to generate databases first.

blastPath = [path_data 'blast-2.2.17-macosx/bin/blastall']; % BLAST executable (MacOSX)
queryPath = [path_data 'data/query_genes/'];     % contains FASTA files of query genes
targetPath = [path_data 'data/target_genomes/']; % contains FASTA files of target genomes

%Load all target strain names
%targetStrains = {'FL100'};

%Load all target strain names
load('target_all_strains_blast')

for itarget = 1:length(targetStrains)
    
     disp(['BLASTing ' file_to_blast ' to ' targetStrains{itarget} ' genome...']);
        
    % run blast
    blastResult = blastlocal('InputQuery',[PlasmidData_path file_to_blast],...
        'BlastPath',blastPath,...
        'database',[targetPath targetStrains{itarget} '.fasta'],...
        'program','blastn','Format',8,'BLASTArgs','-q -3 -r 1');
    
    % Load subject genome (for extracting hit sequences)
    targetGenome = fastaread([targetPath targetStrains{itarget} '.fasta']);
    
    % Extracts info from BLAST hits, filters out short hits, and merges hits
    % nearby the top hit.
    allBlastResults{itarget} = ProcessHits(blastResult, targetGenome,targetStrains{itarget} );
    
end

%save('allBlastResults','allBlastResults')

%Rank hits based on the E-value. Length of identities.
sort_hits(allBlastResults)

end