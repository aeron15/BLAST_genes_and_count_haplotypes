function allBlastResults_sorted = sort_hits(allBlastResults)
%Sort hits based on a parameter, most likely E value but could also be
%length of the match
%parameter= 'expect';
parameter= 'identities';

for iHit=1:length(allBlastResults)
    
    try
        
        parameter_vector(iHit) = allBlastResults{iHit}.(parameter);
        
    catch
        
        parameter_vector(iHit) = nan;
        
    end
    
end

parameter_vector=double(parameter_vector);

%Sort parameter
[x,idx]=sort(parameter_vector,'descend');

%Sort data based on the parameter\

for k=1:length(idx)
    
    allBlastResults_sorted{k}=allBlastResults{idx(k)};
    
    
end


end