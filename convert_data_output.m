function data_output=convert_data_output(data_output)
%Convert data output to strain background names

 for iStrain=1:length(data_output)
     
     queryStrain=convert_alleleSwap_to_strain({data_output(iStrain).strain});
     data_output(iStrain).strain=queryStrain{1};
     
 end

end
