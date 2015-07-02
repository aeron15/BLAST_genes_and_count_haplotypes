function protein_table=convert_to_protein(sequence_table,queryGene)
%CONVERT_TO_PROTEIN converts a sequence table to a protein table

startORF_table=1001;

%% Check that sequence is a multiple of 3
stopORF_table=size(sequence_table,2);
len_ORF=stopORF_table-1000;

R = rem(len_ORF,3);

if R
    len_ORF=len_ORF-R;

end
%%

% referencePath='/Users/RenanEscalante/Dropbox/Phenotypic_diversity/var_bioinfo/20141115_BLAST/doc/';
% conversion_table=csv2cell([referencePath '20150310_Genes_conversion.csv']);

conversion_table=csv2cell('20150310_Genes_conversion.csv');

query_genes_names=conversion_table(:,1);

idx=find(strcmp(queryGene,query_genes_names));

len_ORF=conversion_table{idx,3};

%%
sequence_table=sequence_table(:,startORF_table:startORF_table+len_ORF);

protein_table=cell(size(sequence_table,1),len_ORF./3);

% Make string for conversion

for iSeq=1:size(sequence_table,1)
    
    seq_tmp=sequence_table(iSeq,:);
    counter_pos=1;
    
    for iPos=1:length(seq_tmp)
        
        if ~(isempty(seq_tmp{iPos}))%sometimes there is a cell within a cell
            
            try
                seq2prot(counter_pos)=seq_tmp{iPos};
                counter_pos=counter_pos+1;
                
            catch
                %There is an insertion that we will expand
                insertion=seq_tmp{iPos}{:};
                
                %for i=1:length(insertion)
                
                seq2prot(counter_pos)=insertion(1);
                counter_pos=counter_pos+1;
                % end
                
            end
            
        else
            
            seq2prot(counter_pos)='N';
            counter_pos=counter_pos+1;
        end
        
    end
    
    seq2prot(regexp(seq2prot,'-'))='N';
    
    prot_seq=nt2aa(seq2prot,'ACGTOnly',false);
    
    for iPosProt=1:length(prot_seq)
        
        protein_table{iSeq,iPosProt}=prot_seq(iPosProt);
        
    end
    
end

end