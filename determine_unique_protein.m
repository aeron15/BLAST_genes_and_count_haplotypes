function idx_identical_sequences=determine_unique_protein(SNP_structure, sequence_table, name_sequences,queryGene)

% DETERMINE_UNIQUE determines unique sequences according variation in
% sequence table


%% Extract variable positions in the alignment

variable_pos_index=[SNP_structure(:).Position];

variable_pos_index=unique(variable_pos_index);

%Create new sequence table
Variable_Pos={};

for index_pos=1:length(variable_pos_index)
    
    if index_pos==1
        
        Variable_Pos=sequence_table(:,variable_pos_index(index_pos));
        
    else
        
        Variable_Pos=[Variable_Pos sequence_table(:,variable_pos_index(index_pos))];
        
    end
    
end

%% Recode table to a numeric code

nRows=size(Variable_Pos,1);
nCols=size(Variable_Pos,2);

conversion_table=zeros(nRows,nCols);

for iRow=1:nRows
    for iCol=1:nCols
        try
            
            aa_analyzed=Variable_Pos{iRow,iCol};
            
            if strcmp(Variable_Pos{iRow,iCol},'?')
                
                aa_analyzed='-';
                
            end
            
            conversion_table(iRow,iCol)=replace_by_number(aa_analyzed);
            
        catch
            
            display(['error in determine unique protein sequence ' name_sequences{iRow}])
        end
    end
end

%% Determine unique rows, ia has the indeces of the unique rows , ic contains which combination in C is located where
[C, ia, ic] = unique(conversion_table,'rows');

%Unique strains in order in C
unique_strains={name_sequences{ia}}';

%Count how many strains have the sequences 1:28

number_seq_with_a_specific_combination = accumarray(ic,1);

% figure(1);
% plot(1:length(number_seq_with_a_specific_combination),number_seq_with_a_specific_combination,'o')
% ylim([0 5])
% xlabel('Sequence ID')
% ylabel({'Number of strains with a' ;'given sequence'})
%
% Set_fig_RE(figure(1),14,14,22);
% figure(2);
% title('Histogram of repeated sequences')
% hist(number_seq_with_a_specific_combination)
% xlabel({'Number of strains with a' ;'given sequence'})
%
% Set_fig_RE(figure(2),14,14,22);

%% According to C

%idx_identical_sequences={};
idx_identical_sequences={};

for idx=1:length(unique_strains)
    
    indeces=find(ic==idx);
    %idx_identical_sequences{idx}=find_strain(indeces,name_sequences);
    idx_identical_sequences(idx).Strains=find_strain_cell(indeces,name_sequences);
    idx_identical_sequences(idx).SNP_combination=C(idx,:);
    
end

%idx_identical_sequences=idx_identical_sequences';

% Sort alignment based on the sequence identities
end

%% Functions

function replacement=replace_by_number(str)
%* is a stop codon
%list={'A','T','C','G','-'};
list={'A';'R';'N';'D';'E';'C';'Q';'G';'H';'I';'L';'K';'M';'F';'P';'S';'T';'W';'Y';'V';'*';'-';'X'};

replacement=strmatch(str, list);

end