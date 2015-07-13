function files_to_blast=extract_files_to_blast(PlasmidData_path)

%Extracts all seq files for blasting

files_to_blast=dir([PlasmidData_path '*.seq']);

files_to_blast={files_to_blast.name};

end