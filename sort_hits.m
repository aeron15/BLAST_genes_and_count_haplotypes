function allBlastResults_sorted = sort_hits(allBlastResults)
%Sort hits based on a parameter. The parameter used to sort hits is the
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
[x,idx]=sort(parameter_vector,'descend');

%Sort data based on the parameter
for k=1:length(idx)
    
    BestHit=allBlastResults{idx(k)};
    
    if ~ isempty(fieldnames(BestHit))
        allBlastResults_sorted{k,1} = BestHit.strain;
        allBlastResults_sorted{k,2} = BestHit.chromosome;
        allBlastResults_sorted{k,3} = BestHit.identities;%Aligned length
        allBlastResults_sorted{k,4} = BestHit.expect;
        allBlastResults_sorted{k,5} = BestHit.score;
    end
end


end