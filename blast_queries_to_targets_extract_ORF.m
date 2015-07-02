function blast_queries_to_targets_extract_ORF(queryGenes,targetStrains,path_data)

%%
% Runs BLAST of multiple query genes to multiple target ("subject")
% genomes.
%
% This script assumes that each target genome sequence has been formatted
% into a BLAST database, which is true for all of the included Liti+Fay
% genomes. If you have added new target genomes, use the code in
% "format_blast_database.m" to generate databases first.


blastPath = [path_data 'blast-2.2.17-macosx/bin/blastall']; % BLAST executable (MacOSX)

queryPath = [path_data 'data/query_genes/'];     % contains FASTA files of query genes
targetPath = [path_data 'data/target_genomes/']; % contains FASTA files of target genomes


%% BLAST query genes against target genomes

tic; % see how long things take
table_changes={};

% loop through query genes
for iquery = 1:length(queryGenes)
    for itarget = 1:length(targetStrains)
        disp(['BLASTing with ' queryGenes{iquery} ' to ' targetStrains{itarget} ' genome...']);
        
        % run blast
        blastResult = blastlocal('InputQuery',[queryPath queryGenes{iquery} '.fsa.txt'],...
            'BlastPath',blastPath,...
            'database',[targetPath targetStrains{itarget} '.fasta'],...
            'program','blastn','Format',8,'BLASTArgs','-q -3 -r 1');
        
        %Load subject genome
        subject_file=[targetPath targetStrains{itarget} '.fasta'];
        
        %Load the query sequence. We assume the sequence is always a fasta
        %file for +/-1KB sequence
        query_file=[queryPath queryGenes{iquery} '.fsa.txt'];
                       
        [consensus_sequence_string, consensus_sequence]=combine_contigs(blastResult,query_file,subject_file);
        
        names_genomes{itarget}=targetStrains{itarget};
        sequences_cells{itarget}=consensus_sequence;
        
    end
    
    %% Create table for Liti strains
    
    [names_genomes_Liti,sequences_cells_Liti]=extract_Liti(queryGenes{iquery},path_data);
    
    %Convert table sequences cells Liti to FASTA
    
    % Restrict to sequences of strains that we actually used in our study
    
    %% Compare to Liti strains
    
      compare_sequences_liti_BLAST(names_genomes,sequences_cells,names_genomes_Liti,sequences_cells_Liti,queryGenes{iquery},path_data);
     [tot_changes,syn_changes,ns_changes]=compare_sequences_liti_BLAST(names_genomes,sequences_cells,names_genomes_Liti,sequences_cells_Liti,queryGenes{iquery},path_data);
    
%     table_changes(iquery).Gene=queryGenes{iquery};
%     table_changes(iquery).Total_Changes=tot_changes;
%     table_changes(iquery).Synonymous_Changes=syn_changes;
%     table_changes(iquery).Non_synonymous=ns_changes;
    
end
toc;

%save('output/table_changes','table_changes')

end