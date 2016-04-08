function [input_struct] = struct_fields_clear(input_struct,fields_to_clear)
% Clears out the specified fields (fields to clear) in a structure variable (input_struct)
%
%   Will loop across `fields_to_clear` checking if each one is currently a
%   field in `input_struct`. If the field currently exists, it will be
%   removed (`rmfield`). `fields_to_clear` should be specified as a cell
%   array of strings (e.g.,         
%   b_fields_clear_at_end_of_run = {'cur_run', 'cur_run_num', 'cur_betas_dir', 'outlier_trials'};
%   Output will overwrite original `input_struct`.
%
%   Example: [b] = struct_fields_clear(b,{'cur_run', 'cur_run_num'})
%
%   Based on: http://www.mathworks.com/matlabcentral/answers/29610-how-do-i-delete-a-field-variable-from-a-structure
%   Author: Halle R. Zucker

for ifield=1:length(fields_to_clear)
    if isfield(input_struct,fields_to_clear{ifield})
       input_struct = rmfield(input_struct, fields_to_clear{ifield}); 
    end
end

end

