function allBlastResults_sorted = sort_hits(allBlastResults)
%Sort hits based on a parameter, most likely E value but could also be
%length of the match
% The output list the best hit
%parameter= 'expect';
parameter= 'identities';

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
    
    BestHit=allBlastResults{idx(k)}
    
    if ~ isempty(fieldnames(BestHit))
        allBlastResults_sorted{k,1} = BestHit.strain;
        allBlastResults_sorted{k,2} = BestHit.chromosome;
        allBlastResults_sorted{k,3} = BestHit.identities;
        allBlastResults_sorted{k,4} = BestHit.expect;
    end
end


end