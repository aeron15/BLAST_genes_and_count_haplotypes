function commonHits = determine_commonHits_across_BLASTs(bestScore_hits)
%DETERMINE_COMMONHITS_ACROSS_BLASTS determines common hits across
    
%commonHits = intersect(bestScore_hits{1},bestScore_hits{2});
 commonHits = intersectAll(bestScore_hits);
end