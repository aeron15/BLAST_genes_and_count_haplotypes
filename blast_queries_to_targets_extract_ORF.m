function blast_queries_to_targets_extract_ORF(queryGenes,targetStrains,path_data)
% BLAST_QUERIES_TO_TARGETS_EXTRACT_ORF runs BLAST of multiple query genes to
% multiple target ("subject") genomes.
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
        
        blastStrains_names{itarget}=targetStrains{itarget};
        blastStrains_sequences_cells{itarget}=consensus_sequence;
        
        %Export in fasta format
        QueryStrains_fasta(itarget).Header=targetStrains{itarget};
        QueryStrains_fasta(itarget).Sequence=consensus_sequence_string;
        
    end
    
    %% Create table for Liti strains. databaseStrains_sequences_cells is used for the haplotype generation and sequences_liti for fasta export
    %[databaseStrains_names,databaseStrains_sequences_cells,databaseStrains_sequencesFasta]=extractSequences_Liti(queryGenes{iquery},path_data);
    
    %Extract Skelly sequences and add it to analysis
    [databaseStrains_names,databaseStrains_sequences_cells,databaseStrains_sequencesFasta] = extractSequences_Skelly(queryGenes{iquery},path_data);
    
    %% Export fasta files. Export BLASTed sequences and sequences extracted from Skelly et al.
    FASTA_filename=['../output_bioinformatics/' queryGenes{iquery} '.fasta'];
    
    if exist(FASTA_filename)        
        command = ['rm ' FASTA_filename];
        system(command);
    end
    
    fastawrite(FASTA_filename, QueryStrains_fasta);
    fastawrite(FASTA_filename, databaseStrains_sequencesFasta);
    
    %% Combine BLASTED sequences and extracted sequences from the genome of Liti strains
    [sequence_table,All_names]=combine_sequences_names(blastStrains_names,blastStrains_sequences_cells,databaseStrains_names,databaseStrains_sequences_cells);
    save(['../output_bioinformatics/sequences_' queryGenes{iquery}],'sequence_table','All_names');
    
    %% Keep track of changes for McDonal-Kreitman test
    %[tot_changes,syn_changes,ns_changes]=compare_sequences_liti_BLAST(blastStrains_names,blastStrains_sequences_cells,databaseStrains_names,databaseStrains_sequences_cells,queryGenes{iquery},path_data);
    %     table_changes(iquery).Gene=queryGenes{iquery};
    %     table_changes(iquery).Total_Changes=tot_changes;
    %     table_changes(iquery).Synonymous_Changes=syn_changes;
    %     table_changes(iquery).Non_synonymous=ns_changes;
    
end

%save('output/table_changes','table_changes')

end