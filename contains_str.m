function [tmp] = contains_str(input_str, test_str)
% Compares an input string (`input_str`) against another string (`test_str`). Returns `tmp` as 0 or 1.

tmp = ~isempty(strfind(input_str,test_str));

end
