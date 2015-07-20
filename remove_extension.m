function inputFile_name=remove_extension(inputFile_name)

%Removes the extensions .fasta, .seq or .ab1 and blasts agains the genome

%Remove extension of blasted files
inputFile_name=regexprep(inputFile_name,'.seq','');
inputFile_name=regexprep(inputFile_name,'.fasta','');
inputFile_name=regexprep(inputFile_name,'.ab1','');

end