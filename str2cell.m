function seq_tmp=str2cell(seq_subject)

%STR2CELL converts string to cell array for sequence analysis
% created by RE 20150305

ns=numel(seq_subject);
n = 1;
seq_tmp= cellstr(reshape([seq_subject repmat(' ',1,ceil(ns/n)*n-ns)],n,[])')';

end

