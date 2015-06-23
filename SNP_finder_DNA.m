function [SNP_structure,sequence_table]=SNP_finder_DNA(sequence_table,nm_all,get_orf_promoter,queryGene,path_data)
%Finds SNPs reported as a reference to S288C

startORF_table=1;%Starts 500 bp upstream of the start codong 1001
stopORF_table=size(sequence_table,2);


if get_orf_promoter
    
    conversion_table=csv2cell([path_data 'doc/20150310_Genes_conversion.csv']);
    
    query_genes_names=conversion_table(:,1);
    
    idx=find(strcmp(queryGene,query_genes_names));
    
    len_ORF=conversion_table{idx,3};

    sequence_table=sequence_table(:,startORF_table:(1001+len_ORF-1));
    
else
    % ORF version of the script
    
    len_ORF=stopORF_table-1000;
    
    R = rem(len_ORF,3);%check that the length is a multiple of 3 for coding conversion
    
    if R
        len_ORF=len_ORF-R;
        
    end
    
    sequence_table=sequence_table(:,1001:len_ORF);
end

%%

counter_SNP=1;

idx_REF=find(strcmp(nm_all,'REF'));
Seq_REF=sequence_table(idx_REF,:);

for iCol=1:length(sequence_table)
    
    table_compared=sequence_table(:,iCol);
    x=[];
    
    % If all strings agree this comparison will return a single
    % value
    %if length(unique(table_compared))==1
    if ~(length(unique([table_compared{:}]))==1)
        
        %Variable position detected
        list = {'A', 'T', 'C', 'G'};
        
        %Determine the most common change
        Strains_with_a_given_SNP={};
        
        %Find the most common character and the strains that carry that SNP
        for iBasePair=1:length(list)
            
            %Find indeces of sequences that contain A's
            indeces=find(strcmp(table_compared,list{iBasePair})==1);
            Frequency_of_base_pair(iBasePair)=length(indeces);
            Strains_with_a_given_SNP{iBasePair}=indeces;
            %Strains_with_a_given_SNP{iBasePair}=find_strain(indeces,name_sequences);
            
            % Determine the base pair in YJM978 and use it as a reference (sequence 1)
            
            Ref_Seq=Seq_REF{iCol};
            
            if (~isempty(indeces) & ~strcmp(Ref_Seq,list{iBasePair}))
                
                SNP_structure(counter_SNP).Position=iCol;
                SNP_structure(counter_SNP).Change=[Ref_Seq '->' list{iBasePair}];
                %SNP_structure(counter_SNP).Strains=indeces;
                SNP_structure(counter_SNP).Strains=find_strain(indeces,nm_all);
                SNP_structure(counter_SNP).Name=list{iBasePair};
                SNP_structure(counter_SNP).Number_of_SNPs=length(indeces);
                
                %Change code to only list the SNPs with respect to the
                %reference if they are identical then they are of no
                %interest (right?)
                %Check what the deal is with 7 and 21
                
                counter_SNP=counter_SNP+1;
                
            end
            
        end
        
    end
    
end

end