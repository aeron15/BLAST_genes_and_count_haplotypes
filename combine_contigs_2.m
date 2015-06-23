function [consensus_sequence_string, consensus_sequence]=combine_contigs_2(blastResult,query_file,subject_file)

%COMBINE_CONTIGS_2 gets hits from BLAST and then matches the best local
%alignment for the strains
% Perhaps only use for strains that have contigs sequenced

% created by RE on 20150304
% modifed by RE on 20150309

% Load subject genome (for extracting hit sequences)
subject=fastaread(subject_file);

%Load the query sequence. We assume the sequence is always a fasta
%file for +/-1KB sequence
query=fastaread(query_file);
seq_query=query.Sequence;

%Get coordinates in the query genome for starting and stop base pairs for
%an ORF

%startORF=1001;
endORF=length(query.Sequence)-1000;
len_alignment_threshold=400;

%% Perform an alignment to determine where to match the hit and the query strain

nHits=length(blastResult.Hits);

names_contigs={subject.Header};
clean_contig_names=clean_name_contigs(names_contigs);



for iHit=1:nHits
    
    %Array with differnt lengths of hits
    array_len=[];
    counter_array=1;
    
    nHSPs=length(blastResult.Hits(iHit).HSPs);
    
    index_contig=find(strcmp(clean_contig_names,blastResult.Hits(iHit).Name));
    
    %Get start_subject and stop_subject_match from the best hits
    for Index_HSPs=1:nHSPs
        
        %Get the  length of the alignment
        %Extract index and find the top and bottom match of the alignment
        
        len_hit=blastResult.Hits(iHit).HSPs(Index_HSPs).AlignmentLength(1);
        
        if len_hit> len_alignment_threshold
            
            array_len(counter_array,1)=blastResult.Hits(iHit).HSPs(Index_HSPs).SubjectIndices(1);
            array_len(counter_array,2)= blastResult.Hits(iHit).HSPs(Index_HSPs).SubjectIndices(2);
            counter_array=counter_array+1;
            
        end
        
    end
    
    % Get the sequence of the subject
    
    start_subject_match=min(array_len(:));
    stop_subject_match=max(array_len(:));
    
    seq_subject=subject(index_contig).Sequence(start_subject_match:stop_subject_match);
    
    if ~isempty(start_subject_match)
        
        start_subject_match_cons=array_len(1,1);
        stop_subject_match_cons=array_len(1,2);
        
        % Determine if the sequence needs to be reversed complement
        
        if start_subject_match_cons>stop_subject_match_cons
            
            seq_subject=seqrcomplement(seq_subject);
            
        end
        
        
        [iPosition,seq_hit_subject_cell]=map_hit(seq_query,seq_subject);
        
        for iBase=1:length(seq_hit_subject_cell)
            
            table_assemble{iHit,iPosition}=seq_hit_subject_cell{iBase};
            iPosition=iPosition+1;
            
            
        end
        
    end
    
    
    
    
end

%% Count occurrences of each individual base and determine consensus. Keep the empty cells for the beggining of the cells.

[consensus_sequence_string, consensus_sequence]=find_consensus(table_assemble);

