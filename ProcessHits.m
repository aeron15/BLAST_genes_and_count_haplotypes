function allhits = ProcessHits(blastResult, targetGenome)
% PROCESSHITS takes the results of a single BLAST of query gene to target
% genome, filters out short hits, and merges hits on a given chromosome
% that are within a certain distance of the top hit. Returns a struct array
% with the chromosome name, position, and sequence of each hit. Hits 
% on reverse strand are returned as reverse-complement.
% 
% Created 20141113 JW
%
% Updated 20141205 JW: Fixed bug that uses an entire header line as contig
% name instead of just the first word; fixed bug that tries to grab
% flanking sequence past the end of a chromosome.

% parameters
minlength = 300;    % minimum length to count as hit
mergedist = 500;    % hits this close to top hit are merged
flanking = 1000;     % flanking sequence to extract from subject genome

% names of chromosomes of target genome
allHeaders = {targetGenome.Header}';
contigNames = {};
for icontig = 1:length(allHeaders)
    tokens = regexp(allHeaders{icontig},'\s+','split');
    contigNames{icontig} = tokens{1};
end

allhits = struct;

ihit = 1;   % index of hits to keep

% loop through subject chromosomes
for ichr = 1:length(blastResult.Hits)
    HSPs = blastResult.Hits(ichr).HSPs;
    ichrTarget = find(strcmp(contigNames, blastResult.Hits(ichr).Name));
    
    % loop through hits on current chromosome
    itophit = ihit;
    for ihsp = 1:length(HSPs)
        len = HSPs(ihsp).AlignmentLength;
            
        % filter on hit length
        if len > minlength  
            allhits(ihit).chromosome = blastResult.Hits(ichr).Name; % contig/chrom name
            allhits(ihit).length = len;
            
            start = HSPs(ihsp).SubjectIndices(1);
            stop = HSPs(ihsp).SubjectIndices(2);
            allhits(ihit).start = start;
            allhits(ihit).stop = stop;
            
            % extract sequence from subject genome, including flanking
            % regions
            low = min([start stop]) - flanking;
            hi = max([start stop]) + flanking;
            chrLength = length(targetGenome(ichrTarget).Sequence);
            allhits(ihit).sequence = ...
                targetGenome(ichrTarget).Sequence(max(low,1):min(hi,chrLength));
            
            if ihsp == 1
                itophit = ihit;
            end
            ihit = ihit + 1;
        end
        
        % merge hits near the genomic location of top hit
        if ihit - 1 > itophit    % more than 1 hit on this chromosome
            idx1 = [allhits(itophit).start allhits(itophit).stop];
            
            % compare remaining hits against top hit
            ihit2 = itophit + 1;
            while ihit2 <= ihit-1
                idx2 = [allhits(ihit2).start allhits(ihit2).stop];
                
                % if either end of hits are within MERGEDIST
                if min(abs([idx1 - idx2 idx1 - fliplr(idx2)])) < mergedist
                    % replace top hit with merged hit
                    % does not preserve order of start/stop indices
                    low = min([idx1 idx2]);
                    hi = max([idx1 idx2]);
                    allhits(itophit).start = low;
                    allhits(itophit).stop = hi;
                    allhits(itophit).sequence = ...
                        targetGenome(ichrTarget).Sequence((low-flanking):(hi+flanking));
                    
                    % remove lower hit used in merge
                    allhits(ihit2) = [];
                    
                    % decrease total hits on this chromosome
                    ihit = ihit - 1;
                else
                    % hit does not need to be merged, check next hit
                    ihit2 = ihit2 + 1;
                end
            end
        end
    end
end