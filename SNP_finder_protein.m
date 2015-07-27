function SNP_structure=SNP_finder_protein(sequence_table,nm_all)
%SNP_FINDER_PROTEIN

counter_SNP=1;

idx_REF=find(strcmp(nm_all,'REF'));
Seq_REF=sequence_table(idx_REF,:);

%% Identify columns that have identical characters

for iCol=1:length(sequence_table)
    
    table_compared=sequence_table(:,iCol);
    x=[];
    
    % If all strings agree this comparison will return a single
    % value
    %if length(unique(table_compared))==1
    if ~(length(unique([table_compared{:}]))==1)
        
        %Variable position detected
        list={'A';'R';'N';'D';'C';'Q';'G';'H';'I';'L';'K';'M';'F';'P';'S';'T';'W';'Y';'V';'*'};
        
        %Determine the most common change
        Strains_with_a_given_SNP={};
        
        %Find the most common character and the strains that carry that SNP
        for iBasePair=1:length(list)
            
            %Find indeces of sequences that contain A's
            indeces=find(strcmp(table_compared,list{iBasePair})==1);
            Frequency_of_base_pair(iBasePair)=length(indeces);
            Strains_with_a_given_SNP{iBasePair}=indeces;
            %Strains_with_a_given_SNP{iBasePair}=find_strain(indeces,name_sequences);
            
            %% Determine the base pair in REF and use it as a reference (sequence 1)
            
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
