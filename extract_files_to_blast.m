function files_to_blast=extract_files_to_blast(PlasmidData_path,varargin)
%Look for a specific sequence and BLAST it

%% Parse parameters
p = inputParser;
addRequired(p,'PlasmidData_path',@isstr);
addParamValue(p,'specificPlasmid','*', @isstr);

parse(p,PlasmidData_path,varargin{:});

specificPlasmid=p.Results.specificPlasmid;
PlasmidData_path=p.Results.PlasmidData_path;
 
%Extracts all seq files for blasting

files_to_blast2=dir([PlasmidData_path specificPlasmid '*.fasta']);
files_to_blast1=dir([PlasmidData_path specificPlasmid '*.seq']);

files_to_blast={files_to_blast1.name files_to_blast2.name};

end