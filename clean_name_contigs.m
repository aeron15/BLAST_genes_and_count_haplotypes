function clean_contig_names=clean_name_contigs(names_contigs)

%CLEAN_NAME_CONTIGS removes extra information from the names

for iContig=1:length(names_contigs)
    
    tmp=strsplit(names_contigs{iContig},' ');
    
    clean_contig_names{iContig}=tmp{1};
    
end

end