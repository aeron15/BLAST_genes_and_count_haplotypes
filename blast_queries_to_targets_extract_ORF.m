function blast_queries_to_targets_extract_ORF(queryGenes,targetStrains,path_data)
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
        
        %Export in fasta format
        QueryStrains_fasta(itarget).Header=targetStrains{itarget};
        QueryStrains_fasta(itarget).Sequence=consensus_sequence_string;
        
    end
    
    %% Create table for Liti strains
    [names_genomes_Liti,sequences_cells_Liti,sequences_liti]=extract_Liti(queryGenes{iquery},path_data);
    
    %% Export fasta files. sequences_liti (below) and QueryStrains_fasta can be combined to export a fasta file
    FASTA_filename=['output/' queryGenes{iquery} '.fasta'];
    fastawrite(FASTA_filename, QueryStrains_fasta);
    fastawrite(FASTA_filename, sequences_liti);
    
    %% Combine data names_genomes,sequences_cells,names_genomes_Liti,sequences_cells_Liti
    
    [sequence_table,All_names]=combine_sequences_names(names_genomes,sequences_cells,names_genomes_Liti,sequences_cells_Liti);
    
    %% Identification of SNPs with respect to the reference strain S288C
    identfy_SNPs(sequence_table,All_names,queryGenes{iquery},path_data)
    
    %% Keep track of changes for McDonal-Kreitman test
    %[tot_changes,syn_changes,ns_changes]=compare_sequences_liti_BLAST(names_genomes,sequences_cells,names_genomes_Liti,sequences_cells_Liti,queryGenes{iquery},path_data);
    %     table_changes(iquery).Gene=queryGenes{iquery};
    %     table_changes(iquery).Total_Changes=tot_changes;
    %     table_changes(iquery).Synonymous_Changes=syn_changes;
    %     table_changes(iquery).Non_synonymous=ns_changes;
    
end

%save('output/table_changes','table_changes')

end