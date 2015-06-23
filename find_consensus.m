function [consensus_sequence_string, consensus_sequence]=find_consensus(sequence_table)
%FIND_CONSENSUS_SEQUENCE_2 finds the consensus sequence of several sequences
% 20150303 verified to make sure that gaps are not inserted randomly
% 20150305 use to determine consensus sequence of a BLAST hit
% 20150309 modified to return a cell array

consensus_sequence={};

%Take the rows for each column in sequence table and combine them
%to create consensus sequence


for iCol=1:length(sequence_table)
    
    table_compared=sequence_table(:,iCol);
    x=[];% this is an array where characters are converted to numbers for computation of the mode
    
    % If all strings agree this comparison will return a single
    % value
    unique_characters=unique([sequence_table{:,iCol}]);
    
    if length(unique_characters)==1
        
        consensus_sequence{iCol}=unique_characters;
        
    else
        
        %If strings are different then take one with a character
        
        for iRow=1:size(table_compared,1)
            
            %Save index that matches a base pair, we don't include
            %'-' to avoid adding dashes to the the consensus
            %sequence
            
            list = {'A', 'T', 'C', 'G','N','-'};
            
            if ~ isempty(table_compared{iRow})
                
                try
                    
                    x(iRow) = strmatch(table_compared{iRow},list);
                    
                catch
                    
                    %Use the first letter of an insertion in case that
                    %comparison is needed
                    x(iRow) =strmatch(table_compared{iRow}{1}(1),list);
                end
                
            else
                x(iRow) =nan;
            end
            
        end
        
        %Remove the 0 from the array of indeces x
        
        %x(x==0)=[];
        
        % we remove Ns and '-' from the computation of the mode
        x(x==5)=[];
        x(x==6)=[];
        
        %x contains positions where there are ATCG, we can compare
        %whether all the positions have the same letter if they do
        %we are done with the consensus sequence
        
        try
            
            consensus_sequence{iCol}=list{mode(x)};
            
        catch
            
            consensus_sequence{iCol}=[];
            
        end
        
        
    end
    
end

%Concatenate all the sequences into a single character line. Sometimes the
%sequences are just character vectors

strs = [consensus_sequence{:}];
try
    strs_spaces = sprintf('%s' ,strs{:});
    consensus_sequence_string = strtrim(strs_spaces);
    
catch
    consensus_sequence_string = strtrim(strs);
end

end