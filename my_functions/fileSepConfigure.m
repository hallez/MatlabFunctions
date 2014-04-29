function [newFilePath] = fileSepConfigure(filePathVariable)
% Finds slash ('\', '/') in filePathVariable and configures to match
% standard file separator for current OS. Returns the configured path.
%
% Halle Zucker -- orig created 4/28/14. Based on Daniel Weissman code in
% preprocessing_batch_script_four_subjects_HALLE.rtf. 
% 
% Example:
% [newDataDir] = fileSepConfigure(dataDir) where dataDir =
% '/Users/hrzucker/Desktop/Data/RanganathLab/ABCD_Context/ABCD_GitTracked/Scripts/'
% and newDataDir_new would include the correct file separators for Mac vs.
% PC. Can set newfilepath to be the same name as filePathVariable in which
% case it would get overwritten with the new, converted filepath. 

backward_data_path=strfind(filePathVariable, '\');
forward_data_path=strfind(filePathVariable, '/');
total_data_path = [backward_data_path forward_data_path];
f=filesep; %finds the correct file separator for your operating system
filePathVariable(total_data_path)=f;%and replaces what the user entered with the correct separator 
newFilePath = filePathVariable;
end

