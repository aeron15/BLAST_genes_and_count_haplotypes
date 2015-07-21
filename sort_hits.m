function [allBlastResults_sorted, bestScore_counts]= sort_hits(allBlastResults)
%SORT_HITS based on a parameter. The parameter used to sort hits is the
%score of the blast hit

% The output list the best hit
%parameter= 'expect';
parameter= 'score';

for iHit=1:length(allBlastResults)
    
    try
        parameter_vector(iHit) = allBlastResults{iHit}.(parameter);
    catch %sometimes there is no hit
        parameter_vector(iHit) = nan;
        
    end
    
end

%Sort parameter
[hitScore,idx]=sort(parameter_vector,'descend');

%Hits that are equally good
bestScore_counts = sum(hitScore == max(hitScore));

blastResultCounter = 1;

%Sort data based on the parameter.
for k=1:length(idx)
    
    BestHit=allBlastResults{idx(k)}
    
    if ~ isempty(fieldnames(BestHit))
        allBlastResults_sorted(blastResultCounter).strain = BestHit.strain;
        allBlastResults_sorted(blastResultCounter).subject = BestHit.chromosome;
        allBlastResults_sorted(blastResultCounter).identity = BestHit.identities;%Aligned length
        allBlastResults_sorted(blastResultCounter).eValue = BestHit.expect;
        allBlastResults_sorted(blastResultCounter).score = BestHit.score;
        
        blastResultCounter = blastResultCounter+1;
        
    end
    
end


end