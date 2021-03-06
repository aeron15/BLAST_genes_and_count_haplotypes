function add_entry_log(message,value)

%ADD_ENTRY_LOG adds a message, a descriptor and writes a log

if exist('../output_bioinformatics/log_results_bioinformatics.mat')
    load('../output_bioinformatics/log_results_bioinformatics.mat');
    %Get length of the log and extend it
    record_number=size(log_results,1);
else
    
    log_results={};
    record_number=0;
end

log_results{record_number+1,1}=message;%string
log_results{record_number+1,2}=value;%double


save('../output_bioinformatics/log_results_bioinformatics.mat','log_results')

end