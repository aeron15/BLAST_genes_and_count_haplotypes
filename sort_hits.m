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

parameter_vector=double(parameter_vector);

%Sort parameter
[hitScore,idx]=sort(parameter_vector,'descend');


%Hits that are equally good
bestScore_counts = sum(hitScore == max(hitScore));


%Sort data based on the parameter.
for k=1:length(idx)
    
    BestHit=allBlastResults{idx(k)};
    
    if ~ isempty(fieldnames(BestHit))
        allBlastResults_sorted(k).strain = BestHit.strain;
        allBlastResults_sorted(k).subject = BestHit.chromosome;
        allBlastResults_sorted(k).identity = BestHit.identities;%Aligned length
        allBlastResults_sorted(k).eValue = BestHit.expect;
        allBlastResults_sorted(k).score = BestHit.score;
    end
end


end